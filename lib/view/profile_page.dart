import 'package:flutter/material.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Components/profile_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "Name";
  _showCameraModal(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.white,
          child: Center(
            child: Text(
              'Camera Modal Content',
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.primaryColor,
                        ),
                        child: SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Icon(
                              Icons.person,
                              size: 100,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            _showCameraModal(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.secondaryColor,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ProfileField(
                icon: Icon(
                  Icons.person,
                  size: 50,
                  color: AppColors.secondaryColor,
                ),
                input: "Your Name", 
                belowline: "Enter Your Name",
                onUpdateName: (value) {
                  setState(() {
                    name = value; 
                  });
                },
              ),
              ProfileField(
                icon: Icon(
                  Icons.card_travel_sharp,
                  size: 50,
                  color: AppColors.secondaryColor,
                ),
                input: "Buisness Card",
                belowline: "Enter Your Buisness Card",
                onUpdateName: (value) {
                  setState(() {
                    name = value; // Update name
                  });
                },
              ),
              ProfileField(
                icon: Icon(
                  Icons.phone_android,
                  size: 50,
                  color: AppColors.secondaryColor,
                ),
                input: "Phone Number",
                belowline: "Enter Your Phone Number Here",
                onUpdateName: (value) {
                  setState(() {
                    name = value; // Update name
                  });
                },
              ),
              ProfileField(
                icon: Icon(
                  Icons.description_sharp,
                  size: 50,
                  color: AppColors.secondaryColor,
                ),
                input: "GST Number",
                belowline: "Enter Your GST Here",
                onUpdateName: (value) {
                  setState(() {
                    name = value; // Update name
                  });
                },
              ),
              ProfileField(
                icon: Icon(
                  Icons.business,
                  size: 50,
                  color: AppColors.secondaryColor,
                ),
                input: "Buisness Type",
                belowline: "Select Your Buisness Type",
                onUpdateName: (value) {
                  setState(() {
                    name = value; // Update name
                  });
                },
              ),
              ProfileField(
                icon: Icon(
                  Icons.business,
                  size: 50,
                  color: AppColors.secondaryColor,
                ),
                input: "Category",
                belowline: "Select Your Buisness Category",
                onUpdateName: (value) {
                  setState(() {
                    name = value; // Update name
                  });
                },
              ),
              ProfileField(
                icon: Icon(
                  Icons.location_history,
                  size: 50,
                  color: AppColors.secondaryColor,
                ),
                input: "Address",
                belowline: "Select Your Current Location",
                onUpdateName: (value) {
                  setState(() {
                    name = value; // Update name
                  });
                },
              ),
              ProfileField(
                icon: Icon(
                  Icons.info,
                  size: 50,
                  color: AppColors.secondaryColor,
                ),
                input: "Other Info",
                belowline: "Email,Name etc",
                onUpdateName: (value) {
                  setState(() {
                    name = value; // Update name
                  });
                },
              ),

              // Add other ProfileField widgets here
            ],
          ),
        ],
      ),
    );
  }
}
