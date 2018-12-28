import 'package:flutter/material.dart';
import 'blocs/provider.dart';
import 'screens/registration_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Registration App',
        theme: ThemeData.light(),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Registration App'),
          ),
          body: RegistrationScreen(),
        ),
      ),
    );
  }
}
