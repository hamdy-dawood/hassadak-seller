import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hassadak_seller/constants/color_manager.dart';
import 'package:hassadak_seller/constants/custom_text.dart';

class TextFieldWithText extends StatelessWidget {
  const TextFieldWithText({
    Key? key,
    required this.title,
    required this.hint,
    this.autoValidate = AutovalidateMode.onUserInteraction,
    this.keyboardType = TextInputType.text,
    this.isLastInput = false,
    required this.validator,
    this.height = 50,
    this.expands = false,
  }) : super(key: key);

  final String title, hint;
  final AutovalidateMode autoValidate;
  final TextInputType? keyboardType;
  final bool isLastInput, expands;
  final FormFieldValidator validator;
  final double height;

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
              autovalidateMode: autoValidate,
              textInputAction:
                  isLastInput ? TextInputAction.done : TextInputAction.next,
              validator: validator,
              keyboardType: keyboardType,
              maxLines: expands ? null : 1,
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
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorManager.lightGrey,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorManager.red,
                    ),
                    borderRadius: BorderRadius.circular(12.r)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorManager.red,
                    ),
                    borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
