import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hassadak_seller/components/custom_elevated.dart';
import 'package:hassadak_seller/components/custom_form_field.dart';
import 'package:hassadak_seller/components/svg_icons.dart';
import 'package:hassadak_seller/constants/color_manager.dart';
import 'package:hassadak_seller/constants/custom_text.dart';
import 'package:hassadak_seller/constants/input_validator.dart';
import 'package:hassadak_seller/core/cache_helper.dart';
import 'package:hassadak_seller/core/snack_and_navigate.dart';
import 'package:hassadak_seller/pages/login/view.dart';
import 'package:hassadak_seller/pages/register/states.dart';
import 'package:hassadak_seller/pages/upload_user_photo/view.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'cubit.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Builder(
        builder: (context) {
          final cubit = RegisterCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.white,
            body: SizedBox(
              height: 1.sh,
              width: 1.sw,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: cubit.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 0.01.sh,
                      ),
                      SvgIcon(
                        icon: "assets/icons/logo.svg",
                        color: ColorManager.green,
                        height: 60.h,
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          text: "إنشاء حساب جديد",
                          color: ColorManager.secMainColor,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 0.03.sh,
                      ),
                      CustomTextFormField(
                        controller: cubit.controllers.firstNameController,
                        keyboardType: TextInputType.text,
                        hint: "الاسم الاول",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10.0.w),
                          child: SvgIcon(
                            icon: "assets/icons/user.svg",
                            color: ColorManager.grey,
                            height: 12.h,
                          ),
                        ),
                        validator: firstNameValidator,
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      CustomTextFormField(
                        controller: cubit.controllers.lastNameController,
                        keyboardType: TextInputType.text,
                        hint: 'الاسم الاخير',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10.0.w),
                          child: SvgIcon(
                            icon: "assets/icons/user.svg",
                            color: ColorManager.grey,
                            height: 12.h,
                          ),
                        ),
                        validator: lastNameValidator,
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      CustomTextFormField(
                        controller: cubit.controllers.emailController,
                        keyboardType: TextInputType.emailAddress,
                        hint: 'البريد الالكتروني',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10.0.w),
                          child: SvgIcon(
                            icon: "assets/icons/email.svg",
                            color: ColorManager.grey,
                            height: 10.h,
                          ),
                        ),
                        validator: emailValidator,
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      CustomTextFormField(
                        controller: cubit.controllers.userNameController,
                        keyboardType: TextInputType.text,
                        hint: 'اسم المستخدم',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10.0.w),
                          child: SvgIcon(
                            icon: "assets/icons/user_name.svg",
                            color: ColorManager.grey,
                            height: 10.h,
                          ),
                        ),
                        validator: userNameValidator,
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      CustomTextFormField(
                        controller: cubit.controllers.phoneController,
                        keyboardType: TextInputType.phone,
                        hint: "رقم الهاتف",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10.0.w),
                          child: SvgIcon(
                            icon: "assets/icons/phone.svg",
                            color: ColorManager.grey,
                            height: 10.h,
                          ),
                        ),
                        validator: phoneValidator,
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      CustomTextFormField(
                        controller: cubit.controllers.whatsappController,
                        keyboardType: TextInputType.phone,
                        hint: "رقم الواتساب",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10.0.w),
                          child: SvgPicture.asset(
                            "assets/icons/whatsapp.svg",
                            height: 10.h,
                          ),
                        ),
                        validator: whatsappValidator,
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      CustomTextFormField(
                        controller: cubit.controllers.facebookUrlController,
                        keyboardType: TextInputType.text,
                        hint: "رابط الفيسبوك",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10.0.w),
                          child: SvgPicture.asset(
                            "assets/icons/facebook.svg",
                            height: 10.h,
                          ),
                        ),
                        validator: facebookValidator,
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      CustomTextFormField(
                        controller: cubit.controllers.instaUrlController,
                        keyboardType: TextInputType.text,
                        hint: "رابط الانستجرام",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: SvgPicture.asset(
                            "assets/icons/instagram.svg",
                            height: 10.h,
                          ),
                        ),
                        validator: instaValidator,
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      CustomTextFormField(
                        controller: cubit.controllers.twitterUrlController,
                        keyboardType: TextInputType.text,
                        hint: "رابط تويتر",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: SvgPicture.asset(
                            "assets/icons/twitter.svg",
                            height: 10.h,
                          ),
                        ),
                        validator: twitterValidator,
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      CustomTextFormField(
                        controller: cubit.controllers.descriptionController,
                        keyboardType: TextInputType.text,
                        hint: "الوصف",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: SvgIcon(
                            icon: "assets/icons/edit.svg",
                            color: ColorManager.grey,
                            height: 10.h,
                          ),
                        ),
                        validator: descriptionValidator,
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      BlocBuilder<RegisterCubit, RegisterStates>(
                        builder: (context, state) {
                          return CustomTextFormField(
                            controller: cubit.controllers.passwordController,
                            hint: 'كلمة المرور',
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: SvgIcon(
                                icon: "assets/icons/lock.svg",
                                color: ColorManager.grey,
                                height: 10.h,
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                cubit.passwordVisibility();
                              },
                              icon: Icon(
                                cubit.securePass
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                              color: ColorManager.grey,
                            ),
                            obscureText: cubit.securePass,
                            isLastInput: false,
                            validator: regPasswordValidator,
                          );
                        },
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      BlocBuilder<RegisterCubit, RegisterStates>(
                        builder: (context, state) {
                          return CustomTextFormField(
                            controller:
                                cubit.controllers.confirmPasswordController,
                            hint: 'تأكيد كلمة المرور',
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: SvgIcon(
                                icon: "assets/icons/lock.svg",
                                color: ColorManager.grey,
                                height: 10.h,
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                cubit.confPasswordVisibility();
                              },
                              icon: Icon(
                                cubit.secureConfPass
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                              color: ColorManager.grey,
                            ),
                            obscureText: cubit.secureConfPass,
                            isLastInput: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'من فضلك ادخل تأكيد كلمة المرور !';
                              } else if (value !=
                                  cubit.controllers.passwordController.text) {
                                return 'كلمة المرور ليست مطابقة !';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 0.04.sh,
                      ),
                      BlocConsumer<RegisterCubit, RegisterStates>(
                        listener: (context, state) {
                          if (state is RegisterFailureState) {
                            // showMessage(message: "فشل انشاء حساب");
                            showMessage(
                                message: state.msg, height: 80.h, maxLines: 10);
                          } else if (state is RegisterSuccessState) {
                            navigateTo(page: const UploadUserPhotoView());
                            print(CacheHelper.getToken());
                          }
                        },
                        builder: (context, state) {
                          if (state is RegisterLoadingState) {
                            return JumpingDotsProgressIndicator(
                              fontSize: 50.h,
                              color: ColorManager.secMainColor,
                            );
                          }
                          return CustomElevated(
                            text: "إنشاء حساب جديد",
                            press: () {
                              cubit.register();
                            },
                            hSize: 50.h,
                            btnColor: ColorManager.secMainColor,
                            borderRadius: 20.r,
                            fontSize: 18.sp,
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "ليس لديك حساب يالفعل ؟",
                            color: ColorManager.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.normal,
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(
                                page: const LoginView(),
                              );
                            },
                            child: CustomText(
                              text: "تسجيل الدخول",
                              color: ColorManager.green,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
