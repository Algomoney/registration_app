import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../blocs/provider.dart';

class ProfilePictureWidget extends StatefulWidget {
  createState() => _ProfilePictureWidget();
}

class _ProfilePictureWidget extends State<ProfilePictureWidget> {
  File _image;
  File file;
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
                      image: FileImage(file),
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
                      onPressed: () {
                        chooseCameraPhoto(bloc);
                        Navigator.of(context).pop();
                      },
                    ),
                    RaisedButton(
                      child: Text('Choose photo from gallery'),
                      onPressed: () async {
                        _image = await ImagePicker.pickImage(
                            source: ImageSource.gallery);
                        setState(() {
                          file = _image;
                        });
                        bloc.changePhoto(_image);

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
  }

  // TODO: Implement taking profile pic with camera
  // TODO: Use listener & Stream Builder to set state
  chooseCameraPhoto(Bloc bloc) async {
//    return StreamBuilder<Future<File>>(
//      stream: bloc.photo,
//      builder: (BuildContext context, AsyncSnapshot<Future<File>> snapshot) {
//        print('image: ${snapshot.data}');
//        var image = ImagePicker.pickImage(source: ImageSource.camera);
//        return FutureBuilder<File>(
//          future: image,
//          builder: (BuildContext context, AsyncSnapshot<File> photoSnapshot) {
//            bloc.changePhoto(image);
//          },
//        );
//      },
//    );
  }

  Widget choosePhotoGalleryPhoto(Bloc bloc) {
    //bloc.updatedPhoto.listen((data) => _image = data);
    return StreamBuilder<File>(
      stream: bloc.photo,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (!snapshot.hasData) {
          print('Loading');
          return Text('Loading...');
        }

        bloc.changePhoto(_image);
        print(bloc.photo.first);
        //bloc.updatePhoto(file);
        //bloc.updatedPhoto.listen((d) => _image = d);
        //var i = snapshot.data.path;
        //print(i);

//        return FutureBuilder<File>(
//          future: i,
//          builder: (BuildContext context, AsyncSnapshot<File> photoSnapshot) {
//            if (!photoSnapshot.hasData) {
//              print('No image');
//            }
//            bloc.updatedPhoto.listen((f) => file = f);
//            return Image.file(photoSnapshot.data);
//          },
//        );

//        bloc.updatedPhoto.listen((f) => _image = f);
//        print(snapshot.data.path);
//        //_image = snapshot.data;
//        return Image.file(snapshot.data);
      },
    );
  }
}
