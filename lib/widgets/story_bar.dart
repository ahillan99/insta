import 'package:flutter/material.dart';

class StoryBubble extends StatelessWidget {
  final String imageUrl;
  final String username;

    const StoryBubble({super.key, required this.imageUrl, required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,

            backgroundImage: imageUrl.isNotEmpty && Uri.tryParse(imageUrl)?.hasAbsolutePath == true
                ? NetworkImage(imageUrl) as ImageProvider<Object>
                : const AssetImage('assets/placeholder_user.png') as ImageProvider<Object>, // Fallback asset
            onBackgroundImageError: (exception, stackTrace) {
              print('Error loading image for $username: $exception');
            },
            child: (imageUrl.isEmpty || Uri.tryParse(imageUrl)?.hasAbsolutePath != true)
                ? const Icon(Icons.person, size: 40, color: Colors.grey) // Fallback icon
                : null,
          ),
          const SizedBox(height: 5),

                   Text(
            username,

            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}