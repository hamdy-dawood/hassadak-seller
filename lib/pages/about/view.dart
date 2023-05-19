import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hassadak_seller/components/back_with_title.dart';
import 'package:hassadak_seller/components/custom_elevated.dart';
import 'package:hassadak_seller/components/custom_text_field_expands.dart';
import 'package:hassadak_seller/components/svg_icons.dart';
import 'package:hassadak_seller/constants/color_manager.dart';
import 'package:hassadak_seller/constants/custom_text.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: backWithTitle(
        context: context,
        title: "عن التطبيق",
      ),
      body: SizedBox(
        width: 1.sw,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: SvgIcon(
                  icon: "assets/icons/logo.svg",
                  color: ColorManager.green,
                  height: 70.h,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomText(
                text: "عن الشركة",
                color: ColorManager.mainColor,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomText(
                text:
                    "تطبيق حصادك  متجر للشركات لحجز او شراء المنتجات من خلال شركات و متاجر ",
                color: ColorManager.mainColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomText(
                text: "للتواصل",
                color: ColorManager.mainColor,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      "assets/icons/whatsapp.svg",
                      height: 50.h,
                    ),
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      "assets/icons/twitter.svg",
                      height: 50.h,
                    ),
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      "assets/icons/instagram.svg",
                      height: 50.h,
                    ),
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      "assets/icons/facebook.svg",
                      height: 50.h,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomText(
                text: "للشكاوي او الاقتراحات",
                color: ColorManager.mainColor,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 10.h,
              ),
              TextFieldWithExpands(
                controller: textController,
                title: "",
                hint: "اضافة شكوي او اقتراح",
                expands: true,
                height: 100,
                validator: (value) {
                  return null;
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomElevated(
                text: "ارسال",
                press: () {
                  textController.clear();
                },
                hSize: 50.h,
                wSize: 1.sw,
                btnColor: ColorManager.secMainColor,
                borderRadius: 12.r,
                fontSize: 20.sp,
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
