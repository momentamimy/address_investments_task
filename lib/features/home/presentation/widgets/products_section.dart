part of '../screen/home_screen.dart';

class _ProductsSection extends StatefulWidget {
  const _ProductsSection();

  @override
  State<_ProductsSection> createState() => _ProductsSectionState();
}

class _ProductsSectionState extends State<_ProductsSection> {
  final PagingController<int, ProductModel> _pagingController =
      PagingController(firstPageKey: 0);
  final int _pageSize = 10;
  int _pageKey = 0;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((_) {
      _fetchPage();
    });
  }

  Future<void> _fetchPage() async {
    _pageKey = _pageKey + _pageSize;
    context.read<ProductsBloc>().add(
          FetchAllProductsEvent(
            params: FetchProductsParams(limit: _pageSize, offset: _pageKey),
          ),
        );
  }

  _updateList({required List<ProductModel> newItems, required int pageKey}) {
    final bool isLastPage = newItems.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(newItems);
    } else {
      final nextPageKey = pageKey + newItems.length;
      _pagingController.appendPage(newItems, nextPageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Products',
          style: context.titleMedium,
        ),
        Expanded(
          flex: 3,
          child: BlocConsumer<ProductsBloc, ProductsState>(
            listener: (context, state) {
              if (state is FetchProductsComplete) {
                _updateList(
                  newItems: state.products,
                  pageKey: _pageKey,
                );
              }
            },
            builder: (context, state) {
              return PagedGridView<int, ProductModel>(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.5, crossAxisCount: 2),
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<ProductModel>(
                  itemBuilder: (context, item, index) => _ProductCard(
                    product: item,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ProductCard extends StatefulWidget {
  final ProductModel product;

  const _ProductCard({required this.product});

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  late final UpdateProductCubit _updateProductCubit;

  @override
  void initState() {
    super.initState();
    _updateProductCubit = UpdateProductCubit(widget.product,
        homeRepository: AppDependencies.sl());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () => context.pushNamed(AppScreens.productDetails.name,
                    extra: widget.product),
                child: Container(
                  height: 0.3.sh,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: context.secondary,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.product.images.first,
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
              ),
              Positioned(
                right: 0,
                top: 0,
                child: AppIconButton(
                  iconWidget: SvgPicture.asset(Assets.iconsEditIcon),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => BlocProvider.value(
                        value: _updateProductCubit,
                        child: UpdateProductSheet(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          10.verticalSpace,
          BlocBuilder<UpdateProductCubit, ProductModel>(
            bloc: _updateProductCubit,
            builder: (context, state) {
              return Column(
                children: [
                  Text(
                    state.title,
                    style: context.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "\$${state.price}",
                    style: context.labelMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
