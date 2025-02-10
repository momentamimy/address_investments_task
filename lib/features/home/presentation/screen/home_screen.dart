import 'package:address_investments_task/core/config/routes/app_router.dart';
import 'package:address_investments_task/core/config/routes/app_screens.dart';
import 'package:address_investments_task/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:address_investments_task/features/home/data/models/product_model.dart';
import 'package:address_investments_task/features/home/presentation/blocs/categories_bloc/categories_bloc.dart';
import 'package:address_investments_task/features/home/presentation/blocs/products_bloc/products_bloc.dart';
import 'package:address_investments_task/features/home/presentation/blocs/update_product_cubit/update_product_cubit.dart';
import 'package:address_investments_task/features/home/presentation/params/fetch_products_params.dart';
import 'package:address_investments_task/injection_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/config/theme/context_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../generated/assets.dart';
import '../../../../shared/widgets/app_icon_button.dart';
import '../bottom_sheet/update_product_sheet.dart';

part '../widgets/categories_section.dart';
part '../widgets/products_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int limit = 10;
  final int offset = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppDependencies.sl<CategoriesBloc>()
            ..add(FetchAllCategoriesEvent()),
        ),
        BlocProvider(
          create: (context) => AppDependencies.sl<ProductsBloc>()
            ..add(FetchAllProductsEvent(
                params: FetchProductsParams(limit: limit, offset: offset))),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: SvgPicture.asset(Assets.iconsAppLogo),
            backgroundColor: context.surface,
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: AppIconButton(
                  iconWidget: SvgPicture.asset(Assets.iconsBagIcon),
                  onTap: () {
                    context.pushNamed(AppScreens.cart.name);
                  },
                ),
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppConst.kScreenHorizontalPadding,
            ),
            child: Column(
              children: [
                _CategoriesSection(),
                20.verticalSpace,
                Expanded(child: _ProductsSection()),
              ],
            ),
          ),
        );
      }),
    );
  }
}
