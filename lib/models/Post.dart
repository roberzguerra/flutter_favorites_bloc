import 'package:json_annotation/json_annotation.dart';

/*
Para gerar o arquivo Post.g.dart execute:
$ pub run build_runner build
*/
part 'Post.g.dart';

@JsonSerializable()
class Post {
  int userId;
  int id;
  String title;
  String body;

  Post();

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  // Atribui um metodo ao operador '=='
  bool operator ==(other) => other is Post && other.id == id;

  // Importante implementar o hashCode sempre q se implementar o operator equals (==) 
  @override
  int get hashCode => super.hashCode ^ userId.hashCode ^ title.hashCode ^ body.hashCode;
}
