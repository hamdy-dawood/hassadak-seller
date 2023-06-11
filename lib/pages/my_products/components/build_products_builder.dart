import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak_seller/components/error_network.dart';
import 'package:hassadak_seller/components/svg_icons.dart';
import 'package:hassadak_seller/constants/color_manager.dart';
import 'package:hassadak_seller/constants/shimmer.dart';
import 'package:hassadak_seller/core/cache_helper.dart';
import 'package:hassadak_seller/core/snack_and_navigate.dart';
import 'package:hassadak_seller/pages/details/view.dart';
import 'package:hassadak_seller/pages/my_products/all_products/cubit.dart';
import 'package:hassadak_seller/pages/my_products/components/product_item.dart';

class BuildProductsBuilder extends StatelessWidget {
  const BuildProductsBuilder({
    Key? key,
    required this.allProductsCubit,
  }) : super(key: key);
  final AllProductsCubit allProductsCubit;

  @override
  Widget build(BuildContext context) {
    final double itemHeight = (1.sh - kToolbarHeight * 1.5) / 2;
    final double itemWidth = 1.sw / 2;

    return RefreshIndicator(
      backgroundColor: ColorManager.secMainColor,
      color: Colors.white,
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 300));
        allProductsCubit.getAllProducts(id: CacheHelper.getId());
      },
      child: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              BlocBuilder<AllProductsCubit, AllProductsStates>(
                builder: (context, state) {
                  if (state is AllProductsLoadingState) {
                    return Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10.w,
                          crossAxisSpacing: 10.w,
                          childAspectRatio: (itemWidth / itemHeight),
                        ),
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return ContainerShimmer(
                            height: 200.h,
                            width: 0.5.sw,
                            margin: EdgeInsets.all(0.h),
                            padding: EdgeInsets.all(0.h),
                          );
                        },
                      ),
                    );
                  } else if (state is AllProductsFailedState) {
                    return Center(child: Text(state.msg));
                  } else if (state is NetworkErrorState) {
                    return ErrorNetwork(
                      press: () {
                        allProductsCubit.getAllProducts(
                            id: CacheHelper.getId());
                      },
                    );
                  } else {
                    return Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10.w,
                          crossAxisSpacing: 0.w,
                          childAspectRatio: (itemWidth / itemHeight),
                        ),
                        itemCount:
                            allProductsCubit.allProducts!.data!.doc!.length,
                        itemBuilder: (context, index) {
                          final product =
                              allProductsCubit.allProducts!.data!.doc![index];
                          return InkWell(
                            onTap: () {
                              navigateTo(
                                page: DetailsView(
                                  id: "${product.id}",
                                  image: "${product.productUrl}",
                                  userImage: "${product.userPhoto}",
                                  productName: "${product.name}",
                                  userName: "${product.uploaderName}",
                                  desc: "${product.desc}",
                                  phone: "${product.sellerPhone}",
                                  isOffer:
                                      product.discountPerc == 0 ? false : true,
                                  oldPrice: "${product.price}",
                                  discountPerc: "${product.discountPerc}",
                                  price:
                                      "${product.price! - (product.price! * (product.discountPerc! / 100))}",
                                  ratingsAverage:
                                      (product.ratingsAverage)!.toInt(),
                                  ratingsQuantity: (product.ratingsQuantity!),
                                ),
                              );
                            },
                            child: ProductItem(
                              width: 0.44,
                              favIcon: SvgIcon(
                                icon: "assets/icons/heart.svg",
                                color: ColorManager.white,
                                height: 18.h,
                              ),
                              favTap: () {},
                              isOffer: product.discountPerc == 0 ? false : true,
                              offer: "خصم ${product.discountPerc}%",
                              image: "${product.productUrl}",
                              title: "${product.name}",
                              userName: "${product.uploaderName}",
                              userImage: "${product.userPhoto}",
                              oldPrice: "${product.price}",
                              price:
                                  "${product.price! - (product.price! * (product.discountPerc! / 100))}",
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
