import 'package:flutter/material.dart';
import 'package:leger_manager/Components/app_colors.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  }) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: widget.onDestinationSelected,
      indicatorColor: AppColors.secondaryColor,
      backgroundColor: AppColors.whiteColor,
      selectedIndex: widget.selectedIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Customer',
        ),
        NavigationDestination(
          icon: Icon(Icons.fire_truck),
          label: 'Supplier',
        ),
      ],
    );
  }
}
