import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak_seller/constants/color_manager.dart';
import 'package:hassadak_seller/constants/custom_text.dart';
import 'package:hassadak_seller/core/cache_helper.dart';
import 'package:hassadak_seller/pages/my_products/components/build_products_builder.dart';

import 'all_products/cubit.dart';

class MyProductsView extends StatelessWidget {
  const MyProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final allProductsCubit = AllProductsCubit.get(context);
      allProductsCubit.getAllProducts(id: CacheHelper.getId());
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: 0.0,
          centerTitle: true,
          title: CustomText(
            text: "منتجاتي",
            color: ColorManager.mainColor,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: SizedBox(
          width: 1.sw,
          child: RefreshIndicator(
            backgroundColor: ColorManager.secMainColor,
            color: Colors.white,
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 300));
              allProductsCubit.getAllProducts(id: CacheHelper.getId());
            },
            child: BuildProductsBuilder(
              allProductsCubit: allProductsCubit,
            ),
          ),
        ),
      );
    });
  }
}
