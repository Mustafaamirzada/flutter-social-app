import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_social_app/controllers/post_controller.dart';
import 'package:flutter_social_app/models/post.dart';
import 'package:flutter_social_app/repository/post_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Post> posts = [];
  String searchQuery = '';
  PostController postController = PostController();
  PostRepository postRepository = PostRepository();

  @override
  void initState() {
    super.initState();
    loadPosts();
  }

  Future<void> loadPosts() async {
    final result = await postController.getPosts();
    setState(() => posts = result);
  }

  Future<void> searchPosts(String query) async {
    if (query.isEmpty) {
      loadPosts();
    } else {
      final result = await postRepository.searchPost(query);
      setState(() {
        posts = result;
        searchQuery = query;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Row(
            children: [
              SizedBox(width: 8),
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.blue,
                backgroundImage: NetworkImage(
                    "https://static.vecteezy.com/system/resources/previews/048/216/761/non_2x/modern-male-avatar-with-black-hair-and-hoodie-illustration-free-png.png"), // or AssetImage
              ),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: CupertinoSearchTextField(
            borderRadius: BorderRadius.circular(50),
            prefixIcon: Icon(CupertinoIcons.search),
            placeholder: 'Search...',
            style: TextStyle(color: Colors.white),
            onChanged: searchPosts,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedMessage01,
                color: Colors.grey,
              ),
              tooltip: 'userName',
            ),
          ]),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: posts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final post = posts[index];
                return GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    // context,
                    // MaterialPageRoute(
                    // builder: (_) => ProductDetailScreen(product: product),
                    // ),
                    // );
                    log('Product details');
                  },
                  child: Card(
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            // child : Image(product.image, fit: BoxFit.cover)
                            child: Image(
                              image: CachedNetworkImageProvider(post.mediaUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            post.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
