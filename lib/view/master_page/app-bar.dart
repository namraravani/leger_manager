import 'package:flutter/material.dart';
import 'package:leger_manager/Components/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: (){
          Scaffold.of(context).openDrawer();
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(Icons.person, color: AppColors.secondaryColor),
          ),
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Container(
              height: 55,
              width: 55,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search by name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: AppColors.secondaryColor,
                      width: 2.0,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor,
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
