// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCjbbLgp94WZ7u-8RKL9eqzwU7oATPM2YM',
    appId: '1:699497801372:android:ce1aac61980eb46938ef59',
    messagingSenderId: '699497801372',
    projectId: 'wechat-24b14',
    storageBucket: 'wechat-24b14.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBo1b4HU1lXxht2oLLsrni2KicjkB4Inxo',
    appId: '1:699497801372:ios:a7d8aadd68b835db38ef59',
    messagingSenderId: '699497801372',
    projectId: 'wechat-24b14',
    storageBucket: 'wechat-24b14.appspot.com',
    androidClientId: '699497801372-7d2ecqdgs17h1jeuhjo1tdm0m5v6bvcm.apps.googleusercontent.com',
    iosClientId: '699497801372-o7si9p34ol4uev3u6tpqvtrjudjou8hm.apps.googleusercontent.com',
    iosBundleId: 'com.harshRajpurohit.weChat',
  );
}
