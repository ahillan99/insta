import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Map<String, dynamic> post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final String userImage = (post['userImage'] as String?) ?? '';
    final String username = (post['username'] as String?) ?? 'Unknown User';
    final String postImage = (post['postImage'] as String?) ?? '';
    final String caption = (post['caption'] as String?) ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        ListTile(

          leading: CircleAvatar(
            backgroundImage: userImage.isNotEmpty && Uri.tryParse(userImage)?.hasAbsolutePath == true
                ? NetworkImage(userImage) as ImageProvider<Object>
                : const AssetImage('assets/placeholder_user.png') as ImageProvider<Object>, // Fallback asset
            onBackgroundImageError: (exception, stackTrace) {
              print('Error loading user image for $username: $exception');
            },
            child: (userImage.isEmpty || Uri.tryParse(userImage)?.hasAbsolutePath != true)
                ? const Icon(Icons.person, size: 30, color: Colors.grey) // Fallback icon
                : null,
          ),

          title: Text(
            username,

            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(Icons.more_vert),
        ),
        Image.network(
          postImage.isNotEmpty && Uri.tryParse(postImage)?.hasAbsolutePath == true
              ? postImage
              : 'https://placehold.co/600x400/eeeeee/000000?text=Image+Not+Found', // Online placeholder
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            print('Error loading post image: $error');
            return Image.network(
              'https://placehold.co/600x400/eeeeee/000000?text=Image+Load+Error',
              fit: BoxFit.cover,
              width: double.infinity,
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              width: double.infinity,
              height: 200, // Approximate height for loader
              color: Colors.grey[200],
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
        // Actions
        Padding(
          padding: const EdgeInsets.all(8.0),
          // Original was not const: Row( children: [ Icon(...) ] )
          // REPLACEMENT (add const to Row and its children as they are all constants):
          child: Row(
            children: const [
              Icon(Icons.favorite_border),
              SizedBox(width: 16),
              Icon(Icons.comment_outlined),
              SizedBox(width: 16),
              Icon(Icons.send),
              Spacer(),
              Icon(Icons.bookmark_border),
            ],
          ),
        ),
        // Caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child:
          Text('${username} ${caption}',

            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
        // Original was not const: SizedBox(height: 16),
        // REPLACEMENT (add const):
        const SizedBox(height: 16),
      ],
    );
  }
}