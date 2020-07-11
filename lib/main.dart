import 'package:flutter/material.dart';
import 'package:legacy_store/screens/base/base_screen.dart';
import 'package:legacy_store/screens/login/login_screen.dart';
import 'package:legacy_store/models/product_manager.dart';
import 'package:legacy_store/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

import 'models/user_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Legacy Store',
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(20, 33, 61, 1),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: const Color.fromRGBO(20, 33, 61, 1),
          appBarTheme: const AppBarTheme(
            elevation: 0,
          ),
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case '/signup':
              return MaterialPageRoute(builder: (_) => SignUpScreen());
            case '/base':
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
