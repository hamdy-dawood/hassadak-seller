import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak_seller/components/error_network.dart';
import 'package:hassadak_seller/components/svg_icons.dart';
import 'package:hassadak_seller/constants/color_manager.dart';
import 'package:hassadak_seller/constants/shimmer.dart';
import 'package:hassadak_seller/constants/strings.dart';
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
    return BlocBuilder<AllProductsCubit, AllProductsStates>(
      builder: (context, state) {
        if (state is AllProductsLoadingState) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return ContainerShimmer(
                height: 100.h,
                width: 0.5.sw,
                margin: EdgeInsets.only(right: 10.w),
                padding: EdgeInsets.all(0.h),
              );
            },
          );
        } else if (state is AllProductsFailedState) {
          return Text(state.msg);
        } else if (state is NetworkErrorState) {
          return ErrorNetwork(reloadButton: false, press: () {});
        } else {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: allProductsCubit.allProducts!.data!.doc!.length,
            itemBuilder: (context, index) {
              final product = allProductsCubit.allProducts!.data!.doc![index];
              return InkWell(
                onTap: () {
                  navigateTo(
                    page: DetailsView(
                      id: "${product.id}",
                      image:
                          "${product.productUrl}",
                      userImage: UrlsStrings.userImageUrl,
                      productName:
                          "${product.name}",
                      userName:
                          "${product.uploaderName}",
                      desc:
                          "${product.desc}",
                      phone:
                          "${product.sellerPhone}",
                      price:
                          "${product.price}",
                      oldPrice:
                          "${product.price! - (product.price! * 0.2)}",
                      ratingsAverage: (allProductsCubit
                              .allProducts!.data!.doc![index].ratingsAverage)!
                          .toInt(),
                      ratingsQuantity: (allProductsCubit
                          .allProducts!.data!.doc![index].ratingsQuantity!),
                    ),
                  );
                },
                child: ProductItem(
                  favIcon: SvgIcon(
                    icon: "assets/icons/heart.svg",
                    color: ColorManager.white,
                    height: 18.h,
                  ),
                  favTap: () {
                  },
                  offer: 'خصم 20%',
                  image: "${product.productUrl}",
                  title: "${product.name}",
                  userName: "${product.uploaderName}",
                  userImage: 'assets/images/user.png',
                  price: "${product.price}",
                  oldPrice: "${product.price! - (product.price! * 0.2)}",
                ),
              );
            },
          );
        }
      },
    );
  }
}
