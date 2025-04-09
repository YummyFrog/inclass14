import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  print('Background message: ${message.notification?.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  runApp(const MessagingTutorial());
}

class MessagingTutorial extends StatelessWidget {
  const MessagingTutorial({super.key});

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
  const MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FirebaseMessaging messaging;
  String? notificationText;

  @override
  void initState() {
    super.initState();

    // Initialize Firebase Messaging instance
    messaging = FirebaseMessaging.instance;

    // Subscribe to a topic
    messaging.subscribeToTopic("messaging");

    // Get and print the device FCM token
    messaging.getToken().then((value) {
      print('FCM Token: $value');
    });

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("Message received");
      print("Body: ${event.notification?.body}");
      print("Data: ${event.data}");

      // Show alert dialog when notification arrives
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Notification"),
            content: Text(event.notification?.body ?? "No message body"),
            actions: [
              TextButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    });

    // Handle when the app is opened from a notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ''),
      ),
      body: const Center(
        child: Text("Messaging Tutorial"),
      ),
    );
  }
}
