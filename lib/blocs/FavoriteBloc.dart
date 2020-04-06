import 'package:flutter_favorites_bloc/blocs/Favorites.dart';
import 'package:flutter_favorites_bloc/models/Post.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class FavoriteBloc extends BlocBase {
  final _favorites = Favorites();

  final _favoritesListController = BehaviorSubject<
      List<Post>>(); // Tipe o BehaviorSubject para evitar erros.
  Stream<List<Post>> get favoritesListFlux =>
      _favoritesListController.stream; // Fluxo do bloc
  Sink<List<Post>> get favoritesListEvent =>
      _favoritesListController.sink; // Evento do bloc

  final _favoritesListAddController = BehaviorSubject<Post>();
  Stream<Post> get favoritesListAddFlux => _favoritesListAddController.stream;
  Sink<Post> get favoriteListAddEvent => _favoritesListAddController.sink;

  final _favoritesListDeleteController = BehaviorSubject<Post>();
  Stream<Post> get favoritesListDeleteFlux =>
      _favoritesListDeleteController.stream;
  Sink<Post> get favoriteListDeleteEvent => _favoritesListDeleteController.sink;

  FavoriteBloc() {
    favoritesListAddFlux.listen(_handleAdd);
    favoritesListDeleteFlux.listen(_handleDelete);
  }

  void _handleAdd(Post post) {
    _favorites.posts.add(post);
    _updateList();
  }

  void _updateList() {
    favoritesListEvent.add(_favorites.posts.toList());
  }

  void _handleDelete(Post post){
    _favorites.posts.remove(post);
    _updateList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _favoritesListController.close();
    _favoritesListAddController.close();
    _favoritesListDeleteController.close();
    super.dispose();
  }
}
