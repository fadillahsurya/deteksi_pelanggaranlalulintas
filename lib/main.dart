import 'package:coba/pages/deteksi.dart';
import 'package:coba/pages/forgotpassword.dart';
import 'package:coba/pages/home_screen.dart';
import 'package:coba/pages/login_screen.dart';
import 'package:coba/pages/register_screen.dart';
import 'package:coba/pages/reset_password.dart';
import 'package:coba/pages/verification_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/verification': (context) => UserDetailsScreen(),
        '/home': (context) => FirstScreen(),
        '/deteksi': (context) => CameraScreen(),
        '/forgotpassword': (context) => ForgotPasswordPage(),
        '/reset_password': (context) => ResetPasswordPage(
            token: ModalRoute.of(context)?.settings.arguments as String),
      },
    );
  }
}
