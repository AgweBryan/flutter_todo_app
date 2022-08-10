import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/colors.dart';
import 'package:flutter_todo_app/constants/theme.dart';
import 'package:flutter_todo_app/controllers/home_controller.dart';
import 'package:flutter_todo_app/controllers/theme_controller.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:flutter_todo_app/providers/notification_provider.dart';
import 'package:flutter_todo_app/views/screens/add_task_screen.dart';
import 'package:flutter_todo_app/views/screens/all_tasks_screen.dart';
import 'package:flutter_todo_app/views/widgets/bottom_sheet_button.dart';
import 'package:flutter_todo_app/views/widgets/button.dart';
import 'package:flutter_todo_app/views/widgets/task_tile.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController = Get.put(HomeController());

  final _themeController = Get.find<ThemeController>();

  late final NotificationProvider notificationProvider;

  @override
  void initState() {
    super.initState();
    notificationProvider = NotificationProvider();
    notificationProvider.initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: _appBar(),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _addTask(),
                SizedBox(
                  height: 12.h,
                ),
                _addDateBar(),
                _homeController.myTasks.isEmpty
                    ? Expanded(
                        child: Center(
                          child: SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/appicon.png'),
                                Text('You do not have any tasks yet!',
                                    style: GoogleFonts.lato(
                                      fontSize: 14.sp,
                                    )),
                                Text(
                                    'Add new tasks to make your day productive',
                                    style: GoogleFonts.lato(
                                      fontSize: 14.sp,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      )
                    : _showTasks(context),
                Container(
                  alignment: Alignment.center,
                  child: GestureDetector(
                      onTap: () => Get.to(() => AllTasksScreen()),
                      child: Text(
                        'Show all tasks',
                        style: Themes().headingTextStyle,
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _showTasks(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      padding: EdgeInsets.only(
        top: 10.h,
      ),
      itemCount: _homeController.myTasks.length,
      itemBuilder: (_, i) {
        final data = _homeController.myTasks[i];
        if (data.repeat == 'Daily') {
          DateTime date = DateFormat.jm().parse(data.startTime!);
          var myTime = DateFormat("HH:mm").format(date);

          notificationProvider.scheduledNotification(
            task: data,
            hour: int.parse(myTime.toString().split(':')[0]),
            minutes: int.parse(
                  myTime.toString().split(':')[1],
                ) -
                data.remind!,
          );
          return GestureDetector(
            onTap: () {
              _showBottomSheet(context, data);
            },
            child: TaskTile(task: data),
          );
        }
        if (data.date ==
            DateFormat.yMd().format(_homeController.selectedDate)) {
          return GestureDetector(
            onTap: () {
              _showBottomSheet(context, data);
            },
            child: TaskTile(task: data),
          );
        } else {
          return Container();
        }
      },
    ));
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

  _appBar() {
    return AppBar(
      toolbarHeight: 60.h,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Row(
        children: [
          SizedBox(
            width: 12.w,
          ),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/appicon.png'),
          ),
        ],
      ),
      centerTitle: true,
      title: Text(
        'My Tasks',
        style: GoogleFonts.lato(
          color: _themeController.color,
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            _themeController.switchTheme();
            // await notificationProvider.displayNotification(
            //   title: 'Theme Changed',
            //   body: Get.isDarkMode
            //       ? 'Activated Light Theme'
            //       : 'Activated Dark Theme',
            // );
          },
          icon:
              Icon(Get.isDarkMode ? Icons.mode_night_outlined : Icons.wb_sunny),
          color: _themeController.color,
        ),
      ],
    );
  }

  Widget _addDateBar() => SizedBox(
        child: DatePicker(
          DateTime.now(),
          height: 84.h,
          width: 64.w,
          initialSelectedDate: DateTime.now(),
          selectionColor: primaryColor,
          selectedTextColor: Colors.white,
          dateTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          dayTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          monthTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          onDateChange: _homeController.updateSelectedDate,
        ),
      );

  Widget _addTask() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMd().format(
                  DateTime.now(),
                ),
                style: Themes().subHeadingTextStyle,
              ),
              Text(
                'Today',
                style: Themes().headingTextStyle,
              ),
            ],
          ),
          Button(
            label: '+ Add Task',
            onTap: () async {
              await Get.to(
                () => AddTaskScreen(),
                transition: Transition.rightToLeft,
              );
              _homeController.getTasks();
            },
          ),
        ],
      );
}
