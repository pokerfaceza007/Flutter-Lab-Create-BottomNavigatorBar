import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> searchResults = [];
  List<Map<String, dynamic>> recommendedTopics = [
    {
      'title': 'Nature',
      'image': 'lib/assets/nature.jpg',
    },
    {
      'title': 'Food',
      'image': 'lib/assets/food.jpg',
    },
    {
      'title': 'Travel',
      'image': 'lib/assets/travel.jpg',
    },
    {
      'title': 'Technology',
      'image': 'lib/assets/technology.jpg',
    },
  ];

  // Add a TextEditingController for the search TextField
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: _clearSearch,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController, // Use the searchController
              onChanged: _performSearch,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            _buildRecommendedTopics(),
            SizedBox(height: 16.0),
            _buildSearchResults(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedTopics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Recommended Topics',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 images per row
            childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.4),
          ),
          itemCount: recommendedTopics.length,
          itemBuilder: (context, index) {
            return _buildRecommendedTopicCard(recommendedTopics[index]);
          },
        ),
      ],
    );
  }

  Widget _buildRecommendedTopicCard(Map<String, dynamic> topic) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // Set the search text in the search bar when an image is tapped
          searchController.text = topic['title'];
          _performSearch(topic['title']);
        },
        child: Column(
          children: [
            Image.asset(
              topic['image'],
              height: 240.0, // Adjust the height as needed
              width: double.infinity, // Adjust the width as needed
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(
                topic['title'],
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (searchResults.isEmpty) {
      return Center(
        child: Text(
          'No results found.',
          style: TextStyle(fontSize: 18.0),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return _buildCustomResultCard(searchResults[index]);
      },
    );
  }

  Widget _buildCustomResultCard(String result) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          result,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Additional information about the result.',
          style: TextStyle(fontSize: 14.0),
        ),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          _navigateToResultDetails(result);
        },
      ),
    );
  }

  void _clearSearch() {
    setState(() {
      searchResults.clear();
    });
  }

  void _performSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        searchResults.clear();
      } else {
        searchResults = List.generate(10, (index) => 'Search Result $index');
      }
    });
  }

  void _navigateToResultDetails(String result) {
    // Implement navigation to result details page
  }
}
