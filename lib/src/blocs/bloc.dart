import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'validators.dart';

class Bloc extends Object with Validators {
  final _name = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _age = BehaviorSubject<List<String>>();
  final _gender = BehaviorSubject<String>();

  List<String> items = ['Age', '21', '22', '23'];

  // Add data to Stream
  Stream<String> get name => _name.transform(validateName);
  Stream<String> get email => _email.transform(validateEmail);
  Stream<String> get password => _password.transform(validatePassword);
  Observable<List<String>> get age => _age.stream;

  Stream<bool> get submitValid => Observable.combineLatest4(
      name, email, password, age, (n, e, p, a) => true);

  // Change data
  Function(String) get changeName => _name.add;
  Function(String) get changeEmail => _email.add;
  Function(String) get changePassword => _password.add;

  void fetchItems() {
    _age.add(items);
  }

  // Send data to API endpoint
  int registerUser() {
    final validName = _name.value;
    final validEmail = _email.value;
    final validPassword = _password.value;
    final age = _age.value;

    print('Name is: $validName');
    print('Name is: $validEmail');
    print('Name is: $validPassword');
    // TODO: Capture value passed to Steam
    print('Age is: $age');

    return 1;
  }

  void dispose() {
    _name.close();
    _email.close();
    _password.close();
    _age.close();
    _gender.close();
  }
}
