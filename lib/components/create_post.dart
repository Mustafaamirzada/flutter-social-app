// ignore_for_file: unused_field
import 'dart:io';
import 'package:fchat/repository/post_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostBottomSheet extends StatefulWidget {
  const CreatePostBottomSheet({super.key});

  @override
  State<CreatePostBottomSheet> createState() => _CreatePostBottomSheetState();
}

class _CreatePostBottomSheetState extends State<CreatePostBottomSheet> {
  File? _imageFile;

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  PostRepository postRepository = PostRepository();

  Future pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Widget makeDismisable({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pop(context),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );

  @override
  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          color: Color.fromRGBO(30, 41, 59, 1),
        ),
        child: Column(
          children: [
            /// Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: keyboardHeight + 60), // leave space for buttons
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundImage: NetworkImage(
                                "https://static.vecteezy.com/system/resources/previews/048/216/761/non_2x/modern-male-avatar-with-black-hair-and-hoodie-illustration-free-png.png",
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Your Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Anyone",
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    CupertinoTextField(
                      controller: titleController,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.9,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                      placeholder: 'A Title For Post ',
                      placeholderStyle:
                          TextStyle(color: Colors.grey, fontSize: 18),
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10),

                    /// Description input
                    TextFormField(
                      controller: descController,
                      maxLines: 4,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "What do you want to talk about?",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Bottom action buttons
            AnimatedPadding(
              duration: Duration(milliseconds: 150),
              padding: EdgeInsets.only(bottom: keyboardHeight),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.image, color: Colors.white),
                      onPressed: pickImage,
                    ),
                    IconButton(
                      icon: Icon(Icons.add_box_rounded, color: Colors.white),
                      onPressed: () async {
                        // handle submission here
                        await postRepository.createPost(
                          titleController.text,
                          descController.text,
                          _imageFile,
                        );
                        Navigator.pop(context, true);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
