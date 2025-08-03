// ignore_for_file: sized_box_for_whitespace, use_build_context_synchronously
import 'dart:async';
import 'package:fchat/auth/auth.dart';
import 'package:fchat/components/create_post.dart';
import 'package:fchat/components/post_cart.dart';
import 'package:fchat/controllers/post_controller.dart';
import 'package:fchat/models/post.dart';
import 'package:fchat/repository/post_repository.dart';
import 'package:fchat/services/auth_service.dart';
import 'package:fchat/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PostRepository postRepository = PostRepository();
  PostController postController = PostController();
  late Future<List<Post>> postData;
  late List<Post> posts;
  late bool isConnected = false;
  final ScrollController _scrollController = ScrollController();
  InternetConnectionChecker intchecker = InternetConnectionChecker.instance;

  Future<void> handleLogout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    // Clear tokens or session info
    await AuthService.logout();
    // Logout Successful
    showUserMessage('Logout Successfuly', context);

    // pop the loading circle
    if (context.mounted) Navigator.pop(context);

    // Navigate to login screen
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => AuthPage()),
      (Route<dynamic> route) => false,
    );
  }

  StreamSubscription<InternetConnectionStatus>? _connectionSubscription;

  @override
  void initState() {
    super.initState();
    postData = postController.getPosts();
    intchecker.hasConnection.then((value) {
      if (!mounted) return;
      setState(() {
        isConnected = value;
      });
    });

    // Listen to internet status change
    // _connectionSubscription = intchecker.onStatusChange.listen((status) {
    //   final hasConnection = status == InternetConnectionStatus.connected;
    //   if (!mounted) return;

    //   setState(
    //     () {
    //       isConnected = hasConnection;
    //       if (hasConnection) {
    //         // Re-fetch posts on reconnect
    //         postData = postController.getPosts(); // <- re-fetch posts
    //         // show message
    //         ScaffoldMessenger.of(context).showSnackBar(
    //           SnackBar(
    //             content: Text('Connection Restored. Refreshing Posts...'),
    //             duration: Duration(seconds: 2),
    //           ),
    //         );
    //       }
    //     },
    //   );
    // });

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent * 0.7) {
        if (!mounted) return;
        posts = await postRepository.getAllPosts();
        postRepository.cachePostLocally(posts: posts);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _connectionSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            SizedBox(width: 10),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue,
              backgroundImage: NetworkImage(
                "https://static.vecteezy.com/system/resources/previews/048/216/761/non_2x/modern-male-avatar-with-black-hair-and-hoodie-illustration-free-png.png",
              ),
            ),
          ],
        ),
        title: Text('For You'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person_pin),
            tooltip: 'userName',
          ),
          IconButton(
            onPressed: () {
              handleLogout(context);
            },
            icon: Icon(Icons.logout_rounded),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              child: FutureBuilder(
                future: postData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.data!.isEmpty && !isConnected) {
                    return Center(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 200),
                          Icon(
                            Icons.wifi_off,
                            size: 80,
                            color: Colors.blueGrey,
                          ),
                          Text(
                            'Unable to Connect to Internet.\n Plesae Check Your Internet Connection.',
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final posts = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return PostCart(
                          post: post,
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text('Problem Fetching Posts'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => CreatePostBottomSheet(),
          );
          if (mounted && result == true) {
            setState(() {
              postData = postController.getPosts();
            });
          }
        },
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
        child: HugeIcon(
          icon: HugeIcons.strokeRoundedAdd01,
          color: Colors.white,
        ),
      ),
    );
  }
}
