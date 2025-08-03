import 'package:fchat/components/my_button.dart';
import 'package:fchat/components/my_text_feild.dart';
import 'package:fchat/repository/comment_repository.dart';
import 'package:flutter/material.dart';

class CreateCommentSheet extends StatefulWidget {
  final int postId;
  const CreateCommentSheet({super.key, required this.postId});

  @override
  State<CreateCommentSheet> createState() => _CreateCommentSheetState();
}

class _CreateCommentSheetState extends State<CreateCommentSheet> {

  TextEditingController commentController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  CommentRepository comtRepository = CommentRepository();

  Widget makeDismisable({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pop(context),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );


  @override
  Widget build(BuildContext context) {
    return makeDismisable(
      child: DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.4,
        maxChildSize: 0.5,
        builder: (_, controller) => Container(
          padding: const EdgeInsets.all(25),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            // color: Color.fromRGBO(30, 41, 59, 1),
            color: Color.fromRGBO(51, 65, 85, 1),
          ),
          child: ListView(
            controller: controller,
            children: [
              Center(
                child: const Text(
                  'Create a New Comment',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 10),
              MyTextfield(
                hintText: 'Comment',
                obscureText: false,
                controller: commentController,
              ),

              const SizedBox(height: 10),
              MyButton(
                text: 'Create Comment',
                onTap: () async {
                  // handle submission here
                  await comtRepository.createComment(
                    commentController.text,
                    widget.postId,
                  );
                  Navigator.pop(context, true);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
