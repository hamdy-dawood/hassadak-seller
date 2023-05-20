import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak_seller/constants/color_manager.dart';
import 'package:hassadak_seller/constants/custom_text.dart';
import 'package:hassadak_seller/core/cache_helper.dart';
import 'package:hassadak_seller/pages/my_products/components/build_products_builder.dart';

import 'all_products/cubit.dart';
import 'categories/cubit.dart';

class MyProductsView extends StatefulWidget {
  const MyProductsView({Key? key}) : super(key: key);

  @override
  State<MyProductsView> createState() => _MyProductsViewState();
}

class _MyProductsViewState extends State<MyProductsView>
    with TickerProviderStateMixin {
  TabController? tabController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 0);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await AllCategoriesCubit.get(context).getAllCategories();
      setState(() {
        tabController = TabController(
            vsync: this, length: AllCategoriesCubit.get(context).length!);
      });
      tabController!.addListener(() {
        currentIndex = tabController!.index;
      });
    });
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

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
          child: SizedBox(
            height: 300.h,
            child: BuildProductsBuilder(
              allProductsCubit: allProductsCubit,
            ),
          ),
        ),
      );
    });
  }
}
