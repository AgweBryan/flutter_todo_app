import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/colors.dart';
import 'package:flutter_todo_app/constants/theme.dart';
import 'package:flutter_todo_app/controllers/theme_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatelessWidget {
  final String title;
  final String note;
  final String startTime;
  NotificationScreen({
    Key? key,
    required this.title,
    required this.note,
    required this.startTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Get.find<ThemeController>().color,
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .78.w,
          child: Column(
            children: [
              SizedBox(
                height: 18.h,
              ),
              Text(
                'Hello there!',
                style: Themes().headingTextStyle,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                'You have a new reminder',
                style: Themes().subHeadingTextStyle,
              ),
              SizedBox(
                height: 38.h,
              ),
              Container(
                height: 320.h,
                width: double.infinity.w,
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                  vertical: 30.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    40.r,
                  ),
                  color: primaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.text_fields_sharp,
                          size: 23.sp,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 18.w,
                        ),
                        Text(
                          'Title',
                          style: GoogleFonts.lato(
                            fontSize: 24.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      title,
                      style: GoogleFonts.lato(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.notes_outlined,
                          size: 23.sp,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 18.w,
                        ),
                        Text(
                          'Description',
                          style: GoogleFonts.lato(
                            fontSize: 24.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      note,
                      style: GoogleFonts.lato(
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 23.sp,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 18.w,
                        ),
                        Text(
                          'Time',
                          style: GoogleFonts.lato(
                            fontSize: 24.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      startTime,
                      style: GoogleFonts.lato(
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
