import 'dart:io';

import 'package:flutter/material.dart';

class ImageFrame extends StatelessWidget {
  final File file;
  final String url;
  ImageFrame.fromFile(this.file) : this.url = null;
  ImageFrame.fromNetwork(this.url) : this.file = null;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 80.1,
      backgroundColor: Colors.black,
      child: CircleAvatar(
        radius: 80,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 70,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: 70 - 0.1,
            backgroundColor: Colors.grey,
            backgroundImage: (file != null)
                ? FileImage(file)
                : (url != null)
                    ? NetworkImage(url)
                    : null,
            child: (file == null && url == null)
                ? Icon(
                    Icons.photo,
                    color: Colors.white,
                    size: 40,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
