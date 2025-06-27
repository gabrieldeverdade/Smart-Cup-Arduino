import 'package:flutter/material.dart';
import 'package:poc_bluetooth/painters/progress_painter.dart';
import 'package:poc_bluetooth/painters/wave_painter.dart';

class CircularWaveProgress extends StatefulWidget {
  final double percentage;
  final bool isDarkMode;

  const CircularWaveProgress({super.key, this.percentage = 0.0, this.isDarkMode = false});

  @override
  State<StatefulWidget> createState() => _CircularWaveProgressState();
}

class _CircularWaveProgressState extends State<CircularWaveProgress> with TickerProviderStateMixin {
  late final AnimationController _waveController;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  double _currentPercentage = 0.0;

  @override
  void initState() {
    super.initState();

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat();

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: widget.percentage).animate(_progressController);
    _progressController.forward();

    _currentPercentage = widget.percentage;
  }

  @override
  void didUpdateWidget(covariant CircularWaveProgress oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.percentage != _currentPercentage) {
      _progressController.reset();

      _progressAnimation = Tween<double>(
        begin: _currentPercentage,
        end: widget.percentage,
      ).animate(CurvedAnimation(
        parent: _progressController,
        curve: Curves.easeOut,
      ));

      _progressController.forward();
      _currentPercentage = widget.percentage;
    }
  }

  @override
  void dispose() {
    _waveController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (_, constraints) => Center(
                child: AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (_, __) => SphericalWaterRippleProgressBar(
                    progress: _progressAnimation,
                    waveAnimation: _waveController,
                    sphereRadius: constraints.biggest.shortestSide / 2,
                    isDarkMode: widget.isDarkMode,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class SphericalWaterRippleProgressBar extends StatelessWidget {
  const SphericalWaterRippleProgressBar({
    super.key,
    required Animation<double> progress,
    required Animation<double> waveAnimation,
    required this.sphereRadius,
    required this.isDarkMode, // Adicionado isDarkMode
  })  : _progress = progress,
        _waveAnimation = waveAnimation;

  final Animation<double> _progress;
  final Animation<double> _waveAnimation;
  final double sphereRadius;
  final bool isDarkMode; // Adicionado isDarkMode

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WavePainter(
        progress: _progress,
        waveAnimation: _waveAnimation,
        circleRadius: sphereRadius,
        isDarkMode: isDarkMode, // Passando isDarkMode para WavePainter
      ),
      foregroundPainter: ProgressPainter(
        progress: _progress,
        circleRadius: sphereRadius,
        isDarkMode: isDarkMode, // Passando isDarkMode para ProgressPainter
      ),
    );
  }
}