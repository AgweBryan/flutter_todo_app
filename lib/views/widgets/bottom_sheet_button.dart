import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_todo_app/constants/theme.dart';

class BottomSheetButton extends StatelessWidget {
  final String label;
  final Function() onTap;
  final Color color;
  final bool isClosed;

  BottomSheetButton(
      {Key? key,
      required this.label,
      required this.onTap,
      this.isClosed = false,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 5.h,
        ),
        height: 53.h,
        width: MediaQuery.of(context).size.width * .75.w,
        decoration: BoxDecoration(
          color: isClosed ? Colors.transparent : color,
          border: Border.all(
            width: 1.w,
            color: isClosed ? Colors.grey.shade600 : color,
          ),
          borderRadius: BorderRadius.circular(
            15.r,
          ),
        ),
        alignment: Alignment.center,
        child: Text(label,
            style: isClosed
                ? Themes().titleStyle
                : Themes().titleStyle.copyWith(
                      color: Colors.white,
                    )),
      ),
    );
  }
}
