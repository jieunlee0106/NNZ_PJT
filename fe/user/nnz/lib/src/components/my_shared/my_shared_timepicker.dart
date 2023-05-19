import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/myshared_info_controller.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';

class SharedTimePicker extends StatefulWidget {
  SharedTimePicker({Key? key, required this.title}) : super(key: key);
  var infoFormController = Get.put(MysharedInfoController());
  final String title;

  @override
  State<SharedTimePicker> createState() => _SharedTimePickerState();
}

class _SharedTimePickerState extends State<SharedTimePicker> {
  DateTime dateTimeSelected = DateTime.now();

  void _openTimePickerSheet(BuildContext context) async {
    var infoFormController = Get.put(MysharedInfoController());
    final result = await TimePicker.show<DateTime?>(
      context: context,
      sheet: TimePickerSheet(
        sheetTitle: "나눔 시간 선택",
        minuteTitle: 'Minute',
        hourTitle: 'Hour',
        saveButtonText: 'Save',
      ),
    );

    if (result != null) {
      setState(() {
        dateTimeSelected = result;
        final insertTime = dateTimeSelected.toString().substring(11, 16);
        infoFormController.openTimeController.text = insertTime;
        print(insertTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            _openTimePickerSheet(context);
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Config.blackColor),
                borderRadius: BorderRadius.circular(5)),
            height: 35,
            width: double.infinity,
            child: Center(
              child: Text(
                '${dateTimeSelected.hour}    :    ${dateTimeSelected.minute}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 17, color: Color.fromARGB(255, 73, 71, 71)),
              ),
            ),
          ),
        )
      ],
    );
  }
}
