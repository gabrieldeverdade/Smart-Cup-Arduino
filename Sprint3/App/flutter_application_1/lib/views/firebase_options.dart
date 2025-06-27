import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA6KjRvRf-azTy0ioHAl2iDOgP197JtWMg',
    appId: '1:682821928375:web:e896584abeea72150f9432',
    messagingSenderId: '682821928375',
    projectId: 'smart-cup-d7b95',
    authDomain: 'smart-cup-d7b95.firebaseapp.com',
    storageBucket: 'smart-cup-d7b95.firebasestorage.app',
    measurementId: 'G-YF7X2ERCBH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXVD0L-3kmXe3Mn3Ny_qJKVv6uS96SEoY',
    appId: '1:682821928375:android:cc9c6fb30371d5c40f9432',
    messagingSenderId: '682821928375',
    projectId: 'smart-cup-d7b95',
    storageBucket: 'smart-cup-d7b95.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAJC5R99KvbHQMVZ3TmUGbQaDZJeKylnbk',
    appId: '1:682821928375:ios:28b7c2fc5a5eb6ca0f9432',
    messagingSenderId: '682821928375',
    projectId: 'smart-cup-d7b95',
    storageBucket: 'smart-cup-d7b95.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAJC5R99KvbHQMVZ3TmUGbQaDZJeKylnbk',
    appId: '1:682821928375:ios:28b7c2fc5a5eb6ca0f9432',
    messagingSenderId: '682821928375',
    projectId: 'smart-cup-d7b95',
    storageBucket: 'smart-cup-d7b95.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA6KjRvRf-azTy0ioHAl2iDOgP197JtWMg',
    appId: '1:682821928375:web:ab81a6b406c7cb720f9432',
    messagingSenderId: '682821928375',
    projectId: 'smart-cup-d7b95',
    authDomain: 'smart-cup-d7b95.firebaseapp.com',
    storageBucket: 'smart-cup-d7b95.firebasestorage.app',
    measurementId: 'G-1CEH63J3NM',
  );

}