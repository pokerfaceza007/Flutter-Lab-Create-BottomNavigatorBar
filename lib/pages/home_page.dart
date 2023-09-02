import 'package:flutter/material.dart';

class Post {
  final String username;
  final String content;
  final String imageUrl;
  final String timestamp;
  final List<Comment> comments;
  bool isLiked;
  int likes;

  Post({
    required this.username,
    required this.content,
    required this.imageUrl,
    required this.timestamp,
    required this.comments,
    this.isLiked = false,
    this.likes = 0,
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

class HomePage extends StatefulWidget {
  final String username;
  final String avatarImagePath;

  HomePage({
    required this.username,
    required this.avatarImagePath,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> mockPosts = [
    Post(
      username: 'Phatcharapuek',
      content: 'Enjoying a beautiful day!',
      imageUrl: 'lib/assets/rock_image.jpg',
      timestamp: '2 hours ago',
      comments: [], // Initialize comments as an empty list
    ),
    Post(
      username: 'Jane Smith',
      content: 'Exploring new places...',
      imageUrl: 'lib/assets/post_image_2.jpg',
      timestamp: '4 hours ago',
      comments: [], // Initialize comments as an empty list
    ),
    // Add more mock posts as needed
  ];

  TextEditingController commentController =
      TextEditingController(); // Controller for comment input

  int _commentLengthToShow = 3; // Number of comments to show initially
  bool _showAllComments = false; // Flag to show all comments

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality here
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage: AssetImage(widget.avatarImagePath),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.username,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    'My Bio',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                // Navigate to the user's profile page
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to the settings page
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Implement logout functionality here
              },
            ),
          ],
        ),
      ),
      body: _buildBody(),
      // Set the bottomNavigationBar to null to remove it
      bottomNavigationBar: null,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement a button action here
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      itemCount: mockPosts.length,
      itemBuilder: (context, index) {
        final post = mockPosts[index];
        return _buildPostCard(post);
      },
    );
  }

  Widget _buildPostCard(Post post) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 20.0,
              backgroundImage:
                  AssetImage('lib/assets/${post.username}_profile.jpg'),
            ),
            title: Text(post.username),
            subtitle: Text(post.timestamp),
          ),
          Container(
            height: 25, // Set a fixed height here, adjust as needed
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _showAllComments
                  ? post.comments.length
                  : _commentLengthToShow,
              itemBuilder: (context, index) {
                if (index < post.comments.length) {
                  final comment = post.comments[index];
                  return _buildCommentTile(comment);
                } else {
                  return SizedBox.shrink(); // Return an empty widget if index is out of range
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.content),
          ),
          Center(
            // Center the image horizontally
            child: Image.asset(post.imageUrl),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.thumb_up),
                onPressed: () {
                  setState(() {
                    post.isLiked = !post.isLiked;
                    if (post.isLiked) {
                      post.likes++;
                    } else {
                      post.likes--;
                    }
                  });
                },
                color: post.isLiked ? Colors.blue : Colors.grey,
              ),
              Text(post.likes.toString()), // Display the number of likes
              IconButton(
                icon: Icon(Icons.comment),
                onPressed: () {
                  // Show comments when the comment icon is pressed
                  _showComments(post.comments, post);
                },
              ),
              Text(post.comments.length
                  .toString()), // Display the number of comments
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  // Implement share functionality here
                },
              ),
            ],
          ),
          // Display comments here using a ListView.builder
          if (post.comments.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: post.comments.length,
              itemBuilder: (context, index) {
                final comment = post.comments[index];
                return _buildCommentTile(comment);
              },
            ),
          // Add a comment input field and post button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _postComment(post);
                  },
                ),
              ],
            ),
          ),
          // Show more comments button
          if (post.comments.isNotEmpty &&
              post.comments.length > _commentLengthToShow)
            Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _showAllComments = !_showAllComments;
                  });
                },
                child: Text(
                  _showAllComments ? 'Show Less' : 'Show More Comments',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor, // Custom primaryColor
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Function to show comments in a dialog
  void _showComments(List<Comment> comments, Post post) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Comments'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Display the post content at the top of the comment section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  post.content,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Divider(), // Add a divider between post and comments
              Expanded(
                child: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return _buildCommentTile(comment);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to build a comment tile
  Widget _buildCommentTile(Comment comment) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20.0,
        // You can use a default avatar image or implement user avatars
      ),
      title: Row(
        children: [
          Text(comment.username),
          SizedBox(width: 8.0),
          Text(
            comment.timestamp,
            style: TextStyle(fontSize: 12.0, color: Colors.grey),
          ),
        ],
      ),
      subtitle: Text(comment.text),
    );
  }

  // Function to post a comment
  void _postComment(Post post) {
    final String text = commentController.text;
    if (text.isNotEmpty) {
      setState(() {
        post.comments.add(Comment(
          username: widget.username, // Use the provided username
          text: text,
          timestamp: 'Just now',
        ));
      });
      commentController.clear();
      Navigator.of(context).pop(); // Close the keyboard
    }
  }

  @override
  void dispose() {
    commentController
        .dispose(); // Dispose of the text controller when the widget is disposed
    super.dispose();
  }
}
