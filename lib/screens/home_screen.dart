import 'package:ahillan/widgets/post_area.dart';
import 'package:ahillan/widgets/story_bar.dart';
import 'package:flutter/material.dart';
import '../data_list/post_data.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: const [
          Icon(Icons.send, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Stories
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stories.length,
              itemBuilder: (context, index) {
                // No direct error in these lines, but they pass data from 'stories'
                // The fix is in `post_data.dart` (source of data) and `story_bubble.dart` (consuming widget)
                final story = stories[index];
                final imageUrl = story['image'] as String? ?? '';
                final username = story['username'] as String? ?? 'User';
                return StoryBubble(
                  imageUrl: imageUrl,
                  username: username,
                );
              },
            ),
          ),
          // Original was not const: Divider(height: 1),
          // REPLACEMENT (add const):
          const Divider(height: 1),
          // Posts
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                // ERROR LINE (Indirect cause): `return PostCard(post: posts[index]);` (This line is around 41:24)
                // This line was fine, but `posts[index]` could contain nulls or invalid image URLs from `post_data.dart`.
                // The main fix is in `post_data.dart` (source of data) and `PostCard` (consuming widget).
                final post = posts[index];
                return PostCard(post: post);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        // Original was not const: items: [ BottomNavigationBarItem(...) ]
        // REPLACEMENT (add const):
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}