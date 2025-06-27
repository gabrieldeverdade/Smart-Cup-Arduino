import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:poc_bluetooth/views/firebase_options.dart';
import 'package:poc_bluetooth/views/water_intake_repository.dart';
import 'views/greeting_text.dart';
import 'views/weekly_water_card.dart';
import 'views/progress_section.dart';
import 'views/motivation_text.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('pt_BR', null); // <- importante
  runApp(const MaterialApp(home: BleReceiver()));
}

class BleReceiver extends StatefulWidget {
  const BleReceiver({Key? key}) : super(key: key);

  @override
  State<BleReceiver> createState() => _BleReceiverState();
}

class _BleReceiverState extends State<BleReceiver> {
  String latestValue = "";
  int lastStableMl = 0;
  int totalConsumed = 0;
  Timer? stabilizationTimer;
  final WaterIntakeRepository _waterRepository = WaterIntakeRepository();

  BluetoothDevice? connectedDevice;

  bool isConnected = false;
  bool carregando = true;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    checkPermissions();
    startScan();
  }

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  Future<bool> checkPermissions() async {
    final statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();

    return statuses.values.every((status) => status.isGranted);
  }

  void startScan() async {
    print("🔍 Iniciando busca pelo dispositivo...");
    FlutterBluePlus.startScan();

    while (carregando) {
      List<ScanResult> results = await FlutterBluePlus.scanResults.first;

      for (ScanResult r in results) {
        print("🔎 Dispositivo encontrado: ${r.device.platformName}");

        if (r.device.platformName.contains("SmartCup - TI V Grupo 3")) {
          print("✅ Conectando ao dispositivo...");
          await FlutterBluePlus.stopScan();

          await connectToDevice(r.device);

          setState(() {
            carregando = false;
            isConnected = true;
          });
          break;
        }
      }

      await Future.delayed(const Duration(seconds: 1));

      if (!FlutterBluePlus.isScanningNow && carregando) {
        FlutterBluePlus.startScan();
      }
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      print("🔗 Conectando ao dispositivo...");
      await device.connect();
      connectedDevice = device;

      print("🎯 Conectado!");
      List<BluetoothService> services = await device.discoverServices();

      for (var service in services) {
        for (var characteristic in service.characteristics) {
          if (characteristic.properties.notify) {
            await characteristic.setNotifyValue(true);
            characteristic.onValueReceived.listen(onDataReceived);
          }
        }
      }
    } catch (e) {
      print("❌ Erro ao conectar: $e");
      isConnected = false;
    }
  }

  void onDataReceived(List<int> value) {
    final receivedStr = String.fromCharCodes(value);
    final int? receivedMl = int.tryParse(receivedStr);
    if (receivedMl == null) return;

    setState(() {
      latestValue = receivedMl.toString();
    });

    stabilizationTimer?.cancel();
    stabilizationTimer = Timer(const Duration(seconds: 3), () async {
      final diff = receivedMl - lastStableMl;
      if (diff > 0) {
        await _waterRepository.updateWaterIntake("gabriel_user", diff);
        print("💧 Novo consumo enviado para o Firebase: +$diff mL");
      }

      setState(() {
        totalConsumed += diff;
      });
    });
  }

  @override
  void dispose() {
    stabilizationTimer?.cancel();
    connectedDevice?.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('EEEE, d', 'pt_BR').format(DateTime.now());
    currentDate = currentDate.replaceAll('-', ' ');
    currentDate = currentDate.split(' ').map((word) {
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');

    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF171A23) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Color(0xFF171A23) : Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          currentDate,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: isDarkMode ? Colors.white : Color(0xFF171A23),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal:
                  14.0), // Padding horizontal para o ícone de notificação
          child: IconButton(
            icon: CircleAvatar(
              backgroundColor: isDarkMode ? Color(0xFF171A23) : Colors.white,
              child: Icon(Icons.notifications,
                  color: isDarkMode ? Colors.white : Color(0xFF171A23)),
            ),
            onPressed: () {},
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal:
                    14.0), // Padding horizontal para o ícone de modo noturno
            child: IconButton(
              icon: CircleAvatar(
                backgroundColor: isDarkMode ? Color(0xFF171A23) : Colors.white,
                child: Icon(Icons.nightlight_round,
                    color: isDarkMode ? Colors.white : Color(0xFF171A23)),
              ),
              onPressed: toggleDarkMode,
            ),
          ),
        ],
      ),
      body: !carregando
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Adicionado para espaçar os widgets
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GreetingText(
                        isDarkMode: isDarkMode,
                      ),
                      const SizedBox(height: 16),
                      WeeklyWaterCard(
                        isDarkMode: isDarkMode,
                      ),
                      const SizedBox(height: 42),
                      ProgressSection(
                        totalConsumedMl: totalConsumed,
                        isDarkMode: isDarkMode,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 12), // Padding inferior de 10
                    child: MotivationText(totalConsumedMl: totalConsumed),
                  ),
                ],
              ),
            ),
    );
  }
}
