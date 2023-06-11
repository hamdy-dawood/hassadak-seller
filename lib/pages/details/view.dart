import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak_seller/components/back_with_title.dart';
import 'package:hassadak_seller/components/custom_elevated.dart';
import 'package:hassadak_seller/components/svg_icons.dart';
import 'package:hassadak_seller/constants/color_manager.dart';
import 'package:hassadak_seller/constants/custom_text.dart';
import 'package:hassadak_seller/core/snack_and_navigate.dart';
import 'package:hassadak_seller/pages/bottom_nav_bar/view.dart';
import 'package:hassadak_seller/pages/delete_product/cubit.dart';
import 'package:hassadak_seller/pages/delete_product/states.dart';
import 'package:hassadak_seller/pages/edit_product/view.dart';
import 'package:progress_indicators/progress_indicators.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({
    Key? key,
    required this.id,
    required this.productName,
    required this.price,
    required this.oldPrice,
    required this.desc,
    required this.ratingsAverage,
    required this.image,
    required this.ratingsQuantity,
    required this.userImage,
    required this.userName,
    required this.phone,
    required this.isOffer,
    required this.discountPerc,
  }) : super(key: key);

  final String id,
      productName,
      desc,
      price,
      oldPrice,
      image,
      userImage,
      userName,
      phone,
      discountPerc;
  final num ratingsAverage, ratingsQuantity;
  final bool isOffer;

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final deleteCubit = DeleteProductCubit.get(context);
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: backWithTitle(
          context: context,
          title: "",
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 0.35.sh,
              child: Center(
                child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  imageUrl: widget.image,
                  placeholder: (context, url) => JumpingDotsProgressIndicator(
                    fontSize: 100.h,
                    color: ColorManager.secMainColor,
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: Image.asset("assets/images/no_image.png"),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 1.sw,
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: CircleAvatar(
                            radius: 20.r,
                            backgroundColor: ColorManager.mainColor,
                            child: CachedNetworkImage(
                              fit: BoxFit.contain,
                              imageUrl: widget.userImage,
                              placeholder: (context, url) =>
                                  JumpingDotsProgressIndicator(
                                fontSize: 20.h,
                                color: ColorManager.secMainColor,
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: Image.asset("assets/images/user.png"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        CustomText(
                          text: widget.userName,
                          color: ColorManager.mainColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 20.sp,
                        ),
                        const Spacer(),
                        Expanded(
                          child: Column(
                            children: [
                              CustomText(
                                text: "${widget.price} دينار",
                                color: ColorManager.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                              ),
                              widget.isOffer
                                  ? CustomText(
                                      text: "${widget.oldPrice} دينار",
                                      color: ColorManager.navGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                      textDecoration:
                                          TextDecoration.lineThrough,
                                      maxLines: 1,
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomText(
                      text: widget.productName,
                      color: ColorManager.mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: SvgIcon(
                              icon: "assets/icons/fill_star.svg",
                              height: 22.h,
                              color: ColorManager.secMainColor,
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          CustomText(
                            text: "${widget.ratingsAverage}",
                            color: ColorManager.mainColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.normal,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: SvgIcon(
                              icon: "assets/icons/line.svg",
                              height: 22.h,
                              color: ColorManager.secMainColor,
                            ),
                          ),
                          CustomText(
                            text: "التقييمات",
                            color: ColorManager.mainColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.normal,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Icon(
                            Icons.arrow_back_ios_new,
                            size: 18.sp,
                            color: ColorManager.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ExpansionTile(
                      iconColor: const Color(0xb3464646),
                      initiallyExpanded: false,
                      title: CustomText(
                        text: "تفاصيل المنتج",
                        color: const Color(0xb3464646),
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                      children: [
                        ListTile(
                          title: CustomText(
                            text: widget.desc,
                            color: ColorManager.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomElevated(
                            text: "تعديل المنتج",
                            press: () {
                              navigateTo(
                                  page: EditProductView(
                                id: widget.id,
                                image: widget.image,
                                productName: widget.productName,
                                price: widget.price,
                                discountPerc: widget.discountPerc,
                                description: widget.desc,
                              ));
                            },
                            hSize: 50.h,
                            btnColor: ColorManager.secMainColor,
                            borderRadius: 12.r,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: CustomElevated(
                            text: "حذف المنتج",
                            hSize: 50.h,
                            btnColor: ColorManager.backGreyWhite,
                            borderRadius: 12.r,
                            fontSize: 16.sp,
                            textColor: Colors.black,
                            press: () {
                              showDialog(
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: CustomText(
                                        text: "حذف المنتج",
                                        color: ColorManager.mainColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.sp,
                                      ),
                                      content: CustomText(
                                        text: "هل انت متأكد من حذف المنتج؟",
                                        color: ColorManager.mainColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18.sp,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: CustomText(
                                            text: "الغاء",
                                            fontSize: 18.sp,
                                            color: ColorManager.navGrey,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        BlocConsumer<DeleteProductCubit,
                                            DeleteProductStates>(
                                          listener: (context, state) {
                                            if (state
                                                is DeleteProductFailureState) {
                                              Navigator.pop(context);
                                              showMessage(
                                                  message: state.msg,
                                                  height: 40.h,
                                                  maxLines: 5);
                                            } else if (state
                                                is DeleteProductSuccessState) {
                                              Navigator.pop(context);
                                              showMessage(
                                                  message: "تم الحذف.. ");
                                              navigateTo(
                                                  page: const NavBarView(),
                                                  withHistory: false);
                                            }
                                          },
                                          builder: (context, state) {
                                            if (state
                                                is DeleteProductLoadingState) {
                                              return JumpingDotsProgressIndicator(
                                                fontSize: 50.h,
                                                color:
                                                    ColorManager.secMainColor,
                                              );
                                            }
                                            return CustomElevated(
                                              press: () {
                                                deleteCubit.deleteProduct(
                                                    id: widget.id);
                                              },
                                              text: "حذف",
                                              wSize: 100.w,
                                              hSize: 40.sp,
                                              borderRadius: 5.r,
                                              btnColor: ColorManager.red,
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                  context: context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
