import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
import 'package:hassadak_seller/pages/my_products/categories/cubit.dart';
import 'package:hassadak_seller/pages/profile/components/build_text_field_with_text.dart';
import 'package:hassadak_seller/pages/upload_product_photo/view.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductCubit(),
      child: Builder(builder: (context) {
        final cubit = AddProductCubit.get(context);
        final categoriesCubit = AllCategoriesCubit.get(context);
        categoriesCubit.getAllCategories();

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
                      padding: EdgeInsets.only(top: 5.h),
                      child: SvgIcon(
                        icon: "assets/icons/logo.svg",
                        height: 80.h,
                        color: ColorManager.green,
                      ),
                    ),
                    Row(
                      children: [
                        ClipOval(
                          child: CircleAvatar(
                            radius: 22.r,
                            backgroundColor: ColorManager.secMainColor,
                            child: CachedNetworkImage(
                              fit: BoxFit.contain,
                              imageUrl: CacheHelper.getUserPhoto(),
                              placeholder: (context, url) =>
                                  JumpingDotsProgressIndicator(
                                fontSize: 20.h,
                                color: ColorManager.secMainColor,
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: Image.asset(
                                  "assets/images/user.png",
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: CustomText(
                            text:
                                "${CacheHelper.getFirstName()} ${CacheHelper.getLastName()}",
                            color: ColorManager.mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 2,
                              color: ColorManager.navGrey,
                            ),
                          ),
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
                              thickness: 2,
                              color: ColorManager.navGrey,
                            ),
                          ),
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
                            hint: "مثال : 200 ج.م",
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
                            hint: "مثال : خصم 10 %",
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
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: ColorManager.lightGrey,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: ColorManager.grey,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: BlocBuilder<AllCategoriesCubit,
                            AllCategoriesStates>(
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
                            } else if (state is AllCategoriesLoadingStates) {
                              return SizedBox(
                                width: 1.sw,
                                child: Shimmer.fromColors(
                                  baseColor: ColorManager.shimmerBaseColor,
                                  highlightColor:
                                      ColorManager.shimmerHighlightColor,
                                  direction: ShimmerDirection.rtl,
                                  child: Container(
                                    height: 50.h,
                                    color: ColorManager.shimmerBaseColor,
                                  ),
                                ),
                              );
                            } else if (state is AllCategoriesSuccessStates) {
                              return DropdownButton<String>(
                                style: GoogleFonts.almarai(
                                  textStyle: TextStyle(
                                    color: ColorManager.black,
                                    fontSize: 20.sp,
                                  ),
                                ),
                                alignment: Alignment.center,
                                isExpanded: true,
                                iconEnabledColor: ColorManager.black,
                                dropdownColor: ColorManager.lightGrey,
                                elevation: 0,
                                borderRadius: BorderRadius.circular(20.r),
                                underline: const SizedBox.shrink(),
                                hint: Text(
                                  "اختر الفئة",
                                  style: GoogleFonts.almarai(
                                    textStyle: TextStyle(
                                      color: ColorManager.grey,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  cubit.onChangeCat(value);
                                },
                                value: cubit.selectedCatId,
                                items: List.generate(
                                  categoriesCubit
                                      .allCategories!.data.doc.length,
                                  (index) => DropdownMenuItem(
                                    value: categoriesCubit
                                        .allCategories!.data.doc[index].id,
                                    child: Text(
                                      categoriesCubit
                                          .allCategories!.data.doc[index].name,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    TextFieldWithExpands(
                      controller: cubit.controllers.descController,
                      title: "وصف المنتج",
                      hint: "اكتب الوصف",
                      expands: true,
                      validator: descriptionValidator,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    BlocConsumer<AddProductCubit, AddProductStates>(
                      listener: (context, state) {
                        if (state is AddProductFailureState) {
                          showMessage(message: "يرجي التأكد من البيانات !");
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
                            if (cubit.controllers.discountPercController.text !=
                                "") {
                              cubit.addProduct(
                                discount: {
                                  "discount": "Success",
                                },
                                discountPerc: {
                                  "discountPerc": cubit
                                      .controllers.discountPercController.text,
                                },
                              );
                            } else {
                              cubit.addProduct();
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
