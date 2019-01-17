class RegistrationModel {
  final String photo;
  final String name;
  final String email;
  final String password;
  final String age;
  final String gender;

  RegistrationModel(
      {this.photo,
      this.name,
      this.email,
      this.password,
      this.age,
      this.gender});

  RegistrationModel.fromJson(Map<String, dynamic> parsedJson)
      : photo = parsedJson['photo'] ?? '',
        name = parsedJson['name'] ?? '',
        email = parsedJson['email'] ?? '',
        password = parsedJson['password'] ?? '',
        age = parsedJson['age'] ?? '',
        gender = parsedJson['gender'] ?? '';

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "photo": photo,
      "name": name,
      "email": email,
      "password": password,
      "age": age,
      "gender": gender,
    };
  }
}
