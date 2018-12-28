import 'package:flutter/material.dart';

class ProfilePictureWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            height: 240.0,
            decoration: BoxDecoration(color: Colors.grey[300]),
            child: buildProfileArea(),
          ),
        ),
      ],
    );
  }

  Widget buildProfileArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        IconButton(
          iconSize: 170.0,
          icon: Icon(
            Icons.account_circle,
            color: Colors.grey[200],
          ),
          onPressed: () => changePhoto(),
        ),
        FlatButton(
          child: Text(
            'Change',
            style: TextStyle(color: Colors.redAccent),
          ),
          onPressed: () => changePhoto(),
        ),
      ],
    );
  }

  void changePhoto() {
    print('Account icon pressed');
  }
}
