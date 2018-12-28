import 'package:flutter/material.dart';
import '../blocs/provider.dart';
import '../widgets/profile_picture_widget.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Container(
      margin: EdgeInsets.all(0.0),
      child: ListView(
        children: <Widget>[
          ProfilePictureWidget(),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                nameField(),
                emailField(),
                passwordField(),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: profileDisclaimer(),
                ),
                ageDropdown(),
                Divider(
                  color: Colors.grey[900],
                  height: 3.0,
                ),
                genderDropdown(),
                Divider(
                  color: Colors.grey[900],
                  height: 3.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ageAndGenderDisclaimer(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: submitButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget nameField() {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Name',
        labelText: 'Name',
      ),
      onChanged: (String value) => print(value),
    );
  }

  Widget emailField() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
        labelText: 'Email',
      ),
      onChanged: (String value) => print(value),
    );
  }

  Widget passwordField() {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Password',
        labelText: 'Password',
      ),
      onChanged: (String value) => print(value),
    );
  }

  Widget profileDisclaimer() {
    return Text(
        'Your name will be public and we\'ll send updates to the email address you provide');
  }

  Widget ageDropdown() {
    List<String> items = ['Age', '21', '22', '23'];
    String currentItemSelected = 'Age';

    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: currentItemSelected,
        items: items.map((String dropdownItems) {
          return DropdownMenuItem<String>(
            value: dropdownItems,
            child: Text(dropdownItems),
          );
        }).toList(),
        hint: Text('Enter your age'),
        onChanged: (value) {
          // Update the state
          currentItemSelected = value;
          print(currentItemSelected);
        },
      ),
    );
  }

  Widget genderDropdown() {
    List<String> genders = ['Male', 'Female', 'None'];
    String currentItemSelected = 'None';

    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: currentItemSelected,
        items: genders.map((String dropdownItems) {
          return DropdownMenuItem<String>(
            value: dropdownItems,
            child: Text(dropdownItems),
          );
        }).toList(),
        hint: Text('Enter a gender'),
        onChanged: (String value) {
          currentItemSelected = value;
          print(currentItemSelected);
        },
      ),
    );
  }

  Widget ageAndGenderDisclaimer() {
    return Text(
        'Age and gender help improve recommendations but are not shown publicly.');
  }

  Widget submitButton() {
    return RaisedButton(
      child: Text(
        'Save',
        style: TextStyle(color: Colors.white, fontSize: 20.0),
      ),
      color: Colors.blue,
      onPressed: () => print('Save button pressed'),
    );
  }
}
