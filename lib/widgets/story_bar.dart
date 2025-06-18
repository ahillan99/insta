import 'package:flutter/material.dart';

class StoryBubble extends StatelessWidget {
  final String imageUrl;
  final String username;

  // No key was present, better to add.
  // const StoryBubble({required this.imageUrl, required this.username});
  // REPLACEMENT (add key):
  const StoryBubble({super.key, required this.imageUrl, required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      // Original was not const: margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      // REPLACEMENT (add const):
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            // ERROR LINE: `backgroundImage: NetworkImage(imageUrl),` (Line 13 in your prior code)
            // This line crashed if `imageUrl` was null, empty, or a webpage URL.
            // REPLACEMENT (safe image loading with fallbacks):
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
          // Original was not const: SizedBox(height: 5),
          // REPLACEMENT (add const):
          const SizedBox(height: 5),
          // ERROR LINE (indirectly): `Text(username, style: TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis),` (Line 18 in your prior code)
          // While `overflow` was handled, `maxLines` was missing, which could let text wrap and contribute to parent `RenderFlex` overflow.
          Text(
            username,
            // Original was not const: style: TextStyle(fontSize: 12),
            // REPLACEMENT (add const):
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
            // REPLACEMENT (add maxLines for consistent height):
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}