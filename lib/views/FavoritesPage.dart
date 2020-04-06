import 'dart:developer';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_favorites_bloc/blocs/FavoriteBloc.dart';
import 'package:flutter_favorites_bloc/components/PostCard.dart';
import 'package:flutter_favorites_bloc/models/Post.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    FavoriteBloc favoriteBloc = BlocProvider.getBloc<FavoriteBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
      ),
      body: Container(
        child: Center(
          child: StreamBuilder(
              stream: favoriteBloc.favoritesListFlux,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
                log(snapshot.hasData.toString());
                log(snapshot.data.length.toString());

                if (snapshot.hasData && snapshot.data.isNotEmpty) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        Post post = snapshot.data[index];
                        return Dismissible(
                          direction: DismissDirection.endToStart,
                          background: Container(color: Colors.red,),
                          onDismissed: (direction) {
                            
                            // Cria o evento de deslizar o card para o lado, assim remove ele da lista de favoritos.
                            favoriteBloc.favoriteListDeleteEvent.add(post);
                            Scaffold.of(context).showSnackBar(SnackBar(content: Text("${post.title} removido.")));
                          },
                          child: PostCard(post),
                          // child: Container(
                          //   margin: const EdgeInsets.all(10),
                          //   height: 200,
                          //   width: 200,
                          //   color: Colors.red,
                          //   child: Column(
                          //     children: <Widget>[],
                          //   ),
                          // ),
                          // Key deve ser implementado para que cada Dismissible tenha sua propria chave e evitar erros estranhos por nao ter a chave.
                          key: Key("${post.id}"),
                        );
                      });
                } else {
                  return Text("Você ainda não possui favoritos.");
                }
              }),
        ),
      ),
    );
  }
}
