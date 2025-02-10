import 'package:address_investments_task/core/config/theme/context_theme.dart';
import 'package:address_investments_task/features/home/data/models/product_model.dart';
import 'package:address_investments_task/features/product_details/presentation/bloc/product_details_bloc.dart';
import 'package:address_investments_task/shared/widgets/app_icon_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/config/routes/app_screens.dart';
import '../../../../generated/assets.dart';
import '../../../../injection_container.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppDependencies.sl<ProductDetailsBloc>(),
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: CachedNetworkImage(
                      imageUrl: product.images.first,
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
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(10.r),
                      child: Row(
                        children: [
                          AppIconButton(
                            backgroundColor: context.surface,
                            icon: Icons.arrow_back,
                            onTap: () {
                              context.pop();
                            },
                          ),
                          Spacer(),
                          AppIconButton(
                            backgroundColor: context.surface,
                            iconWidget: SvgPicture.asset(Assets.iconsBagIcon),
                            onTap: () {
                              context.pushNamed(AppScreens.cart.name);
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Men's Printed Pullover Hoodie",
                                      style: context.bodyMedium?.apply(
                                        color: context.hintColor,
                                      ),
                                    ),
                                    Text(
                                      product.title,
                                      style: context.titleMedium?.copyWith(
                                          color: context.onSurface,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Price",
                                    style: context.bodyMedium?.apply(
                                      color: context.hintColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${product.price}",
                                    style: context.titleMedium?.copyWith(
                                        color: context.onSurface,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              )
                            ],
                          ),
                          20.verticalSpace,
                          SizedBox(
                            height: 120.h,
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  10.horizontalSpace,
                              scrollDirection: Axis.horizontal,
                              itemCount: product.images.length,
                              itemBuilder: (context, index) => Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    10.r,
                                  ),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: product.images[index],
                                  imageBuilder: (context, imageProvider) =>
                                      Image(
                                    fit: BoxFit.cover,
                                    image: imageProvider,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    Assets.imagesCategoryPlaceHolderImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          20.verticalSpace,
                          Text("Description", style: context.titleMedium),
                          5.verticalSpace,
                          Flexible(
                            child: SingleChildScrollView(
                              child: ReadMoreText(
                                product.description,
                                trimMode: TrimMode.Line,
                                trimLines: 3,
                                colorClickableText: context.onSurface,
                                trimCollapsedText: 'see more',
                                trimExpandedText: 'see less',
                                lessStyle: TextStyle(
                                    color: context.onSurface,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: context.hintColor,
                                ),
                                moreStyle: TextStyle(
                                    color: context.onSurface,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  BlocConsumer<ProductDetailsBloc, ProductDetailsState>(
                    listener: (context, state) {
                      if (state is AddToCartComplete) {
                        Fluttertoast.showToast(msg: "product is Added to cart");
                      } else if (state is AddToCartError) {
                        Fluttertoast.showToast(
                            msg: "some thing went wrong, please try again");
                      }
                    },
                    builder: (context, state) {
                      if (state is AddToCartProgress) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(double.infinity, 50.h)),
                          onPressed: () async {
                            context.read<ProductDetailsBloc>().add(
                                  AddProductToCartEvent(
                                    productModel: product,
                                  ),
                                );
                          },
                          child: Text("Add to Cart"),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
