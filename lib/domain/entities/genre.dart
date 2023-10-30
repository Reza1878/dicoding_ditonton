import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  Genre({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json['id'],
        name: json['name'],
      );

  @override
  List<Object> get props => [id, name];
}
