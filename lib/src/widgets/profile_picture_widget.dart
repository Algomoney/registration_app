import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../blocs/provider.dart';

class ProfilePictureWidget extends StatelessWidget {
  File _image;
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            height: 240.0,
            decoration: BoxDecoration(color: Colors.grey[300]),
            child: buildProfileArea(bloc, context),
          ),
        ),
      ],
    );
  }

  Widget buildProfileArea(Bloc bloc, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        IconButton(
          iconSize: 170.0,
          icon: Icon(
            Icons.account_circle,
            color: Colors.grey[200],
          ),
          onPressed: () => chooseCameraPhoto(bloc),
        ),
        FlatButton(
          child: Text(
            'Change',
            style: TextStyle(color: Colors.redAccent),
          ),
          onPressed: () => showPhotoSelector(context, bloc),
        ),
      ],
    );
  }

  Future<Widget> showPhotoSelector(BuildContext context, Bloc bloc) {
    final s = showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Take a picture'),
                      onPressed: () {
                        chooseCameraPhoto(bloc);
                        Navigator.of(context).pop();
                      },
                    ),
                    RaisedButton(
                      child: Text('Choose photo from gallery'),
                      onPressed: () {
                        choosePhotoGalleryPhoto(bloc);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        });

    return s;
  }

  Future<File> chooseCameraPhoto(Bloc bloc) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    _image = image;
  }

  Future<File> choosePhotoGalleryPhoto(Bloc bloc) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _image = image;
  }
}
