import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak_seller/components/custom_elevated.dart';
import 'package:hassadak_seller/constants/color_manager.dart';
import 'package:hassadak_seller/constants/custom_text.dart';
import 'package:hassadak_seller/core/cache_helper.dart';
import 'package:hassadak_seller/core/snack_and_navigate.dart';
import 'package:hassadak_seller/pages/about/view.dart';
import 'package:hassadak_seller/pages/login/view.dart';
import 'package:hassadak_seller/pages/update_password/view.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/build_container_shadow.dart';
import 'personal_data/view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SizedBox(
        width: 1.sw,
        height: 1.sh,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              SizedBox(
                height: 0.02.sh,
              ),
              ContainerWithShadow(
                onTap: () {
                  navigateTo(page: const PersonalDataView());
                },
                image: "assets/icons/user.svg",
                title: "المعلومات الشخصية ",
                color: ColorManager.secMainColor,
              ),
              ContainerWithShadow(
                onTap: () {
                  navigateTo(page: const UpdatePasswordView());
                },
                image: "assets/icons/setting.svg",
                title: "الاعدادات",
                color: ColorManager.secMainColor,
              ),
              ContainerWithShadow(
                onTap: () {
                  _launchInBrowser(Uri.parse(
                      "https://www.linkedin.com/in/sec-it-developer-653a73238/"));
                },
                image: "assets/icons/help.svg",
                title: "عن المطورين",
                color: ColorManager.secMainColor,
              ),
              ContainerWithShadow(
                onTap: () {
                  navigateTo(page: const AboutView());
                },
                image: "assets/icons/about.svg",
                title: "عن التطبيق",
                color: ColorManager.secMainColor,
              ),
              ContainerWithShadow(
                onTap: () {
                  showDialog(
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: CustomText(
                            text: "تسجيل الخروج",
                            color: ColorManager.mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.sp,
                          ),
                          content: CustomText(
                            text: "هل انت متأكد من تسجيل الخروج؟",
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
                            CustomElevated(
                              press: () {
                                navigateTo(
                                    page: const LoginView(),
                                    withHistory: false);
                                CacheHelper.removeToken();
                                CacheHelper.removeId();
                              },
                              text: "خروج",
                              wSize: 100.w,
                              hSize: 40.sp,
                              borderRadius: 5.r,
                              btnColor: ColorManager.mainColor,
                            )
                          ],
                        );
                      },
                      context: context);
                },
                image: "assets/icons/logout.svg",
                title: "تسجيل الخروج",
                color: ColorManager.red,
                arrow: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
