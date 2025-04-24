import 'package:commzy/src/data/dependency/init_dependency.dart';
import 'package:commzy/src/utils/nav-utils.dart';
import 'package:commzy/src/views/home/home-screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InjectDependency.injectDep();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: NavUtils.navKey,
      home: HomeScreen(),
      theme: ThemeData(useMaterial3: true),
    );
  }
}
