import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'category_model.g.dart';
@HiveType(typeId: 1)
class CategoryModel extends Equatable{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String image;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );
  @override
  List<Object?> get props => [id, name, image];
}