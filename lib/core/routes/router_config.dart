import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rebuni/features/authentication/presentation/screen/otp_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../features/authentication/presentation/screen/login_screen.dart';
import '../../features/authentication/presentation/screen/sign_up_profile.dart';
import '../utils/colors.dart';
import '../utils/theme.dart';
import 'paths.dart' as path;

class AppRouter extends StatelessWidget {
  late final GoRouter _router;

  AppRouter({Key? key}) : super(key: key) {
    _router = GoRouter(
      initialLocation: path.login,
      routes: <GoRoute>[
        GoRoute(
          path: path.signUp,
          builder: (BuildContext context, GoRouterState state) =>
              const SignUp(),
        ),
        GoRoute(
          path: path.login,
          builder: (BuildContext context, GoRouterState state) => LoginPage(),
        ),
        GoRoute(
            path: path.otp,
            builder: (BuildContext context, GoRouterState state) {
              var extra = state.extra as Map<String, dynamic>;
              return OTPScreen(
                  otpMatch: extra['otpMatch'],
                  isFirstTimeUser: extra['isFirstTimeUser'],
                  phoneNumber: extra['phoneNumber']);
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      theme: appTheme);
}
