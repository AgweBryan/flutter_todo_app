import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/theme.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  InputField({
    Key? key,
    required this.hint,
    required this.title,
    this.controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 14.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Themes().titleStyle,
          ),
          Container(
            height: 48.h,
            margin: EdgeInsets.only(
              top: 6.h,
            ),
            padding: EdgeInsets.only(
              left: 14.w,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(
                10.r,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    cursorColor: Get.isDarkMode
                        ? Colors.grey.shade100
                        : Colors.grey.shade700,
                    controller: controller,
                    style: Themes().subTitleStyle,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint,
                        hintStyle: Themes().subTitleStyle),
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
