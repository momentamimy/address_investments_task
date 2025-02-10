import 'package:address_investments_task/core/config/routes/app_screens.dart';
import 'package:address_investments_task/core/config/theme/context_theme.dart';
import 'package:address_investments_task/features/cart/data/models/cart_product.dart';
import 'package:address_investments_task/injection_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../generated/assets.dart';
import '../../../../shared/widgets/app_icon_button.dart';
import '../bloc/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AppDependencies.sl<CartBloc>()..add(FetchCartProductsEvent()),
      child: Builder(builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(20.r),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            AppIconButton(
                              icon: Icons.arrow_back,
                              onTap: () {
                                context.pop();
                              },
                            ),
                            Spacer(),
                            Text(
                              "cart",
                              style: context.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            SizedBox(
                              width: 25.r,
                            )
                          ],
                        ),
                        Expanded(
                          child: BlocBuilder<CartBloc, CartState>(
                            builder: (context, state) {
                              if (state is CartProductsComplete) {
                                if (state.cartProducts.isNotEmpty) {
                                  return ListView.builder(
                                    itemCount: state.cartProducts.length,
                                    itemBuilder: (context, index) => CartItem(
                                        cartProduct: state.cartProducts[index]),
                                  );
                                } else {
                                  return Center(
                                    child: Text("Cart is empty"),
                                  );
                                }
                              } else if (state is CartProductsProgress) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return Center(
                                child: Text("Cart is empty"),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Payment Method",
                                style: context.titleMedium,
                              ),
                              10.verticalSpace,
                              Container(
                                padding: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: context.secondary,
                                ),
                                child: Row(
                                  children: [
                                    Text("cash on delivery"),
                                    Spacer(),
                                    SvgPicture.asset(
                                      Assets.iconsCheckIcon,
                                    )
                                  ],
                                ),
                              ),
                              10.verticalSpace,
                              Text(
                                "Order Info",
                                style: context.titleMedium,
                              ),
                              10.verticalSpace,
                              Row(
                                children: [
                                  Text(
                                    "Subtotal",
                                    style: context.bodyMedium?.copyWith(
                                      color: context.hintColor,
                                    ),
                                  ),
                                  Spacer(),
                                  BlocBuilder<CartBloc, CartState>(
                                    builder: (context, state) {
                                      return Text(
                                        (state is CartProductsComplete)
                                            ? "\$${state.subTotal}"
                                            : "\$0",
                                        style: context.bodyMedium,
                                      );
                                    },
                                  ),
                                ],
                              ),
                              10.verticalSpace,
                              Row(
                                children: [
                                  Text(
                                    "Shipping cost",
                                    style: context.bodyMedium?.copyWith(
                                      color: context.hintColor,
                                    ),
                                  ),
                                  Spacer(),
                                  BlocBuilder<CartBloc, CartState>(
                                    builder: (context, state) {
                                      return Text(
                                        (state is CartProductsComplete)
                                            ? "\$10"
                                            : "\$0",
                                        style: context.bodyMedium,
                                      );
                                    },
                                  ),
                                ],
                              ),
                              10.verticalSpace,
                              Row(
                                children: [
                                  Text(
                                    "total",
                                    style: context.bodyMedium?.copyWith(
                                      color: context.hintColor,
                                    ),
                                  ),
                                  Spacer(),
                                  BlocBuilder<CartBloc, CartState>(
                                    builder: (context, state) {
                                      return Text(
                                        (state is CartProductsComplete)
                                            ? "\$${state.total}"
                                            : "\$0",
                                        style: context.bodyMedium,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(double.infinity, 50.h)),
                  onPressed: () {
                    context.read<CartBloc>().checkout();
                    context.pushNamed(AppScreens.orderConfirmation.name);
                  },
                  child: Text("Checkout"),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class CartItem extends StatefulWidget {
  final CartProduct cartProduct;

  const CartItem({super.key, required this.cartProduct});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late final QuantityCubit quantityCubit;

  @override
  void initState() {
    super.initState();
    quantityCubit = QuantityCubit(widget.cartProduct.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: context.hintColor.withOpacity(0.1),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: context.surface,
        ),
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: Row(
            children: [
              Container(
                height: 110.h,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10.r,
                  ),
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.cartProduct.product.images.first,
                  imageBuilder: (context, imageProvider) => Image(
                    fit: BoxFit.cover,
                    image: imageProvider,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    Assets.imagesCategoryPlaceHolderImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              5.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 20.w),
                      child: Text(widget.cartProduct.product.title,
                          style: context.titleSmall),
                    ),
                    Text(
                      "\$${widget.cartProduct.product.price}",
                      style:
                          context.bodySmall?.copyWith(color: context.hintColor),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            quantityCubit.decrement();
                            context.read<CartBloc>().decreaseProductQuantity(
                                widget.cartProduct.product.id);
                          },
                          color: context.hintColor.withOpacity(0.6),
                          icon: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: context.hintColor.withOpacity(0.3))),
                            child: Icon(
                              Icons.keyboard_arrow_down_outlined,
                            ),
                          ),
                        ),
                        BlocBuilder<QuantityCubit, int>(
                          bloc: quantityCubit,
                          builder: (context, quantity) {
                            return Text(quantity.toString());
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            quantityCubit.increment();
                            context.read<CartBloc>().increaseProductQuantity(
                                widget.cartProduct.product.id);
                          },
                          color: context.hintColor.withOpacity(0.6),
                          icon: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: context.hintColor.withOpacity(0.3))),
                            child: Icon(
                              Icons.keyboard_arrow_up_outlined,
                            ),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            context
                                .read<CartBloc>()
                                .removeFromCart(widget.cartProduct.product.id);
                          },
                          color: context.hintColor.withOpacity(0.6),
                          icon: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: context.hintColor.withOpacity(0.3)),
                            ),
                            child: Icon(
                              Icons.delete_outline_outlined,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuantityCubit extends Cubit<int> {
  QuantityCubit(super.initialQuantity);

  void increment() {
    emit(state + 1);
  }

  void decrement() {
    emit(state - 1);
  }
}
