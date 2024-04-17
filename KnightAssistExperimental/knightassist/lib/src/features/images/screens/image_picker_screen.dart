import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knightassist/src/config/routing/app_router.dart';
import 'package:knightassist/src/features/images/providers/images_provider.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/global/states/future_state.codegen.dart';
import 'package:knightassist/src/global/widgets/custom_dialog.dart';
import 'package:knightassist/src/global/widgets/custom_text.dart';
import 'package:knightassist/src/global/widgets/custom_text_button.dart';
import 'package:knightassist/src/global/widgets/scrollable_column.dart';
import 'package:knightassist/src/helpers/constants/app_colors.dart';

class ImagePickerScreen extends ConsumerStatefulWidget {
  final String type;
  final String id;
  final String ogImagePath;

  const ImagePickerScreen(
      {super.key,
      required this.type,
      required this.id,
      required this.ogImagePath});

  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends ConsumerState<ImagePickerScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  bool uploadStatus = false;

  _imageFromGallery() async {
    final pickedImage =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedImage == null) {
      return;
    }
    final File fileImage = File(pickedImage.path);
    setState(() {
      _image = fileImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final imageProv = ref.watch(imagesProvider);

    ref.listen<FutureState<String>>(
      imageStateProvider,
      (previous, imageState) async {
        imageState.maybeWhen(
          data: (message) async {
            await showDialog<bool>(
              context: context,
              builder: (ctx) => CustomDialog.alert(
                title: 'Success',
                body: message,
                buttonText: 'OK',
                onButtonPressed: () => AppRouter.pop(true),
              ),
            );
          },
          failed: (reason) async {
            await showDialog<bool>(
              context: context,
              builder: (ctx) => CustomDialog.alert(
                title: 'Failed',
                body: reason,
                buttonText: 'Retry',
              ),
            );
          },
          orElse: () {},
        );
      },
    );

    return Scaffold(
      body: SafeArea(
        child: ScrollableColumn(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Icon
                  InkResponse(
                    radius: 26,
                    child: const Icon(
                      Icons.arrow_back_sharp,
                      size: 32,
                      color: Colors.white,
                    ),
                    onTap: () => AppRouter.pop(),
                  ),
                  // Title
                  const CustomText(
                    'Image Picker',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 32),
                ],
              ),
            ),
            Center(
              child: widget.type == "1" || widget.type == "4"
                  ? Container(
                      width: double.infinity,
                      constraints:
                          const BoxConstraints(maxHeight: 250, minHeight: 200),
                      child: (_image != null)
                          ? Image(image: FileImage(_image!))
                          : CachedNetworkImage(
                              imageUrl: widget.ogImagePath,
                              fit: BoxFit.cover,
                            ),
                    )
                  : (_image != null)
                      ? Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: FileImage(_image!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: widget.ogImagePath,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomTextButton(
                color: AppColors.primaryColor,
                padding: const EdgeInsets.all(10),
                onPressed: () {
                  _imageFromGallery();
                },
                child: const Center(
                  child: Text(
                    'Pick Image',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: CustomTextButton(
                color: AppColors.primaryColor,
                padding: const EdgeInsets.all(10),
                onPressed: () async {
                  if (_image != null) {
                    await imageProv.storeImage(
                        type: widget.type, id: widget.id, file: _image!);
                  } else {
                    await showDialog(
                      context: context,
                      builder: (ctx) => const CustomDialog.alert(
                        title: 'No Image Picked',
                        body: 'You have not picked a new image.',
                        buttonText: 'OK',
                      ),
                    );
                  }
                },
                child: Consumer(
                  builder: (context, ref, child) {
                    final imageState = ref.watch(imageStateProvider);
                    return imageState.maybeWhen(
                      loading: () => const Center(
                        child: SpinKitRing(
                          color: Colors.white,
                          size: 30,
                          lineWidth: 4,
                          duration: Duration(milliseconds: 1100),
                        ),
                      ),
                      orElse: () => child!,
                    );
                  },
                  child: const Center(
                    child: Text(
                      'Upload Image',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
