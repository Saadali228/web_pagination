import 'package:flutter/material.dart';

import 'post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Post> postList = [];
  @override
  void initState() {
    super.initState();
    getList();
  }

  void getList() async {
    setState(() {
      isLoading = true;
    });
    var newItems = await Post.getPosts();
    if (postList.isEmpty) {
      postList = newItems;
    } else {
      postList.addAll(newItems);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web App'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!isLoading &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  getList();
                }
                return true;
              },
              child: GridView.builder(
                itemCount: postList.length,
                gridDelegate: null,
                itemBuilder: (context, index) {
                  return Container();
                }, 
              ),
            ),
          ),
          Container(
            height: isLoading ? 50.0 : 0,
            color: Colors.transparent,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
