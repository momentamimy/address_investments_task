part of '../screen/home_screen.dart';

class _CategoriesSection extends StatelessWidget {
  const _CategoriesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: context.titleMedium,
        ),
        SizedBox(
          height: 130.h,
          child: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              if (state is FetchCategoriesProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is FetchCategoriesComplete) {
                if (state.categories.isEmpty) {
                  return const Center(
                    child: Text('No categories found'),
                  );
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsetsDirectional.only(end: 8.w),
                      child: Center(
                        child: SizedBox(
                          width: 100.r,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CachedNetworkImage(
                                imageUrl: state.categories[index].image,
                                fit: BoxFit.cover,
                                imageBuilder: (context, imageProvider) =>
                                    ClipOval(
                                        child: Image(
                                  fit: BoxFit.cover,
                                  width: 80.r,
                                  height: 80.r,
                                  image: imageProvider,
                                )),
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  Assets.imagesCategoryPlaceHolderImage,
                                  width: 80.r,
                                  height: 80.r,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              10.verticalSpace,
                              Text(
                                state.categories[index].name,
                                style: context.labelLarge,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              if (state is FetchCategoriesError) {
                return Center(
                  child: Text(state.error),
                );
              }
              return SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
