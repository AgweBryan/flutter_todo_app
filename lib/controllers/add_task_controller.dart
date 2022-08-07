import 'package:flutter_todo_app/models/task.dart';
import 'package:flutter_todo_app/providers/database_provider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskController extends GetxController {
  final Rx<DateTime> _selectedDate = DateTime.now().obs;

  final Rx<String> _selectedStartTime =
      DateFormat('hh:mm a').format(DateTime.now()).obs;

  final Rx<String> _selectedEndTime = '00:00 AM'.obs;

  final Rx<int> _selectedReminder = 5.obs;

  final Rx<String> _selectedRepeat = 'None'.obs;

  final Rx<int> _selectedColorIndex = 0.obs;

  int get selectedColorIndex => _selectedColorIndex.value;

  String get selectedRepeat => _selectedRepeat.value;

  String get selectedStartTime => _selectedStartTime.value;
  String get selectedEndTime => _selectedEndTime.value;
  int get selectedReminder => _selectedReminder.value;

  DateTime get selectedDate => _selectedDate.value;

  updateSelectedDate(DateTime date) {
    _selectedDate.value = date;
  }

  updateSelectedStartTime(String time) {
    _selectedStartTime.value = time;
  }

  updateSelectedEndTime(String time) {
    _selectedEndTime.value = time;
  }

  updateSelectedReminder(int reminder) {
    _selectedReminder.value = reminder;
  }

  updateSelectedRepeat(String repeat) {
    _selectedRepeat.value = repeat;
  }

  updateSelectedColorIndex(int index) {
    _selectedColorIndex.value = index;
  }

  Future<int> addTaskToDB(Task task) async {
    return await DatabaseProvider.insertTask(task);
  }
}
