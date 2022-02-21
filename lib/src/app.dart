import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wecode_2021/src/home_screen/home_screen_view.dart';
import 'package:wecode_2021/src/jobs_screen/add_new_job_screen.dart';
import 'package:wecode_2021/src/jobs_screen/jobs_board_screen.dart';
import 'package:wecode_2021/src/jobs_screen/list_of_jobs_screen.dart';
import 'package:wecode_2021/src/login_screen/login_screen_view.dart';
import 'package:wecode_2021/src/notifications_test/Notification_test.dart';
import 'package:wecode_2021/src/privacy_policy/privacy_policy_screen.dart';
import 'package:wecode_2021/src/profile_screens/create_profile_screen.dart';
import 'package:wecode_2021/src/registeration_screen/register_screen.dart';
import 'package:wecode_2021/src/sql_plat/sql_test.dart';
import 'package:wecode_2021/src/student_dashboard/student_dashboard.dart';
import 'package:wecode_2021/src/student_screen/student_dashboard_screen.dart';
import 'package:wecode_2021/src/student_screen/student_linktree_view.dart';
import 'package:wecode_2021/src/student_screen/news_student_screen.dart';
import 'package:wecode_2021/src/trainers_screen/trainers_dashboard_screen_view.dart';
import 'package:wecode_2021/src/widgets/auth_handler.dart';

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);
  final String selectedLang = 'ar';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color.fromRGBO(126, 87, 194, 1),
          textTheme: TextTheme(
              bodyText1: TextStyle(
            fontSize: 18,
          )),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromRGBO(126, 87, 194, 1),
          )),
      // theme: ThemeData.dark(),
      initialRoute: '/studentLinktreeView',
      // initialRoute: '/trainersScreen',
      routes: {
        '/': (context) => AuthHandler(), //this has to be the Auth handler
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/createProfileScreen': (context) => CreateProfileScreen(),
        '/trainersScreen': (context) => TrainersScreenView(),
        '/privacyPolicyScreen': (context) => const PrivacyPolicyScreen(),
        '/studentDashboard': (context) => StudentDashboard(),
        '/studentLinktreeView': (context) => StudentLinktreeView(),
      },
    );
  }
}
