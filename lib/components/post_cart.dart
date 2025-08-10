// ignore_for_file: sized_box_for_whitespace, non_constant_identifier_names, deprecated_member_use, avoid_print
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_social_app/components/create_comment.dart';
import 'package:flutter_social_app/controllers/like_controller.dart';
import 'package:flutter_social_app/models/post.dart';
import 'package:flutter_social_app/screens/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:readmore/readmore.dart';

class PostCart extends StatefulWidget {
  final Post? post;
  const PostCart({super.key, required this.post});

  @override
  State<PostCart> createState() => _PostCartState();
}

class _PostCartState extends State<PostCart> {
  LikeController likeController = LikeController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostScreen(
              posts: widget.post,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 10),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.blue,
                  backgroundImage: AssetImage('assets/avatar.png'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.post!.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.more_vert_outlined))
              ],
            ),
            ReadMoreText(
              widget.post!.description,
              trimMode: TrimMode.Line,
              trimLines: 3,
              colorClickableText: Colors.blue,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 350,
              width: 360,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image(
                  image: CachedNetworkImageProvider('${widget.post?.mediaUrl}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.post!.likeCount} Likes ',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '${widget.post!.commentCount} Comments ',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 1.0, // Space the divider takes up
              thickness: 0.5, // Actual height of the line
              color: Colors.grey,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // comment button
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) =>
                          CreateCommentSheet(postId: widget.post!.id),
                    );
                  },
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedMessage01,
                    color: Colors.grey,
                  ),
                ),
                //
                IconButton(
                  onPressed: () {},
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedStickyNote01,
                    color: Colors.grey,
                  ),
                ),
                // like button
                IconButton(
                  onPressed: () async {
                    await likeController.likeAndDislike(widget.post!.id);
                  },
                  icon: Icon(Icons.thumb_up, color: Colors.blue),
                ),
                // bookmark button
                IconButton(
                  onPressed: () {},
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedBookBookmark01,
                    color: Colors.grey,
                  ),
                ),
                // share button
                IconButton(
                  onPressed: () {},
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedShare01,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
