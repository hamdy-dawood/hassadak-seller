import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak_seller/components/custom_elevated.dart';
import 'package:hassadak_seller/components/custom_text_field_expands.dart';
import 'package:hassadak_seller/components/svg_icons.dart';
import 'package:hassadak_seller/constants/color_manager.dart';
import 'package:hassadak_seller/constants/custom_text.dart';
import 'package:hassadak_seller/constants/input_validator.dart';
import 'package:hassadak_seller/core/cache_helper.dart';
import 'package:hassadak_seller/core/snack_and_navigate.dart';
import 'package:hassadak_seller/pages/add_product/cubit.dart';
import 'package:hassadak_seller/pages/add_product/states.dart';
import 'package:hassadak_seller/pages/profile/components/build_text_field_with_text.dart';
import 'package:hassadak_seller/pages/upload_product_photo/view.dart';
import 'package:hassadak_seller/pages/upload_user_photo/cubit.dart';
import 'package:hassadak_seller/pages/upload_user_photo/states.dart';
import 'package:progress_indicators/progress_indicators.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  File? selectImage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductCubit(),
      child: Builder(builder: (context) {
        final cubit = AddProductCubit.get(context);
        final userCubit = UploadUserPhotoCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.white,
          body: SizedBox(
            width: 1.sw,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: cubit.formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                      child: SvgIcon(
                        icon: "assets/icons/logo.svg",
                        color: ColorManager.green,
                        height: 50.h,
                      ),
                    ),
                    BlocBuilder<UploadUserPhotoCubit, UploadUserPhotoStates>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            ClipOval(
                              child: CircleAvatar(
                                radius: 22.r,
                                backgroundColor: ColorManager.secMainColor,
                                child: CachedNetworkImage(
                                    fit: BoxFit.contain,
                                    imageUrl:
                                        // "${userCubit.uploadUserPhotoRepo!.updatedUser!.userPhoto}",
                                        "",
                                    placeholder: (context, url) =>
                                        JumpingDotsProgressIndicator(
                                          fontSize: 20.h,
                                          color: ColorManager.secMainColor,
                                        ),
                                    errorWidget: (context, url, error) =>
                                        Center(
                                            child: Image.asset(
                                                "assets/images/user.png"))),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: CustomText(
                                text: CacheHelper.getName(),
                                color: ColorManager.mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Divider(
                                  thickness: 2, color: ColorManager.navGrey)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: CustomText(
                              text: "أضف منتجك الآن",
                              color: ColorManager.mainColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 20.sp,
                            ),
                          ),
                          Expanded(
                              child: Divider(
                                  thickness: 2, color: ColorManager.navGrey)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    TextFieldWithText(
                      controller: cubit.controllers.nameController,
                      title: "اسم المنتج",
                      hint: "مثال : مبيد حشري",
                      validator: (value) {
                        if (value.isEmpty) {
                          return "من فضلك اكتب اسم المنتج !";
                        } else {
                          return null;
                        }
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFieldWithText(
                            controller: cubit.controllers.priceController,
                            title: "سعر المنتج",
                            hint: "مثال : 200 دينار",
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "من فضلك اكتب سعر المنتج !";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 0.03.sw,
                        ),
                        Expanded(
                          child: TextFieldWithText(
                            controller:
                                cubit.controllers.discountPercController,
                            title: "الخصم",
                            hint: "مثال : خصم 10 %",
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "من فضلك اكتب الخصم !";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    TextFieldWithExpands(
                      controller: cubit.controllers.descController,
                      title: "وصف المنتج",
                      hint: "اكتب الوصف",
                      expands: true,
                      validator: descriptionValidator,
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    BlocConsumer<AddProductCubit, AddProductStates>(
                      listener: (context, state) {
                        if (state is AddProductFailureState) {
                          showMessage(
                              message: state.msg, height: 50.h, maxLines: 10);
                        } else if (state is AddProductSuccessState) {
                          showMessage(message: "تمت الإضافة ");
                          cubit.clearController();
                          navigateTo(
                            page: UploadProductPhotoView(
                              productID:
                                  "${cubit.createProductResp!.newProduct!.id}",
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AddProductLoadingState) {
                          return JumpingDotsProgressIndicator(
                            fontSize: 50.h,
                            color: ColorManager.secMainColor,
                          );
                        }
                        return CustomElevated(
                          text: "اضافة المنتج",
                          press: () {
                            cubit.addProduct();
                          },
                          hSize: 50.h,
                          btnColor: ColorManager.secMainColor,
                          borderRadius: 20.r,
                          fontSize: 18.sp,
                        );
                      },
                    ),
                    SizedBox(
                      height: 0.1.sh,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
