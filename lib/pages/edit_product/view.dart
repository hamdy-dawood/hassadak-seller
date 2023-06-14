import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hassadak_seller/components/back_with_title.dart';
import 'package:hassadak_seller/components/custom_elevated.dart';
import 'package:hassadak_seller/components/custom_text_field_expands.dart';
import 'package:hassadak_seller/constants/color_manager.dart';
import 'package:hassadak_seller/constants/input_validator.dart';
import 'package:hassadak_seller/core/snack_and_navigate.dart';
import 'package:hassadak_seller/pages/bottom_nav_bar/view.dart';
import 'package:hassadak_seller/pages/profile/components/build_text_field_with_text.dart';
import 'package:hassadak_seller/pages/upload_product_photo/view.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'cubit.dart';
import 'states.dart';

class EditProductView extends StatefulWidget {
  const EditProductView(
      {Key? key,
      required this.id,
      required this.image,
      required this.productName,
      required this.price,
      required this.discountPerc,
      required this.description})
      : super(key: key);
  final String id, image, productName, price, discountPerc, description;

  @override
  State<EditProductView> createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  File? selectImage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProductCubit(),
      child: Builder(builder: (context) {
        final cubit = EditProductCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.white,
          appBar: backWithTitle(context: context, title: "تعديل المنتج"),
          body: SizedBox(
            width: 1.sw,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: cubit.formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: ListView(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            navigateTo(
                                page: UploadProductPhotoView(
                              productID: widget.id,
                            ));
                          },
                          child: SizedBox(
                            height: 120.h,
                            width: 100.h,
                            child:
                                SvgPicture.asset("assets/images/add_image.svg"),
                          ),
                        ),
                        SizedBox(width: 30.w),
                        CustomElevated(
                          text: "تعديل الصورة",
                          press: () {
                            navigateTo(
                                page: UploadProductPhotoView(
                              productID: widget.id,
                            ));
                          },
                          wSize: 120.w,
                          hSize: 30.h,
                          btnColor: ColorManager.secMainColor,
                          borderRadius: 10.r,
                          fontSize: 12.sp,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 0.05.sh,
                    ),
                    TextFieldWithText(
                      controller: cubit.controllers.nameController,
                      title: "اسم المنتج",
                      hint: widget.productName,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "من فضلك اكتب اسم المنتج !";
                        } else if (value.length < 5) {
                          return "يجب الا يقل الاسم عن 5 احرف !";
                        } else {
                          return null;
                        }
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFieldWithText(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: cubit.controllers.priceController,
                            title: "سعر المنتج",
                            hint: widget.price,
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
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller:
                                cubit.controllers.discountPercController,
                            title: "الخصم",
                            hint: widget.discountPerc,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              int? numericValue = int.tryParse(value);
                              if (numericValue != null && numericValue > 90) {
                                return "اقصي سعر للخصم 90 %";
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
                      hint: widget.description,
                      expands: true,
                      validator: descriptionValidator,
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    BlocConsumer<EditProductCubit, EditProductStates>(
                      listener: (context, state) {
                        if (state is EditProductFailureState) {
                          showMessage(message: "فشل تعديل المنتج");
                        } else if (state is EditNetworkErrorState) {
                          showMessage(message: "يرجي التحقق من الانترنت !");
                        } else if (state is EditProductSuccessState) {
                          showMessage(message: "تم التعديل ");
                          navigateTo(
                              page: const NavBarView(), withHistory: false);
                        }
                      },
                      builder: (context, state) {
                        if (state is EditProductLoadingState) {
                          return JumpingDotsProgressIndicator(
                            fontSize: 50.h,
                            color: ColorManager.secMainColor,
                          );
                        }
                        return CustomElevated(
                          text: "تعديل",
                          press: () {
                            if (cubit.controllers.discountPercController.text !=
                                "") {
                              cubit.editProduct(
                                id: widget.id,
                                discount: {
                                  "discount": "Success",
                                },
                                discountPerc: {
                                  "discountPerc": cubit
                                      .controllers.discountPercController.text,
                                },
                              );
                            } else {
                              cubit.editProduct(id: widget.id);
                            }
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
