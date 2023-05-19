import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hassadak_seller/components/back_with_title.dart';
import 'package:hassadak_seller/constants/color_manager.dart';
import 'package:hassadak_seller/constants/custom_text.dart';
import 'package:hassadak_seller/constants/shimmer.dart';
import 'package:hassadak_seller/pages/my_products/components/build_products_builder.dart';

import 'all_products/cubit.dart';
import 'categories/cubit.dart';

class MyProductsView extends StatefulWidget {
  const MyProductsView({Key? key}) : super(key: key);

  @override
  State<MyProductsView> createState() => _MyProductsViewState();
}

class _MyProductsViewState extends State<MyProductsView> with TickerProviderStateMixin {
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
      final categoriesCubit = AllCategoriesCubit.get(context);

      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: backWithTitle(context: context,title: "منتجاتي"),
        body: SizedBox(
          width: 1.sw,
          child: ListView(
            children: [
              BlocBuilder<AllCategoriesCubit, AllCategoriesStates>(
                builder: (context, state) {
                  if (state is AllCategoriesLoadingStates &&
                      categoriesCubit.length == null) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 20.w),
                      child: SizedBox(
                        height: 20.h,
                        child: ListView.separated(
                          itemCount: 5,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => SizedBox(
                            width: 10.w,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return ContainerShimmer(
                              height: 20.h,
                              width: 0.3.sw,
                              margin: EdgeInsets.all(0.h),
                              padding: EdgeInsets.all(0.h),
                              radius: 5.r,
                            );
                          },
                        ),
                      ),
                    );
                  }
                  return TabBar(
                    isScrollable: true,
                    controller: tabController,
                    labelColor: ColorManager.secMainColor,
                    labelStyle: GoogleFonts.almarai(
                      textStyle: TextStyle(
                        color: ColorManager.secMainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                    unselectedLabelColor: ColorManager.grey,
                    unselectedLabelStyle: GoogleFonts.almarai(
                      textStyle: TextStyle(
                        color: ColorManager.secMainColor,
                        fontSize: 15.sp,
                      ),
                    ),
                    indicatorColor: Colors.transparent,
                    tabs: List.generate(
                      tabController!.length,
                          (index) =>
                          BlocBuilder<AllCategoriesCubit, AllCategoriesStates>(
                            builder: (context, state) {
                              if (state is AllCategoriesFailedStates) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 5.h),
                                  child: CustomText(
                                    text: "فشل",
                                    color: ColorManager.mainColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                );
                              } else if (state is AllCategoriesSuccessStates) {
                                allProductsCubit.getAllProducts(
                                  id: "?categoryId=${categoriesCubit.allCategories?.data.doc[currentIndex].id}",
                                );
                              }
                              return Tab(
                                text: categoriesCubit
                                    .allCategories?.data.doc[index].name,
                              );
                            },
                          ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 270.h,
                child: TabBarView(
                  controller: tabController,
                  children: List.generate(
                    tabController!.length,
                        (index) => BuildProductsBuilder(
                      allProductsCubit: allProductsCubit,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
