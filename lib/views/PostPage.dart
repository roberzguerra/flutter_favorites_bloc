import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_favorites_bloc/blocs/PostBloc.dart';
import 'package:flutter_favorites_bloc/components/PostCard.dart';
import 'package:flutter_favorites_bloc/models/Post.dart';
import 'package:flutter_favorites_bloc/views/FavoritesPage.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  PostBloc _postBloc;

  @override
  void initState() {
    _postBloc = PostBloc();
    super.initState();
  }

  @override
  void dispose() {
    _postBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Página de posts"),
      ),
      body: Container(
          child: StreamBuilder<List<Post>>(
              stream: _postBloc.postListFlux,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemBuilder: (BuildContext cotext, int index) {
                    if (index < snapshot.data.length) {
                      Post post = snapshot.data[index];

                      return PostCard(post);
                    }
                  });
                } else {
                  return Container(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.favorite),
        onPressed: () => Navigator.push(
            context, CupertinoPageRoute(builder: (context) => FavoritesPage())),
      ),
    );
  }
}

/*

// Conteudo anterior utilizado no lugar de PostCard:

return Card(
  color: Colors.blueGrey,
  child: Container(
    decoration: BoxDecoration(
      border: Border.all(),
    ),
    margin: const EdgeInsets.all(4.0),
    padding: const EdgeInsets.all(4.0),
    //width: 200,
    //height: 25,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 10.0),
          child: Text(
            "${post.id}",
            style: TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 10.0),
          child: Text(
            "Post title: ${post.title}",
            style: TextStyle(color: Colors.white),
          ),
        ),
        Text(
          "Post body: ${post.body}",
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
  ),
);

*/
