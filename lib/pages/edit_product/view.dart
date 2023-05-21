import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hassadak_seller/components/back_with_title.dart';
import 'package:hassadak_seller/components/custom_elevated.dart';
import 'package:hassadak_seller/components/custom_text_field_expands.dart';
import 'package:hassadak_seller/constants/color_manager.dart';
import 'package:hassadak_seller/constants/input_validator.dart';
import 'package:hassadak_seller/core/snack_and_navigate.dart';
import 'package:hassadak_seller/pages/bottom_nav_bar/view.dart';
import 'package:hassadak_seller/pages/profile/components/build_text_field_with_text.dart';
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
                          onTap: () async {
                            final result = await FilePicker.platform
                                .pickFiles(type: FileType.image);
                            if (result != null) {
                              selectImage = File(result.files.single.path!);
                              setState(() {});
                            }
                          },
                          child: SizedBox(
                            height: 120.h,
                            width: 100.h,
                            child:
                                SvgPicture.asset("assets/images/add_image.svg"),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        selectImage == null
                            ? const SizedBox()
                            : Stack(
                                children: [
                                  Container(
                                    height: 120.h,
                                    width: 100.h,
                                    decoration: BoxDecoration(
                                      color: ColorManager.lightGrey,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(12.w),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        child: selectImage == null
                                            ? const SizedBox()
                                            : Image.file(
                                                selectImage!,
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
                                        selectImage = null;
                                        setState(() {});
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
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    TextFieldWithText(
                      controller: cubit.controllers.nameController,
                      title: "اسم المنتج",
                      hint: widget.productName,
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
                            controller:
                                cubit.controllers.discountPercController,
                            title: "الخصم",
                            hint: widget.discountPerc,
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
                         // showMessage(message: "فشل تعديل المنتج");
                           showMessage(
                               message: state.msg, height: 80.h, maxLines: 10);
                        } else if (state is EditProductSuccessState) {
                          showMessage(message: "تم التعديل ");
                          navigateTo(
                              page: const NavBarView(), withHistory: false);
                          // cubit.clearController();
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
                            cubit.editProduct(id: widget.id);
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
