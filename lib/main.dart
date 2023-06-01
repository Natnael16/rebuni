import 'package:flutter/material.dart';

import 'core/utils/app_theme.dart';
import 'features/questions/presentation/screen/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme : appTheme,
      home: const HomePage(),
    );
  }
}

