// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../utils/app_color.dart';

//Image Picker Widget to be used where ever
class ImagePickerView extends StatelessWidget {
  const ImagePickerView({Key? key, this.file, this.image, required this.onPick})
      : super(key: key);

  // callback function onPick
  final ValueChanged<File> onPick;
  //background image if image is null
  final String? image;
  //nullable file value for background
  final File? file;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () async {
          final XFile? pickedFile =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            File localFile = File(pickedFile.path);
            int sizeInBytes = localFile.lengthSync();
            double sizeInMb = sizeInBytes / (1024 * 1024);
            if (sizeInMb > 2) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content:
                      Text('Please Select Image which is less than 2 MB.')));
              return;
            }
            CroppedFile? croppedFile =
                await ImageCropper().cropImage(sourcePath: pickedFile.path);
            if (croppedFile != null) {
              onPick(File(croppedFile.path));
            }
          }
        },
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.tertiaryColor,
              image: file != null
                  ? DecorationImage(
                      image: FileImage(file!),
                      fit: BoxFit.cover,
                    )
                  : image != null
                      ? DecorationImage(
                          image: NetworkImage(image!),
                          fit: BoxFit.cover,
                        )
                      : null,
            ),
            child: const PickImageLabel(),
          ),
        ),
      ),
    );
  }
}

class PickImageLabel extends StatelessWidget {
  const PickImageLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 44,
          color: AppColors.primaryColor,
          child: const Center(
            child: Text(
              "Pick Image",
            ),
          ),
        )
      ],
    );
  }
}
