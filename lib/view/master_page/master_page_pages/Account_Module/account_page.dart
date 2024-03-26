import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Controller/account_controller.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final AccountController accountcontroller = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Text(
              accountcontroller.totalamt.value,
              style: TextStyle(color: AppColors.greenColor),
            ),
          ),
          Obx(
            () => Text(
              accountcontroller.totaladvanceamt.value,
              style: TextStyle(color: AppColors.greenColor),
            ),
          ),
          Obx(
            () => _buildRangeDatePicker(accountcontroller),
          ),
          _buildLockButton(accountcontroller),
        ],
      ),
    );
  }
}

Widget _buildRangeDatePicker(AccountController controller) {
  final config = CalendarDatePicker2Config(
    selectedDayHighlightColor: Colors.amber[900],
    weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
    weekdayLabelTextStyle: const TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
    ),
    firstDayOfWeek: 1,
    controlsHeight: 50,
    controlsTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
    dayTextStyle: const TextStyle(
      color: Colors.amber,
      fontWeight: FontWeight.bold,
    ),
    disabledDayTextStyle: const TextStyle(
      color: Colors.grey,
    ),
    selectableDayPredicate: (day) {
      if (controller.isRangeLocked.value) {
        return false; 
      }
      return !day.isAfter(DateTime.now()); // Disable dates after today
    },
  );

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const SizedBox(height: 10),
      const Text('Range Date Picker'),
      CalendarDatePicker2(
        config: config.copyWith(
          calendarType: CalendarDatePicker2Type.range,
        ),
        
        value: controller.rangeDatePickerValue.toList(),
        onValueChanged: (dates) {
          controller.rangeDatePickerValue.assignAll(dates);
        },
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 10),
          Obx(() => Text(
                _getValueText(
                  config.calendarType,
                  controller.rangeDatePickerValue,
                ),
              )),
        ],
      ),
      const SizedBox(height: 25),
    ],
  );
}

Widget _buildLockButton(AccountController controller) {
  return ElevatedButton(
    onPressed: () {
      controller.lockRange();
    },
    child: const Text('Lock Range'),
  );
}

String _getValueText(
  CalendarDatePicker2Type datePickerType,
  List<DateTime?> values,
) {
  values = values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
  var valueText = values.toString().replaceAll('00:00:00.000', '');

  return valueText;
}
