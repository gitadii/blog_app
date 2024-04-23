import 'dart:io';

import 'package:blog_app/core/theme/app_pallet.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/features/bloc/presentation/widgets/blog_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final blogTitleController = TextEditingController();
  final blogContentController = TextEditingController();
  List<String> chipCategories = [];
  File? image;

  @override
  void dispose() {
    super.dispose();
    blogContentController.dispose();
    blogTitleController.dispose();
  }

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Icon(
            Icons.done_rounded,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: selectImage,
                child: image != null
                    ? GestureDetector(
                        onTap: selectImage,
                        child: SizedBox(
                          height: 150.0,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              image!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      )
                    : DottedBorder(
                        color: AppPallete.borderColor,
                        strokeWidth: 3.0,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(15.0),
                        dashPattern: const [10, 4],
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 30.0,
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  CupertinoIcons.folder,
                                ),
                                Text(
                                  'Select your image',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    'Technology',
                    'Business',
                    'Entertainment',
                    'Programming',
                    'Finance',
                  ]
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () {
                              if (chipCategories.contains(e)) {
                                chipCategories.remove(e);
                              } else {
                                chipCategories.add(e);
                              }
                              setState(() {});
                            },
                            child: Chip(
                              label: Text(e),
                              color: chipCategories.contains(e)
                                  ? const MaterialStatePropertyAll(
                                      AppPallete.gradient1)
                                  : null,
                              side: chipCategories.contains(e)
                                  ? null
                                  : const BorderSide(
                                      color: AppPallete.borderColor,
                                    ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              BlogField(
                hint: 'Blog Title',
                controller: blogTitleController,
              ),
              const SizedBox(
                height: 10.0,
              ),
              BlogField(
                hint: 'Blog Content',
                controller: blogContentController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
