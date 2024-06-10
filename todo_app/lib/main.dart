import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/date_picker_getx_controller.dart';
import 'package:todo_app/notification/notification_services.dart';
import 'package:todo_app/ui/add_task.dart';
import 'package:todo_app/ui/detail_screen.dart';
import 'package:todo_app/ui/ui_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => DateAndTimePickerEx());
  NotificationServices.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      key: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      //home: const TodoScreen(),
      routes: {
        '/': (context) => const TodoScreen(),
        '/details': (context) => const DetailScreen(payload: 'Item x'),
      },
    );
  }
}
