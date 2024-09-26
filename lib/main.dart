import 'package:flutter/material.dart';
import 'package:kakas_auth/providers/auth.provider.dart';
import 'package:kakas_auth/ui/screens/login.screen.dart';
import 'package:kakas_auth/ui/screens/me.screen.dart';
import 'package:kakas_auth/ui/screens/register.screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          AuthProvider()..loadToken(), // Load the token when the app starts
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/me': (context) => MeScreen(),
        },
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            // If token exists, navigate to MeScreen, otherwise show LoginScreen
            if (authProvider.token != null) {
              return MeScreen();
            } else {
              return LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
