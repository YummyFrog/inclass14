import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Handling background message: ${message.notification?.body}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Init local notifications
  const AndroidInitializationSettings androidInitSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initSettings =
      InitializationSettings(android: androidInitSettings);
  await flutterLocalNotificationsPlugin.initialize(initSettings);

  runApp(const MessagingTutorial());
}

class MessagingTutorial extends StatelessWidget {
  const MessagingTutorial({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Messaging',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Firebase Messaging'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FirebaseMessaging messaging;
  String? _fcmToken = 'Fetching FCM Token...';

  @override
  void initState() {
    super.initState();

    messaging = FirebaseMessaging.instance;

    // Request permission
    messaging.requestPermission();

    // Subscribe to topic
    messaging.subscribeToTopic("messaging");

    // Get token
    messaging.getToken().then((value) {
      print("FCM Token: $value");
      setState(() {
        _fcmToken = value;
      });
    });

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final String type = message.data['notificationType'] ?? 'regular';
      final String body = message.notification?.body ?? 'No message body';
      final String title = message.notification?.title ?? 'Notification';

      _showNotification(type, title, body);
    });

    // When message is clicked
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
  }

  void _showNotification(String type, String title, String body) async {
    const AndroidNotificationDetails regularDetails = AndroidNotificationDetails(
      'regular_channel',
      'Regular Notifications',
      channelDescription: 'This is for regular messages',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      color: Colors.blue,
      icon: '@mipmap/ic_launcher',
    );

    const AndroidNotificationDetails importantDetails = AndroidNotificationDetails(
      'important_channel',
      'Important Notifications',
      channelDescription: 'This is for important messages',
      importance: Importance.max,
      priority: Priority.high,
      color: Colors.red,
      playSound: true,
      enableVibration: true,
      icon: '@mipmap/ic_launcher',
    );

    final NotificationDetails platformDetails = NotificationDetails(
      android: type == 'important' ? importantDetails : regularDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Your FCM Token:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SelectableText(_fcmToken ?? 'Loading...'),
            const SizedBox(height: 30),
            const Text('Wait for notifications...'),
          ],
        ),
      ),
    );
  }
}
