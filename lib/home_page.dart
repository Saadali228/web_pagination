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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.3 / 1.5,
                  crossAxisCount: 4,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Image(
                                      image: NetworkImage(
                                          postList[index].userImageUrl),
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(postList[index].postName),
                                ],
                              ),
                              // IconButton(
                              //   icon: Icon(SimpleLineIcons.options),
                              //   onPressed: () {},
                              // ),
                            ],
                          ),
                        ),

                        FadeInImage(
                          image: NetworkImage(postList[index].postImageUrl),
                          placeholder:
                              const AssetImage("assets/placeholder.png"),
                          width: MediaQuery.of(context).size.width,
                        ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: <Widget>[
                        //     Row(
                        //       children: <Widget>[
                        //         IconButton(
                        //           onPressed: () {},
                        //           icon: Icon(FontAwesome.heart_o),
                        //         ),
                        //         IconButton(
                        //           onPressed: () {},
                        //           icon: Icon(FontAwesome.comment_o),
                        //         ),
                        //         IconButton(
                        //           onPressed: () {},
                        //           icon: Icon(FontAwesome.send_o),
                        //         ),
                        //       ],
                        //     ),
                        //     IconButton(
                        //       onPressed: () {},
                        //       icon: Icon(FontAwesome.bookmark_o),
                        //     ),
                        //   ],
                        // ),

                        // Container(
                        //   width: MediaQuery.of(context).size.width,
                        //   margin: const EdgeInsets.symmetric(
                        //     horizontal: 14,
                        //   ),
                        //   child: RichText(
                        //     softWrap: true,
                        //     overflow: TextOverflow.visible,
                        //     text: const TextSpan(
                        //       children: [
                        //         TextSpan(
                        //           text: "Liked By ",
                        //           style: TextStyle(color: Colors.black),
                        //         ),
                        //         TextSpan(
                        //           text: "Sigmund,",
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               color: Colors.black),
                        //         ),
                        //         TextSpan(
                        //           text: " Yessenia,",
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               color: Colors.black),
                        //         ),
                        //         TextSpan(
                        //           text: " Dayana",
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               color: Colors.black),
                        //         ),
                        //         TextSpan(
                        //           text: " and",
                        //           style: TextStyle(
                        //             color: Colors.black,
                        //           ),
                        //         ),
                        //         TextSpan(
                        //           text: " 1263 others",
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               color: Colors.black),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        // caption
                        // Container(
                        //   width: MediaQuery.of(context).size.width,
                        //   margin: const EdgeInsets.symmetric(
                        //     horizontal: 14,
                        //     vertical: 5,
                        //   ),
                        //   child: RichText(
                        //     softWrap: true,
                        //     overflow: TextOverflow.visible,
                        //     text: TextSpan(
                        //       children: [
                        //         TextSpan(
                        //           text: posts[i].username,
                        //           style: const TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               color: Colors.black),
                        //         ),
                        //         TextSpan(
                        //           text: " ${posts[i].caption}",
                        //           style: const TextStyle(color: Colors.black),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        // post date
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 14,
                          ),
                          alignment: Alignment.topLeft,
                          child: Text(
                            postList[index].postDate.toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
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
