import 'dart:convert';

import 'package:http/http.dart' as http;

class Post {
  final String postId;
  final String postName;
  final DateTime postDate;
  final String userImageUrl;
  final String postImageUrl;

  Post.fromJson(Map<String, dynamic> json)
      : postId = json['id'],
        postName = json['text'],
        postDate = DateTime.parse(json['publishDate']),
        userImageUrl = json['owner']['picture'],
        postImageUrl = json['image'];

  static Future<List<Post>> getPosts(int page) async {
    // List<Post> posts = [];
    // int page = 0;
    var url = Uri.parse('https://dummyapi.io/data/v1/post?limit=5$page');

    try {
      final response = await http.get(url, headers: {
        "app-id": "61b8b0f3309ad65ae828da3e",
      });
      final jsonResponse = jsonDecode(response.body);
      // final postList = Post.fromJson(jsonResponse['data']) as List;
      final postList =
          (jsonResponse["data"] as List).map((e) => Post.fromJson(e)).toList();
      // print('object');
      // for (var e in postList) {
      //   posts.add(Post.fromJson(e));
      // }
      return postList;
    } catch (e) {
      rethrow;
    }
  }
}
