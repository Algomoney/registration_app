import 'dart:async';
import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'validators.dart';

class Bloc extends Object with Validators {
  final _photo = BehaviorSubject<File>();
  final _updatedPhoto = BehaviorSubject<File>();
  final _name = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _age = BehaviorSubject<List<String>>();
  final _selectedAge = BehaviorSubject<String>();
  final _gender = BehaviorSubject<List<String>>();
  final _selectedGender = BehaviorSubject<String>();

  List<String> agesList = ['Age', '21', '22', '23', '24'];
  List<String> genderList = ['Male', 'Female', 'None'];

  // Add data to Stream
  Observable<File> get photo => _photo.stream;
  Observable<File> get updatedPhoto => _updatedPhoto.stream;
  Stream<String> get name => _name.transform(validateName);
  Stream<String> get email => _email.transform(validateEmail);
  Stream<String> get password => _password.transform(validatePassword);
  Observable<List<String>> get age => _age.stream;
  Observable<List<String>> get gender => _gender.stream;
  // TODO: Add transformer to ensure selectedAge is a valid number
  Observable<String> get selectedAge => _selectedAge.stream;
  Observable<String> get selectedGender => _selectedGender.stream;

  Stream<bool> get submitValid => Observable.combineLatest5(
      name, email, password, age, gender, (n, e, p, a, g) => true);

  // Change data
  Function(File) get changePhoto => _photo.add;
  Function(File) get updatePhoto => _updatedPhoto.add;
  Function(String) get changeName => _name.add;
  Function(String) get changeEmail => _email.add;
  Function(String) get changePassword => _password.add;
  Function(String) get changeAge => _selectedAge.add;
  Function(String) get changeGender => _selectedGender.add;

  void fetchAges() {
    _age.add(agesList);
  }

  void fetchGenders() {
    _gender.add(genderList);
  }

  // TODO: Send data to API endpoint and return status code
  int registerUser() {
    final validPhoto = _photo.value;
    final validName = _name.value;
    final validEmail = _email.value;
    final validPassword = _password.value;
    final selectedAge = _selectedAge.value;
    final selectedGender = _selectedGender.value;

    print('Photo is: $validPhoto');
    print('Name is: $validName');
    print('Email is: $validEmail');
    print('Password is: $validPassword');
    print('Selected Age is: $selectedAge');
    print('Selected Gender is: $selectedGender');

    return 1;
  }

  void dispose() {
    _photo.close();
    _updatedPhoto.close();
    _name.close();
    _email.close();
    _password.close();
    _age.close();
    _selectedAge.close();
    _gender.close();
    _selectedGender.close();
  }
}
