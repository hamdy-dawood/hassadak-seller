import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hassadak_seller/constants/color_manager.dart';
import 'package:hassadak_seller/constants/custom_text.dart';

class TextFieldWithExpands extends StatelessWidget {
  const TextFieldWithExpands({
    Key? key,
    required this.hint,
    this.autoValidate = AutovalidateMode.onUserInteraction,
    this.keyboardType = TextInputType.text,
    required this.validator,
    this.height = 80,
    this.expands = false,
    this.controller,
    required this.title,
  }) : super(key: key);

  final String title, hint;
  final AutovalidateMode autoValidate;
  final TextInputType? keyboardType;
  final bool expands;
  final FormFieldValidator validator;
  final double height;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            color: ColorManager.black,
            fontWeight: FontWeight.normal,
            fontSize: 18.sp,
          ),
          SizedBox(
            height: 8.h,
          ),
          SizedBox(
            height: height.h,
            child: TextFormField(
              controller: controller,
              autovalidateMode: autoValidate,
              validator: validator,
              keyboardType: keyboardType,
              maxLines: null,
              expands: expands,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.almarai(
                  textStyle: TextStyle(
                    color: ColorManager.grey,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                filled: true,
                fillColor: ColorManager.lightGrey,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorManager.grey,
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorManager.grey,
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorManager.red,
                    ),
                    borderRadius: BorderRadius.circular(20.r)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorManager.red,
                    ),
                    borderRadius: BorderRadius.circular(20.r)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
