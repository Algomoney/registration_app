import 'dart:async';
import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'validators.dart';
import '../services/register_api.dart';
import '../models/registeration_model.dart';

class Bloc extends Object with Validators {
  final _photo = BehaviorSubject<File>();
  final _name = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  //TODO: Try to reduce the number of Streams
  final _age = BehaviorSubject<List<String>>();
  final _selectedAge = BehaviorSubject<String>();
  final _gender = BehaviorSubject<List<String>>();
  final _selectedGender = BehaviorSubject<String>();

  List<String> agesList = ['Age', '21', '22', '23', '24'];
  List<String> genderList = ['Male', 'Female', 'None'];

  RegisterApi api = RegisterApi();

  // Add data to Stream
  Observable<File> get photo => _photo.stream;
  Stream<String> get name => _name.transform(validateName);
  Stream<String> get email => _email.transform(validateEmail);
  Stream<String> get password => _password.transform(validatePassword);
  Observable<List<String>> get age => _age.stream;
  Observable<List<String>> get gender => _gender.stream;
  Observable<String> get selectedAge => _selectedAge.stream;
  Observable<String> get selectedGender => _selectedGender.stream;

  Stream<bool> get submitValid => Observable.combineLatest5(
      name, email, password, age, gender, (n, e, p, a, g) => true);

  // Change data
  Function(File) get changePhoto => _photo.add;
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

  Future<String> registerUser() async {
    final register = RegistrationModel(
        photo: _photo.value.path,
        name: _name.value,
        email: _email.value,
        password: _password.value,
        age: _selectedAge.value,
        gender: _selectedGender.value);

    final result = await api.postRegistrationRecord(register);

    return result;
  }

  void dispose() {
    _photo.close();
    _name.close();
    _email.close();
    _password.close();
    _age.close();
    _selectedAge.close();
    _gender.close();
    _selectedGender.close();
  }
}
