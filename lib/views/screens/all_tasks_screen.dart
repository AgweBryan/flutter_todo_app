import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/colors.dart';
import 'package:flutter_todo_app/controllers/home_controller.dart';
import 'package:flutter_todo_app/controllers/theme_controller.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:flutter_todo_app/views/widgets/bottom_sheet_button.dart';
import 'package:flutter_todo_app/views/widgets/task_tile.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AllTasksScreen extends StatelessWidget {
  AllTasksScreen({Key? key}) : super(key: key);

  final _themeController = Get.find<ThemeController>();
  final _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Obx(
        () => _homeController.myTasks.isEmpty
            ? Center(
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/appicon.png'),
                      Text('You do not have any tasks yet!',
                          style: GoogleFonts.lato(
                            fontSize: 14.sp,
                          )),
                      Text('Add new tasks to make your day productive',
                          style: GoogleFonts.lato(
                            fontSize: 14.sp,
                          ))
                    ],
                  ),
                ),
              )
            : _showTasks(),
      ),
    );
  }

  _appBar() {
    return AppBar(
      toolbarHeight: 60.h,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.arrow_back_ios,
          color: _themeController.color,
        ),
      ),
      title: Text(
        'All Tasks',
        style: GoogleFonts.lato(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: _themeController.color),
      ),
    );
  }

  _showTasks() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      itemCount: _homeController.myTasks.length,
      itemBuilder: (context, i) {
        final data = _homeController.myTasks[i];
        return GestureDetector(
          onTap: () {
            _showBottomSheet(context, data);
          },
          child: TaskTile(task: data),
        );
      },
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    final double height = MediaQuery.of(context).size.height;
    Get.bottomSheet(
      Container(
        color: Get.isDarkMode ? darkGreyClr : Colors.white,
        padding: EdgeInsets.only(
          top: 8,
        ),
        height: task.isCompleted == 1 ? height * .3.h : height * .4.h,
        child: Column(
          children: [
            Container(
              height: 6.h,
              width: 120.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  15.r,
                ),
                color: Get.isDarkMode ? Colors.black : Colors.grey.shade300,
              ),
            ),
            Spacer(),
            task.isCompleted == 1
                ? Container()
                : BottomSheetButton(
                    label: 'Task Complete',
                    onTap: () {
                      _homeController.upDateTask(task.id.toString());
                      _homeController.getTasks();
                      Get.back();
                      Get.snackbar(
                        'Completed!',
                        'Task "${task.title}" completed!',
                        backgroundColor: Get.isDarkMode
                            ? Color(0xFF212121)
                            : Colors.grey.shade100,
                        colorText: Get.isDarkMode ? Colors.white : Colors.black,
                      );
                    },
                    color: primaryColor,
                  ),
            BottomSheetButton(
              label: 'Delete Task',
              onTap: () {
                _homeController.deleteTask(task.id.toString());
                _homeController.getTasks();
                Get.back();
                Get.snackbar(
                  'Delete success',
                  'Task "${task.title}" deleted.',
                  backgroundColor:
                      Get.isDarkMode ? Color(0xFF212121) : Colors.grey.shade100,
                  colorText: Get.isDarkMode ? Colors.white : Colors.black,
                );
              },
              color: pinkClr,
            ),
            SizedBox(
              height: 20.h,
            ),
            BottomSheetButton(
              label: 'Close',
              onTap: () {
                Get.back();
              },
              color: pinkClr,
              isClosed: true,
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
