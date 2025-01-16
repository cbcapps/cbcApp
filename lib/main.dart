import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_ecommerce/AQS/Bindings/Landing_bindings.dart';
import 'package:ui_ecommerce/res/app_pages.dart';
import 'package:ui_ecommerce/locale/Locale_controller.dart';
import 'package:ui_ecommerce/locale/locale.dart';
import 'package:ui_ecommerce/AQS/models/CartModel.dart';
import 'package:ui_ecommerce/AQS/models/FavoriteModel.dart';
import 'package:intl/intl.dart';
import 'AQS/controllers/Cart_controller.dart';
import 'firebase_options.dart';
late SharedPreferences sharedPreferences;
var formatter = NumberFormat("#,###");
List<RemoteMessage> backgroundMessages = [];
Future<void> setCount(int count) async {
  print('Sending new count: $count');
  sharedPreferences.setInt('unread_notifications_count', count);
}
int notificationCount = 0;
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  if(message.messageId != null){
    int unreadCount = sharedPreferences.getInt('unread_notifications_count') ?? 0;
    unreadCount++;
    sharedPreferences.setInt('unread_notifications_count', unreadCount);
    FlutterAppBadger.updateBadgeCount(1);
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterAppBadger.updateBadgeCount(1);
  sharedPreferences = await SharedPreferences.getInstance();
  await Hive.initFlutter();
  Hive.registerAdapter(CartModelAdapter());
  Hive.registerAdapter(FavoriteModelAdapter());
  BoxCart = await Hive.openBox<CartModel>('Cart');
  await Future.delayed(const Duration(milliseconds: 300));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (Firebase.apps.isNotEmpty) {
    print('Firebase initialized successfully!');
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic('offers');
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        // Increment notification count when a new message is received
        int unreadCount =
            sharedPreferences!.getInt('unread_notifications_count') ?? 0;
        unreadCount++;
        setCount(unreadCount);
      }
    });
  } else {
    print('Failed to initialize Firebase.');
    // Handle the case where Firebase initialization failed
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  print('count is : ${sharedPreferences.getInt('unread_notifications_count')}');
  bool res = await FlutterAppBadger.isAppBadgeSupported();
  print('suppp : ${res}');
  runApp(const MyApp());
}

Locale_controller locale_controller = Get.put(Locale_controller());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: locale(),
      locale: locale_controller.inliaLang,
      title: 'CBC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Tajawal',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: Landing_bindings(),
      initialRoute: '/togather',
      getPages: appPages,
    );
  }
}
