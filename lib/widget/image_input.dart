// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/basic.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  //  _savedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    // final photoFile = await picker.pickImage(
    //   source: ImageSource.gallery,
    //   maxWidth: 600,
    // );
    if (imageFile == null) {
      return;
    }

    File tmpFile = File(
      imageFile.path,
    );
    final appDir = await getApplicationDocumentsDirectory();
    final String path = appDir.path;
    final String fileName = basename(tmpFile.path);
    final String fileExtension = extension(tmpFile.path);
    final tmpFile2 = await tmpFile.copy('${path}/$fileName$fileExtension');
    widget.onSelectImage(tmpFile2);

    // File tmpFile3 = File(photoFile.path);
    // final appDir1 = await getApplicationDocumentsDirectory();
    // final String pathh = appDir1.path;
    // final String fileName1 = basename(tmpFile3.path);
    // final String fileExtension1 = extension(tmpFile3.path);
    // final tmpFile4 = await tmpFile3.copy('${pathh}/$fileName1$fileExtension1');
    // widget.onSelectImage(tmpFile4);

    setState(() {
      _storedImage = tmpFile2;

      // _storedImage = File(imageFile.path);
      // _savedImage = tmpFile4;
      //  File(photoFile.path);
    });
    // final fileName = path.basename(imageFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).primaryColor,
            ),
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
