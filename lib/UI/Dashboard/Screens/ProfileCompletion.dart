// import 'dart:html';

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileCompletion extends StatefulWidget {
  @override
  _ProfileCompletionState createState() => _ProfileCompletionState();
}

class ImageInputAdapter {
  /// Initialize from either a URL or a file, but not both.
  ImageInputAdapter({this.file, this.url})
      : assert(file != null || url != null),
        assert(file != null && url == null),
        assert(file == null && url != null);

  /// An image file
  final File file;

  /// A direct link to the remote image
  final String url;

  /// Render the image from a file or from a remote source.
  Widget widgetize() {
    if (file != null) {
      return Image.file(file);
    } else {
      return FadeInImage(
        image: NetworkImage(url),
        placeholder: AssetImage("assets/images/placeholder.png"),
        fit: BoxFit.contain,
      );
    }
  }
}

class _ProfileCompletionState extends State<ProfileCompletion> {
  List<ImageInputAdapter> _images;
  final restaurantNameController = TextEditingController();
  final password_controller = TextEditingController();

  // final List<BlogImage> existingImages;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  child: Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('image/user'),
                    ),
                  ),
                ),
                TextField()
              ],
            )
          ],
        ),
      ),
    );
  }
}
