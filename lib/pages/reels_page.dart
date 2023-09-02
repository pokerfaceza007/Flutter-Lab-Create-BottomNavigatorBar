import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class ReelsPage extends StatefulWidget {
  ReelsPage({Key? key}) : super(key: key);

  @override
  _ReelsPageState createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  List<VideoData> videoData = [
    VideoData(
      username: 'Phatcharapuek',
      avatarImagePath: 'lib/assets/Phatcharapuek_profile.jpg',
      videoCaption: 'Let\'s rock and rickroll',
      videoAssetPath: 'lib/assets/sample_video.mp4',
    ),
    VideoData(
      username: 'Jane Smith',
      avatarImagePath: 'lib/assets/jane smith_profile.jpg',
      videoCaption: 'Look at this dude',
      videoAssetPath: 'lib/assets/sample_video_2.mp4',
    ),
    // Add more video data here
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reels'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      itemCount: videoData.length,
      itemBuilder: (context, index) {
        return _buildReelCard(videoData[index]);
      },
    );
  }

  Widget _buildReelCard(VideoData data) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300.0,
              child: Chewie(
                controller: ChewieController(
                  videoPlayerController: VideoPlayerController.asset(
                    data.videoAssetPath,
                  ),
                  autoInitialize: true,
                  looping: false,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                data.videoCaption,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: AssetImage(data.avatarImagePath),
                    ),
                    SizedBox(width: 8.0),
                    Text(data.username),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {
                        // Implement like functionality
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.mode_comment_outlined),
                      onPressed: () {
                        // Implement comment functionality
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        // Implement share functionality
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class VideoData {
  final String username;
  final String avatarImagePath;
  final String videoCaption;
  final String videoAssetPath;

  VideoData({
    required this.username,
    required this.avatarImagePath,
    required this.videoCaption,
    required this.videoAssetPath,
  });
}
