import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hassadak_seller/components/custom_elevated.dart';
import 'package:hassadak_seller/components/svg_icons.dart';
import 'package:hassadak_seller/constants/color_manager.dart';
import 'package:hassadak_seller/constants/custom_text.dart';
import 'package:hassadak_seller/core/snack_and_navigate.dart';
import 'package:hassadak_seller/pages/bottom_nav_bar/view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'cubit.dart';
import 'states.dart';

class UploadProductPhotoView extends StatelessWidget {
  const UploadProductPhotoView({Key? key, required this.productID})
      : super(key: key);
  final String productID;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadProductPhotoCubit(),
      child: Builder(builder: (context) {
        final cubit = UploadProductPhotoCubit.get(context);

        return Scaffold(
          backgroundColor: ColorManager.white,
          body: SizedBox(
            width: 1.sw,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                  SizedBox(
                    height: 0.05.sh,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomText(
                      text: "اصف صورة للمنتج ",
                      color: ColorManager.secMainColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 0.1.sh,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15.r),
                              topLeft: Radius.circular(15.r),
                            ),
                          ),
                          builder: (context) {
                            return SizedBox(
                              height: 120.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50.h,
                                    width: 50.h,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: ColorManager.mainColor,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          cubit.chooseMyImage(
                                              source: ImageSource.gallery);
                                        },
                                        child: Icon(
                                          color: ColorManager.secMainColor,
                                          Icons.image,
                                          size: 30.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50.h,
                                    width: 50.h,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: ColorManager.mainColor,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          cubit.chooseMyImage(
                                              source: ImageSource.camera);
                                        },
                                        child: Icon(
                                          color: ColorManager.secMainColor,
                                          Icons.camera_alt,
                                          size: 30.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: BlocBuilder<UploadProductPhotoCubit,
                        UploadProductPhotoStates>(builder: (context, state) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15.r),
                                      topLeft: Radius.circular(15.r),
                                    ),
                                  ),
                                  builder: (context) {
                                    return SizedBox(
                                      height: 120.h,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 50.h,
                                            width: 50.h,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: ColorManager.mainColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.r)),
                                            child: Center(
                                              child: GestureDetector(
                                                onTap: () {
                                                  cubit.chooseMyImage(
                                                      source:
                                                          ImageSource.gallery);
                                                },
                                                child: Icon(
                                                  color:
                                                      ColorManager.secMainColor,
                                                  Icons.image,
                                                  size: 30.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 50.h,
                                            width: 50.h,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: ColorManager.mainColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.r)),
                                            child: Center(
                                              child: GestureDetector(
                                                onTap: () {
                                                  cubit.chooseMyImage(
                                                      source:
                                                          ImageSource.camera);
                                                },
                                                child: Icon(
                                                  color:
                                                      ColorManager.secMainColor,
                                                  Icons.camera_alt,
                                                  size: 30.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: SizedBox(
                              height: 120.h,
                              width: 100.h,
                              child: SvgPicture.asset(
                                  "assets/images/add_image.svg"),
                            ),
                          ),
                          SizedBox(width: 20.w),
                          cubit.myImage == null
                              ? const SizedBox()
                              : Stack(
                                  children: [
                                    Container(
                                      height: 120.h,
                                      width: 100.h,
                                      decoration: BoxDecoration(
                                        color: ColorManager.lightGrey,
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12.w),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          child: cubit.myImage == null
                                              ? const SizedBox()
                                              : Image.file(
                                                  cubit.myImage!,
                                                  fit: BoxFit.contain,
                                                ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: IconButton(
                                        onPressed: () {
                                          cubit.cancelImage();
                                        },
                                        icon: Icon(
                                          Icons.cancel,
                                          color: ColorManager.white,
                                          size: 30.sp,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                        ],
                      );
                    }),
                  ),
                  SizedBox(
                    height: 0.05.sh,
                  ),
                  BlocConsumer<UploadProductPhotoCubit,
                      UploadProductPhotoStates>(
                    listener: (context, state) {
                      if (state is UploadProductPhotoFailureState) {
                        showMessage(
                            message: state.msg, height: 100.h, maxLines: 10);
                      } else if (state is NetworkErrorState) {
                        showMessage(message: "يرجي التحقق من الانترنت !");
                      } else if (state is UploadProductPhotoSuccessState) {
                        showMessage(message: "تم التعديل ");
                        navigateTo(
                            page: const NavBarView(), withHistory: false);
                      }
                    },
                    builder: (context, state) {
                      if (state is UploadProductPhotoLoadingState) {
                        return JumpingDotsProgressIndicator(
                          fontSize: 50.h,
                          color: ColorManager.secMainColor,
                        );
                      }
                      return CustomElevated(
                        text: "إضافة",
                        press: () {
                          cubit.uploadPhoto(id: productID);
                        },
                        hSize: 50.h,
                        btnColor: ColorManager.secMainColor,
                        borderRadius: 20.r,
                        fontSize: 18.sp,
                      );
                    },
                  ),
                  SizedBox(
                    height: 0.15.sh,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        navigateTo(
                            page: const NavBarView(), withHistory: false);
                      },
                      child: CustomText(
                        text: "تخطي",
                        color: ColorManager.secMainColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
