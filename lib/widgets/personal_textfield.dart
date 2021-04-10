import 'package:dating_app/resourses/colors.dart';
import 'package:dating_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class PersonalTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final Function(String) onChanged;
  final String hintText;
  final bool isMistake;
  final FocusNode focusNode;
  final bool isFull;

  PersonalTextField(
      {this.text,
        this.controller,
        this.onChanged,
        this.hintText,
        this.isMistake,
        this.focusNode,
        this.isFull});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              color: isMistake != null && isMistake == true
                  ? AppColors.mistake
                  : AppColors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 10),
          CustomTextField(
            hintText: hintText,
            controller: controller,
            onChanged: onChanged,
            minLines: 1,
            maxLines: 4,
            isMistake: isMistake != null ? isMistake : false,
            focusNode: focusNode,
            isFull: isFull,
          ),
        ],
      ),
    );
  }
}