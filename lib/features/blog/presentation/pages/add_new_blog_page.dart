import 'dart:io';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallet.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final blogTitleController = TextEditingController();
  final blogContentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> topics = [];
  File? image;

  @override
  void dispose() {
    super.dispose();
    blogContentController.dispose();
    blogTitleController.dispose();
  }

// Image selector function
  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

// Function will be called when the add-new-blog button is clicked
  void uploadBlog() {
    if (formKey.currentState!.validate() &&
        topics.isNotEmpty &&
        image != null) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).userEntity.id;
      context.read<BlogBloc>().add(
            BlogUploadEvent(
              posterId: posterId,
              imageUrl: image!,
              title: blogTitleController.toString().trim(),
              content: blogContentController.toString().trim(),
              topics: topics,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => uploadBlog(),
            icon: const Icon(
              Icons.done_rounded,
            ),
          )
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            print(state.error);
            showSnackBar(context, state.error);
          } else if (state is BlogSuccess) {
            showSnackBar(context, "Blog Uploaded!");
            Routemaster.of(context).replace('/');
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
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
                                    if (topics.contains(e)) {
                                      topics.remove(e);
                                    } else {
                                      topics.add(e);
                                    }
                                    setState(() {});
                                  },
                                  child: Chip(
                                    label: Text(e),
                                    color: topics.contains(e)
                                        ? const MaterialStatePropertyAll(
                                            AppPallete.gradient1)
                                        : null,
                                    side: topics.contains(e)
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
        },
      ),
    );
  }
}
