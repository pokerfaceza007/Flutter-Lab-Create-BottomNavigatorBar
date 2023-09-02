class Post {
  final String username;
  final String content;
  final String imageUrl;
  final String timestamp;
  int likes;
  bool isLiked;
  List<Comment> comments; // Add comments list

  Post({
    required this.username,
    required this.content,
    required this.imageUrl,
    required this.timestamp,
    this.likes = 0,
    this.isLiked = false,
    this.comments = const [], // Initialize with an empty list
  });
}

class Comment {
  final String username;
  final String text;
  final String timestamp; 

  Comment({
    required this.username,
    required this.text,
    required this.timestamp,
  });
}
