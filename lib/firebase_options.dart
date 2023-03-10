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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCrx5KXqrBOxqBTa_ws4266Phkf0njvQU4',
    appId: '1:517163437366:web:43b7a584fd3faac62c3797',
    messagingSenderId: '517163437366',
    projectId: 'curiosity-9490a',
    authDomain: 'curiosity-9490a.firebaseapp.com',
    storageBucket: 'curiosity-9490a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDTesykLBIfoz0_5S7z9JuTXexaOxVd8B4',
    appId: '1:517163437366:android:89e8652f8fb9efcd2c3797',
    messagingSenderId: '517163437366',
    projectId: 'curiosity-9490a',
    storageBucket: 'curiosity-9490a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA8988UjNWTOc-IwughRmix5ZdOdfh3xEk',
    appId: '1:517163437366:ios:85818c5825d38f912c3797',
    messagingSenderId: '517163437366',
    projectId: 'curiosity-9490a',
    storageBucket: 'curiosity-9490a.appspot.com',
    iosClientId: '517163437366-616fov648qk1f05opmjf03h2jbsrla83.apps.googleusercontent.com',
    iosBundleId: 'com.shefeekae.curiosityApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA8988UjNWTOc-IwughRmix5ZdOdfh3xEk',
    appId: '1:517163437366:ios:85818c5825d38f912c3797',
    messagingSenderId: '517163437366',
    projectId: 'curiosity-9490a',
    storageBucket: 'curiosity-9490a.appspot.com',
    iosClientId: '517163437366-616fov648qk1f05opmjf03h2jbsrla83.apps.googleusercontent.com',
    iosBundleId: 'com.shefeekae.curiosityApp',
  );
}
