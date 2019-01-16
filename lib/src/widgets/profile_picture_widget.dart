import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../blocs/provider.dart';

class ProfilePictureWidget extends StatefulWidget {
  createState() => _ProfilePictureWidget();
}

class _ProfilePictureWidget extends State<ProfilePictureWidget> {
  File _image;
  File _imageFile;

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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _image == null
            ? IconButton(
                iconSize: 170.0,
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.grey[200],
                ),
                onPressed: () => showPhotoSelector(context, bloc),
              )
            : GestureDetector(
                onTap: () => showPhotoSelector(context, bloc),
                child: Container(
                  margin: EdgeInsets.only(top: 10.0),
                  width: 170.0,
                  height: 170.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: FileImage(_imageFile),
                    ),
                  ),
                ),
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

  Future<dynamic> showPhotoSelector(BuildContext context, Bloc bloc) {
    return showModalBottomSheet(
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
                      onPressed: () async {
                        _image = await ImagePicker.pickImage(
                            source: ImageSource.camera);
                        bloc.changePhoto(_image);
                        setState(() {
                          _imageFile = _image;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    RaisedButton(
                      child: Text('Choose photo from gallery'),
                      onPressed: () async {
                        _image = await ImagePicker.pickImage(
                            source: ImageSource.gallery);

                        bloc.changePhoto(_image);
                        setState(() {
                          _imageFile = _image;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
