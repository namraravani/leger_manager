import 'package:flutter/material.dart';
import 'package:leger_manager/Components/app_colors.dart';

class ProfileField extends StatefulWidget {
  final Icon icon;
  final String input;
  final String belowline;
  final void Function(String) onUpdateName;
  const ProfileField({
    Key? key,
    required this.icon,
    required this.input,
    required this.belowline,
    required this.onUpdateName,
  }) : super(key: key);

  @override
  _ProfileFieldState createState() => _ProfileFieldState();
}

class _ProfileFieldState extends State<ProfileField> {
  String fieldValue = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Edit ${widget.input}"),
              content: Form(
                key: _formKey,
                child: TextFormField(
                  initialValue: fieldValue,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter ${widget.input}';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      fieldValue = value;
                      widget.onUpdateName(value);
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Enter ${widget.input}",
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Only proceed if the form is valid
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Edit"),
                ),
              ],
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: widget.icon,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.input),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 70),
              child: Text(
                fieldValue.isEmpty ? widget.belowline : fieldValue,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
