import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Controller/customer_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactViewPage extends StatefulWidget {
  const ContactViewPage({super.key});

  @override
  State<ContactViewPage> createState() => _ContactViewPageState();
}

class _ContactViewPageState extends State<ContactViewPage> {
  CustomerController customercontroller = Get.find<CustomerController>();
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  TextEditingController searchController = TextEditingController();
  bool contactsLoaded = false;

  @override
  void initState() {
    super.initState();
    getPermissions();
  }

  getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      getAllContacts();
      searchController.addListener(() {
        filterContacts();
      });
    }
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  getAllContacts() async {
    List<Contact> _contacts =
        (await ContactsService.getContacts(withThumbnails: false)).toList();
    setState(() {
      contacts = _contacts;
      contactsLoaded = true;
    });
  }

  filterContacts() {
    List<Contact> _contacts = List.from(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String contactName = contact.displayName?.toLowerCase() ?? "";

        return contactName.contains(searchTerm);
      });
    }
    setState(() {
      contactsFiltered = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  controller: searchController,
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
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount:
                    isSearching ? contactsFiltered.length : contacts.length,
                itemBuilder: (context, index) {
                  Contact contact =
                      isSearching ? contactsFiltered[index] : contacts[index];

                  String phoneNumber = contact.phones?.isNotEmpty == true
                      ? contact.phones!.elementAt(0).value ?? "No phone number"
                      : "No phone number";

                  return ListTile(
                    onTap: () {
                      printContactData(contact);
                      customercontroller.postCustomerFromContact(
                          contact.displayName ?? "No name",
                          phoneNumber);
                    },
                    title: Text(contact.displayName ?? ""),
                    subtitle: Text(phoneNumber),
                    leading:
                        (contact.avatar != null && contact.avatar!.length > 0)
                            ? CircleAvatar(
                                backgroundImage: MemoryImage(contact.avatar!),
                              )
                            : CircleAvatar(
                                child: Text(contact.initials()),
                              ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void printContactData(Contact contact) {
    print("Contact Name: ${contact.displayName ?? "No name"}");

    if (contact.phones?.isNotEmpty == true) {
      print(
          "Phone Number: ${contact.phones!.elementAt(0).value ?? "No phone number"}");
    } else {
      print("No phone number");
    }
  }
}
