import 'dart:convert';

import 'package:http/http.dart' as http;

class Post {
  final int postId;
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

  static const String api = "https://dummyapi.io/data/v1/post?limit=10";

  static Future<List<Post>> getPosts() async {
    List<Post> posts = [];
    int page = 0;
    var url = Uri.parse('https://dummyapi.io/data/v1/post?limit=10$page');
    page++;
    try {
      final response = await http.get(url, headers: {
        "app-id": "61b8b0f3309ad65ae828da3e",
      });
      final jsonResponse = jsonDecode(response.body);
      final postList = Post.fromJson(jsonResponse['data']) as List;
      for (var e in postList) {
        posts.add(Post.fromJson(e));
      }
      return posts;
    } catch (e) {
      rethrow;
    }
  }
}
