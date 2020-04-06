import 'package:flutter_favorites_bloc/models/Post.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class FavoriteCardBloc extends BlocBase {
  final _favoritesListController = BehaviorSubject<List<Post>>();
  Stream<List<Post>> get favoritesListFlux => _favoritesListController.stream;
  Sink<List<Post>> get favoritesListEvent => _favoritesListController.sink;

  final _isFavoriteController = BehaviorSubject<bool>();
  Stream<bool> get isFavoriteIFlux => _isFavoriteController.stream;
  Sink<bool> get isFavoriteEvent => _isFavoriteController.sink;

  FavoriteCardBloc(Post post) {

    /*
      Mapeia a stream de lista de posts (favoritesListFlux) para um booleando (verificando se dados contem o post recebido)
      E depois escuta (listen) esta stream, executando o isFavoriteEvent.add.
      Com isso, verificamos se o item (post recebido) esta dentro ou nao da lista de favoritos.
    */
    favoritesListFlux
        .map((dados) => dados.contains(post))
        .listen(isFavoriteEvent.add);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _favoritesListController.close();
    _isFavoriteController.close();
    super.dispose();
  }
}
