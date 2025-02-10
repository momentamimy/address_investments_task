import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'category_model.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final int price;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final List<String> images;
  @HiveField(5)
  final CategoryModel category;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      images: _handleImages(List<String>.from(json["images"].map((x) => x))),
      category: CategoryModel.fromJson(json["category"]),
    );
  }

  static List<String> _handleImages(List<String> rawImages) {
    try {
      if (rawImages.isNotEmpty && rawImages.first.contains("[")) {
        String jsonString = rawImages.join();
        return List<String>.from(jsonDecode(jsonString));
      } else {
        return rawImages;
      }
    } catch (e) {
      print("Error decoding JSON: $e");
    }

    // الحالة العادية (لو البيانات أصلاً في شكل List صحيحة)
    return List<String>.from(rawImages);
  }

  ProductModel copyWith({
    int? id,
    String? title,
    int? price,
    String? description,
    List<String>? images,
    CategoryModel? category,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      images: images ?? this.images,
      category: category ?? this.category,
    );
  }
  @override
  List<Object?> get props => [
        id,
        title,
        price,
        description,
        images,
        category,
      ];
}
