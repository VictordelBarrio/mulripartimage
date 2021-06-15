import 'package:blocpattern/src/bloc/provider.dart';
import 'package:blocpattern/src/pages/home_page.dart';
import 'package:blocpattern/src/pages/login_page.dart';
import 'package:blocpattern/src/pages/producto_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        theme: new ThemeData.light().copyWith(
            scaffoldBackgroundColor: const Color(0xFFF1F8E3),
            primaryColor: const Color(0xFF64FFDA),
            accentColor: const Color(0xFFA7FFEB),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: const Color(0xFF64FFDA),
              selectionColor: const Color(0xFFAAF8AA),
              selectionHandleColor: const Color(0xFF64FFDA),
            ),
            inputDecorationTheme: InputDecorationTheme(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent)))),
        debugShowCheckedModeBanner: false,
        title: 'Material App - Los Rieleros',
        initialRoute: 'Home',
        routes: {
          'Login': (BuildContext context) => LoginPage(),
          'Home': (BuildContext context) => HomePage(),
          'Productos': (BuildContext context) => ProductPage(),
        },
      ),
    );
  }
}
