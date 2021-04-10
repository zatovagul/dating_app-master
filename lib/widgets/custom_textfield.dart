import 'package:dating_app/resourses/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  //
  final String hintText;
  final TextEditingController controller;
  final int maxLines;
  final int minLines;
  final double rightPadding;
  final void Function(String) onChanged;
  final bool isMistake;
  final FocusNode focusNode;
  final bool obscure;
  final bool isFull;
  final TextInputAction textInputAction;
  final Function(String) validator;
  final Function(String) onFieldSubmitted;

  CustomTextField({
    this.hintText,
    this.controller,
    this.maxLines = 1,
    this.minLines = 1,
    this.rightPadding,
    this.onChanged,
    this.isMistake = false,
    this.focusNode,
    this.obscure,
    this.isFull,
    this.textInputAction = TextInputAction.done,
    this.validator,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFull ? context.width : context.mediaQuerySize.width / 2 - 30,
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
        textInputAction: textInputAction,
        keyboardType: TextInputType.multiline,
        textCapitalization: TextCapitalization.sentences,
        obscureText: obscure != null && obscure == true ? true : false,
        controller: controller,
        focusNode: focusNode,
        maxLines: maxLines,
        minLines: minLines,
        onChanged: onChanged,
        cursorColor: Colors.black,
        cursorWidth: 1,
        style: TextStyle(
          color: isMistake == true ? AppColors.mistake : AppColors.lightBlack,
          fontSize: 16,
          height: 1.48,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: isMistake == true ? AppColors.lightPink : AppColors.light,
          contentPadding: EdgeInsets.only(
            left: 20,
            right: rightPadding ?? 20,
            top: 20,
            bottom: 20,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: isMistake == true ? AppColors.lightPink : AppColors.grey,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.light,
            ),
            borderRadius: BorderRadius.circular(7.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.light,
            ),
            borderRadius: BorderRadius.circular(7.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.light,
            ),
            borderRadius: BorderRadius.circular(7.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.light,
            ),
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
      ),
    );
  }
  //
}
