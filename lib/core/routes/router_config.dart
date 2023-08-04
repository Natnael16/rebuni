import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rebuni/features/authentication/presentation/screen/otp_screen.dart';
import 'package:rebuni/features/questions/presentation/screen/question_detail_page.dart';
import '../../features/authentication/presentation/screen/login_screen.dart';
import '../../features/authentication/presentation/screen/sign_up_profile.dart';
import '../../features/authentication/presentation/screen/splash_screen.dart';
import '../../features/questions/presentation/screen/add_answer.dart';
import '../../features/questions/presentation/screen/answer_detail.dart';
import '../../features/questions/presentation/screen/ask_question.dart';
import '../../features/questions/presentation/screen/discussion_detail.dart';
import '../../features/questions/presentation/screen/homepage.dart';
import '../utils/theme.dart';
import 'paths.dart' as path;

class AppRouter extends StatelessWidget {
  late final GoRouter _router;

  AppRouter({Key? key}) : super(key: key) {
    _router = GoRouter(
      initialLocation: path.splash,
      routes: <GoRoute>[
        GoRoute(
          path: path.splash,
          builder: (BuildContext context, GoRouterState state) =>
              const SplashPage(),
        ),
        GoRoute(
          path: path.signUp,
          builder: (BuildContext context, GoRouterState state) =>
              const SignUp(),
        ),
        GoRoute(
          path: path.login,
          builder: (BuildContext context, GoRouterState state) => const LoginPage(),
        ),
        GoRoute(
            path: path.otp,
            builder: (BuildContext context, GoRouterState state) {
              var extra = state.extra as Map<String, dynamic>;
              return OTPScreen(phoneNumber: extra['phoneNumber']);
            }),
        GoRoute(
            path: path.home,
            builder: (BuildContext context, GoRouterState state) => const HomePage()),
        GoRoute(
            path: path.ask,
            builder: (BuildContext context, GoRouterState state) =>
                const AskQuestion()),
        GoRoute(
            path: path.questionDetail,
            builder: (BuildContext context, GoRouterState state) {
              var extra = state.extra as Map<String, dynamic>;
              return QuestionDetail(question: extra['question']);
            }),
        GoRoute(
            path: path.answerDetail,
            builder: (BuildContext context, GoRouterState state) {
              var extra = state.extra as Map<String, dynamic>;
              return AnswerDetail(
                  answer: extra['answer'], question: extra['question']);
            }),
        GoRoute(
            path: path.discussionDetail,
            builder: (BuildContext context, GoRouterState state) {
              var extra = state.extra as Map<String, dynamic>;
              return DiscussionDetail(discussion: extra['discussion']);
            }),
        GoRoute(
            path: path.addAnswer,
            builder: (BuildContext context, GoRouterState state) {
              var extra = state.extra as Map<String, dynamic>;
              return AddAnswerPage(question: extra['question']);
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
