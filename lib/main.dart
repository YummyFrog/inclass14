import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.notification?.body ?? 'No body'}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MessagingTutorial());
}

class MessagingTutorial extends StatelessWidget {
  const MessagingTutorial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Messaging',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Firebase Messaging'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String? title;

  const MyHomePage({Key? key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final FirebaseMessaging messaging;
  String? _fcmToken;
  String? _latestNotification;

  @override
  void initState() {
    super.initState();
    messaging = FirebaseMessaging.instance;
    _initializeMessaging();
  }

  Future<void> _initializeMessaging() async {
    // Request permissions (iOS only)
    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('Notification permissions: ${settings.authorizationStatus}');

    // Get and store FCM token
    _fcmToken = await messaging.getToken();
    print('FCM Token: $_fcmToken');
    
    // Subscribe to topic
    await messaging.subscribeToTopic("messaging");

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message received');
      setState(() {
        _latestNotification = message.notification?.body ?? 'No body';
      });

      if (message.notification != null && context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(message.notification?.title ?? 'Notification'),
            content: Text(message.notification?.body ?? ''),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              )
            ],
          ),
        );
      }
    });

    // Handle when app is opened from terminated state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('App opened from notification');
      setState(() {
        _latestNotification = message.notification?.body ?? 'No body';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('FCM Messaging Demo', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 30),
            if (_fcmToken != null) ...[
              const Text('Your FCM Token:'),
              const SizedBox(height: 10),
              SelectableText(
                _fcmToken!,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
            ],
            if (_latestNotification != null) ...[
              const Text('Last Notification:'),
              const SizedBox(height: 10),
              Text(
                _latestNotification!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
            if (_fcmToken == null)
              const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}