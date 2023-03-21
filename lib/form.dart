import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FormStudent extends StatefulWidget {
  const FormStudent({super.key});

  @override
  State<FormStudent> createState() => _FormStudentState();
}

class _FormStudentState extends State<FormStudent> {
  final _formKey = GlobalKey<FormState>();
  late String _id;
  late DateTime dob;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Id'),
              validator: (value) {
                if (value == null && value!.isEmpty) {
                  return 'Please Input Id';
                }
                return null;
              },
              onSaved: (value) {
                _id = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Full name'),
              validator: (value) {
                if (value == null && value!.isEmpty) {
                  return 'Please Input Full Name';
                }
              },
            ),
            // CalendarDatePicker(
            //   initialDate: DateTime.utc(2000, 1, 1),
            //   firstDate: DateTime.utc(1990, 1, 1),
            //   lastDate: DateTime.utc(2010, 1, 1),
            //   onDateChanged: (value) {
            //     dob = value;
            //   },
            // )
            // DatePickerDialog(
            //     initialDate: DateTime.utc(2000, 1, 1),
            //     firstDate: DateTime.utc(1990, 1, 1),
            //     lastDate: DateTime.utc(2010, 1, 1)),
            Row(
              children: [
                Text('Date of Birth'),
                IconButton(
                  onPressed: () async {
                    var d = await showDatePicker(
                        context: context,
                        initialDate: DateTime.utc(2000, 1, 1),
                        firstDate: DateTime.utc(1990, 1, 1),
                        lastDate: DateTime.utc(2010, 1, 1));
                    dob = d!;
                    print('$dob');
                  },
                  icon: Icon(Icons.calendar_month_outlined),
                ),
              ],
            )
          ],
        ));
  }
}
