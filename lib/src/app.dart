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
        onGenerateRoute: routes,
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (BuildContext context) {
        final bloc = Provider.of(context);
        bloc.fetchItems();
        return RegistrationScreen();
      });
    } else {
      return MaterialPageRoute(builder: (BuildContext context) {
        return RegistrationScreen();
      });
    }
  }
}
