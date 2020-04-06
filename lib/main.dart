import 'package:flutter/material.dart';
import 'package:flutter_favorites_bloc/blocs/FavoriteBloc.dart';
import 'package:flutter_favorites_bloc/views/PostPage.dart';

// Fornece o provider para que seja possivel recuperar o mesmo Bloc de varias paginas, atraves do contexto.
import 'package:bloc_pattern/bloc_pattern.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Permite acessar o FavoriteBloc de dentro de qualquer pagina abaixo do Material App.
      blocs: [
        Bloc((i) => FavoriteBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PostPage(),
      ),
    );
  }
}

/*

// Foi necessario envolver o MaterialApp em um BlocProvider para 
return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostPage(),
    );
*/
