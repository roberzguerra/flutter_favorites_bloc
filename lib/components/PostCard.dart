import 'dart:developer';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_favorites_bloc/blocs/FavoriteBloc.dart';
import 'package:flutter_favorites_bloc/blocs/FavoriteCardBloc.dart';
import 'package:flutter_favorites_bloc/models/Post.dart';

class PostCard extends StatefulWidget {
  final Post post;

// construtor automaticamente passa o argumento post recebido para o this.post
  PostCard(this.post);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  FavoriteCardBloc _favoriteCardBloc;
  FavoriteBloc _favoriteBloc;

  @override
  void initState() {
    /*
    Sempre q o bloc pai (o bloc que contem a lista de favoritos) emitir um dado (adicionar, excluir ou atualizar um favorito)
    sempre vai passar essa mudança para o bloc filho.
    Assim eh possivel saber quando um post esta dentro da lista de favoritos.
    */

    _favoriteCardBloc = FavoriteCardBloc(widget.post);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _favoriteBloc = BlocProvider.getBloc<FavoriteBloc>();

      _favoriteBloc.favoritesListFlux
          .listen(_favoriteCardBloc.favoritesListEvent.add);
    });
    super.initState();
  }

  @override
  void dispose() {
    _favoriteCardBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
              child: Text(
                "${widget.post.id}",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
              child: Text(
                "Post title: ${widget.post.title}",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text(
              "Post body: ${widget.post.body}",
              style: TextStyle(color: Colors.white),
            ),
            StreamBuilder(
              stream: _favoriteCardBloc.isFavoriteIFlux,
              initialData: false,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return snapshot.data
                    ? IconButton(
                        icon: Icon(Icons.favorite, color: Colors.red),
                        onPressed: () {
                          _favoriteBloc.favoriteListDeleteEvent
                              .add(widget.post);
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.favorite_border, color: Colors.grey),
                        onPressed: () {
                          log('clicou');
                          _favoriteBloc.favoriteListAddEvent.add(widget.post);
                        },
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
