import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hassadak_seller/constants/color_manager.dart';
import 'package:hassadak_seller/constants/custom_text.dart';
import 'package:hassadak_seller/constants/strings.dart';
import 'package:progress_indicators/progress_indicators.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.offer,
    required this.image,
    required this.title,
    required this.userName,
    required this.userImage,
    required this.price,
    required this.oldPrice,
    required this.favTap,
    required this.favIcon,
  }) : super(key: key);
  final String offer, image, title, userName, userImage, price, oldPrice;
  final VoidCallback favTap;
  final Widget favIcon;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Banner(
        color: ColorManager.green,
        location: BannerLocation.topEnd,
        message: offer,
        textStyle: GoogleFonts.almarai(
          textStyle: TextStyle(
            color: ColorManager.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(right: 10.w),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: ColorManager.navGrey,
            ),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                ),
                child: SizedBox(
                  height: 150.h,
                  width: 0.47.sw,
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: image.replaceAll(
                          "https://mobizil.com/oppo-f3-specs/",
                          UrlsStrings.noImageUrl),
                      placeholder: (context, url) =>
                          JumpingDotsProgressIndicator(
                        fontSize: 50.h,
                        color: ColorManager.secMainColor,
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Image.asset("assets/images/no_image.png"),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: InkWell(
                    onTap: favTap,
                    child: CircleAvatar(
                      radius: 20.r,
                      backgroundColor: ColorManager.navGrey,
                      child: favIcon,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: 0.47.sw,
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: ColorManager.navGrey,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: title,
                          color: ColorManager.mainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                          maxLines: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Row(
                            children: [
                              ClipOval(
                                child: CircleAvatar(
                                  radius: 15.r,
                                  backgroundColor: ColorManager.secMainColor,
                                  child: CachedNetworkImage(
                                      fit: BoxFit.contain,
                                      imageUrl: userImage,
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
                                width: 5.w,
                              ),
                              Expanded(
                                child: CustomText(
                                  text: userName,
                                  color: ColorManager.mainColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomText(
                                text: "$price دينار",
                                color: ColorManager.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              child: CustomText(
                                text: "$oldPrice دينار",
                                color: ColorManager.navGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                                textDecoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
