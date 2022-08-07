import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/colors.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  TaskTile({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.only(
        bottom: 10.h,
      ),
      width: double.infinity.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17.r),
        color: _getBackgroundClr(task.color ?? 0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title!,
                  style: GoogleFonts.lato(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey.shade200,
                      size: 18.sp,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      '${task.startTime!} - ${task.endTime!}',
                      style: GoogleFonts.lato(
                        fontSize: 13.sp,
                        color: Colors.grey.shade100,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  task.note!,
                  style: GoogleFonts.lato(
                    fontSize: 13.sp,
                    color: Colors.grey.shade100,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 10.w,
            ),
            height: 62.h,
            width: 0.3.w,
            color: Colors.grey.shade200.withOpacity(.7),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task.isCompleted == 1 ? 'COMPLETE' : 'TODO',
              style: GoogleFonts.lato(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getBackgroundClr(int no) {
    switch (no) {
      case 0:
        return primaryColor;
      case 1:
        return pinkClr;
      case 2:
        return yellowClr;
      case 3:
        return greenClr;

      default:
        return primaryColor;
    }
  }
}
