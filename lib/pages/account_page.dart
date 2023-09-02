import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: _buildBody(), // Create this method to build the Account content
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              // Implement profile image editing functionality
            },
            child: Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4.0),
              ),
              child: CircleAvatar(
                radius: 80.0,
                backgroundImage: AssetImage('lib/assets/Phatcharapuek_profile.jpg'), // Replace with the new image asset path
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Phatcharapuek Anurak',
            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            'hi2011_007@hotmail.com',
            style: TextStyle(fontSize: 18.0, color: Colors.grey),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Implement edit profile functionality
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
            ),
            child: Text(
              'Edit Profile',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 32.0),
          _buildSectionHeader('Account Details'),
          _buildAccountDetails(),
          SizedBox(height: 24.0),
          _buildSectionHeader('Notifications'),
          _buildNotifications(),
          SizedBox(height: 24.0),
          _buildSectionHeader('Activity Feed'),
          _buildActivityFeed(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildAccountDetails() {
    return ListTile(
      leading: Icon(
        Icons.person_outline,
        size: 36.0,
      ),
      title: Text(
        'Member Since',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        'June 2022',
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget _buildNotifications() {
    return ListTile(
      leading: Icon(
        Icons.notifications_none,
        size: 36.0,
      ),
      title: Text(
        'Notification Preferences',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActivityFeed() {
    return ListTile(
      leading: Icon(
        Icons.rss_feed,
        size: 36.0,
      ),
      title: Text(
        'Recent Activity',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
