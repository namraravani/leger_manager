import 'package:flutter/material.dart';
import 'package:leger_manager/Components/app_colors.dart';

class ListComponent extends StatelessWidget {
  final String company;
  final String category;
  final String product;
  final String quantity;
  final String totalprice;
  final VoidCallback onDeletePressed; // Callback function for delete action

  const ListComponent({
    Key? key,
    required this.company,
    required this.category,
    required this.product,
    required this.quantity,
    required this.totalprice,
    required this.onDeletePressed, // Accepting callback function
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: AppColors.secondaryColor,
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                company,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                category,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              Text(
                product,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.currency_rupee_sharp,
                        size: 20,
                      ),
                      Text(
                        totalprice,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        quantity,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w200),
                      ),
                      Text(
                        "x",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w200),
                      ),
                      Icon(
                        Icons.currency_rupee_sharp,
                        size: 15,
                        opticalSize: 100,
                      ),
                      Text(
                        "10",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w200),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 35.0, bottom: 25),
                child: Container(
                  height: 10,
                  width: 10,
                  child: IconButton(
                    onPressed:
                        onDeletePressed, // Invoke callback function when pressed
                    icon: Icon(
                      Icons.delete,
                      color: AppColors.redColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
