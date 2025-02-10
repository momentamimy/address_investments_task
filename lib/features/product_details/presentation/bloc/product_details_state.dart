part of 'product_details_bloc.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}
final class AddToCartProgress extends ProductDetailsState {}
final class AddToCartComplete extends ProductDetailsState {}
final class AddToCartError extends ProductDetailsState {}
