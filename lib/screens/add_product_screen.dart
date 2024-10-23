import 'package:aquaventures/services/add_product.dart';
import 'package:aquaventures/widgets/button_widget.dart';
import 'package:aquaventures/widgets/text_widget.dart';
import 'package:aquaventures/widgets/textfield_widget.dart';
import 'package:aquaventures/widgets/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final name = TextEditingController();
  final desc = TextEditingController();
  final note = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextWidget(
                text: 'Add New Product',
                fontSize: 24,
                color: Colors.black,
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(height: 40.0),
              imageURL == ''
                  ? GestureDetector(
                      onTap: () {
                        uploadPicture('gallery');
                      },
                      child: const Center(
                        child: Icon(
                          Icons.image,
                          size: 120.0,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : Center(
                      child: SizedBox(
                        width: 300,
                        height: 300,
                        child: Image.network(imageURL),
                      ),
                    ),
              TextFieldWidget(
                borderColor: Colors.blue,
                label: 'Name',
                controller: name,
              ),
              TextFieldWidget(
                borderColor: Colors.blue,
                label: 'Description',
                controller: desc,
              ),
              TextFieldWidget(
                borderColor: Colors.blue,
                label: 'Notes',
                controller: note,
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: ButtonWidget(
                  width: 300,
                  textColor: Colors.white,
                  color: Colors.blue[900]!,
                  label: 'Add Product',
                  onPressed: () {
                    addProduct(imageURL, name.text, desc.text, note.text);
                    showToast('Product Added Succesfully!');
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  late String fileName = '';

  late File imageFile;

  late String imageURL = '';

  Future<void> uploadPicture(String inputSource) async {
    final picker = ImagePicker();
    XFile pickedImage;
    try {
      pickedImage = (await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920))!;

      fileName = path.basename(pickedImage.path);
      imageFile = File(pickedImage.path);

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: AlertDialog(
                title: Row(
              children: [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Loading . . .',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'QRegular'),
                ),
              ],
            )),
          ),
        );

        await firebase_storage.FirebaseStorage.instance
            .ref('Pictures/$fileName')
            .putFile(imageFile);
        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref('Pictures/$fileName')
            .getDownloadURL();

        setState(() {});

        Navigator.of(context).pop();
        showToast('Image uploaded!');
      } on firebase_storage.FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }
}
