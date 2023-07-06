import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/routes/router_config.dart';
import 'features/authentication/presentation/screen/login_screen.dart';
import 'features/authentication/presentation/screen/otp_screen.dart';
import 'features/questions/presentation/screen/homepage.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://tsqjnitbmizfrmcfjrmb.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRzcWpuaXRibWl6ZnJtY2Zqcm1iIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODUzNjQ1MDMsImV4cCI6MjAwMDk0MDUwM30.mzdsQhWN8cCSXy0mXBOATV6tTnevL-xgAAg3vLrUmlU',
  );
  runApp(ResponsiveSizer(
    builder: (context, orientation, screenType) {
      return MyApp();
    },
  ));
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppRouter();
  }
}
