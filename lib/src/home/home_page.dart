import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_apirest/src/home/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> posts = [];

  Future<void> getPosts() async {
    final baseURL = "http://jsonplaceholder.typicode.com";
    var url = Uri.parse(
      '$baseURL/posts',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      posts = json.map((e) => Post.fromJson(e)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text(posts[index].id.toString()),
              title: Text(posts[index].title ?? ""),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await getPosts();
          setState(() {});
        },
        child: Icon(Icons.download),
      ),
    );
  }
}
