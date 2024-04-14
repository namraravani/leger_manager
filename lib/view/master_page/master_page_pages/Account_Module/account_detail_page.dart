import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Controller/account_controller.dart';

class AccountDetailPage extends StatelessWidget {
  const AccountDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    AccountController accountcontroller = Get.find<AccountController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Detail Page"),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            width: 400,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                border: Border.all(
                  color: AppColors.secondaryColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.book,
                      size: 30,
                    ),
                    Text(
                      "Net Balance",
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_circle_right_outlined),
                  ],
                ),
                Row(
                  children: [
                    Text("Customer Khata"),
                    Spacer(),
                    Text(
                      "${accountcontroller.totaladvanceamt}",
                      style: TextStyle(color: AppColors.greenColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.person),
                    Text("Customers"),
                    Spacer(),
                    Text("You Give"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: 100,
            width: 400,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                border: Border.all(
                  color: AppColors.secondaryColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.book,
                      size: 30,
                    ),
                    Text(
                      "Net Balance",
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_circle_right_outlined),
                  ],
                ),
                Row(
                  children: [
                    Text("Customer Khata"),
                    Spacer(),
                    Text(
                      "${accountcontroller.totalamt}",
                      style: TextStyle(color: AppColors.greenColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.person),
                    Text("Customers"),
                    Spacer(),
                    Text("You Give"),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              child: _buildRangeDatePicker(accountcontroller),
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

