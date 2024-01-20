import 'package:flutter/material.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Components/icon_logo.dart';
import 'package:leger_manager/view/master_page/master_page_components/app-bar.dart';
import 'package:leger_manager/view/master_page/master_page_components/bottom_navbar.dart';
import 'package:leger_manager/view/master_page/master_page_pages/customer_page.dart';
import 'package:leger_manager/view/master_page/master_page_components/drawer.dart';
import 'package:leger_manager/view/master_page/master_page_pages/supplier_page.dart';

class MasterPage extends StatefulWidget 
{
  const MasterPage({Key? key}) : super(key: key);

  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() 
  {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: CustomAppBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: [
          CustomerPage(),
          SupplierPage(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (int index) {
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
      ),
    );
  }
}
