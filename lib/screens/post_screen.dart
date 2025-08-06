import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_social_app/components/update_post.dart';
import 'package:flutter_social_app/models/post.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class PostScreen extends StatelessWidget {
  final Post? posts;

  const PostScreen({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                  image: CachedNetworkImageProvider(posts!.mediaUrl),
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      // Post title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            posts!.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          // Edit Button
                          IconButton(
                            onPressed: () async {
                              final result = await showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => UpdatePostSheet(id: posts!.id,),
                              );
                              
                            },
                            icon: HugeIcon(
                              icon: HugeIcons.strokeRoundedEdit02,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        posts!.description,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      SizedBox(height: 10),
                      // post creation date
                      Text(
                        'Created Date: ${posts!.userId}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/whatsapp.png'),
                            Image.asset('assets/facebook.png'),
                            Image.asset('assets/twitter.png'),
                            Image.asset('assets/messenger.png'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 18,
          top: 20,
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedArrowLeft02,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
