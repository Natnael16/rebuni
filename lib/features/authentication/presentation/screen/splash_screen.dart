import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/paths.dart' as path;
import '../../../../core/utils/colors.dart';
import '../../../../main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    if (!mounted) {
      return;
    }
    try {
      await supabase.auth.refreshSession();
      final session = supabase.auth.currentSession;
      if (session != null) {
        context.go(path.pagesHolder);
      } else {
        context.go(path.login);
      }
    } catch (e) {
      context.go(path.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text("Rebuni",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: primaryColor, fontWeight: FontWeight.bold))),
    );
  }
}
