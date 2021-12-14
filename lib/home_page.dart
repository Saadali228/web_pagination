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
  int page = 0;
  @override
  void initState() {
    super.initState();
    getList();
  }

  void getList() async {
    setState(() {
      isLoading = true;
    });
    var newItems = await Post.getPosts(page);
    page++;
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
        title: const Text('Pagination'),
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
              child: ListView.builder(
                itemCount: postList.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.network(
                                  postList[index].userImageUrl,
                                  height: 40,
                                  width: 40,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(child: Text(postList[index].postName)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(postList[index].postDate.toString()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.network(
                                  postList[index].postImageUrl,
                                  fit: BoxFit.cover,
                                  width: 100,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  );
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
