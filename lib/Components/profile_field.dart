import 'package:flutter/material.dart';
import 'package:leger_manager/Components/app_colors.dart';

class ProfileField extends StatelessWidget {
  final Icon icon;
  final String input;
  final String belowline;
  const ProfileField({
    super.key,
    required this.icon,
    required this.input,
    required this.belowline,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 200,
              child: Center(
                child: Text('Modal Content'),
              ),
            );
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 15.0),
                child: icon,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(input),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Text(
              belowline,
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
    );
  }
}
