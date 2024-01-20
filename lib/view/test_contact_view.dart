import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class TestContactApp extends StatefulWidget {
  const TestContactApp({super.key});

  @override
  State<TestContactApp> createState() => _TestContactAppState();
}

class _TestContactAppState extends State<TestContactApp> {
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
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
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
                    title: Text(contact.displayName ?? ""),
                    subtitle: Text(phoneNumber),
                    leading: (contact.avatar != null && contact.avatar!.length > 0) ?
                    CircleAvatar(
                      backgroundImage: MemoryImage(contact.avatar!),
                    ) : 
                    CircleAvatar(child: Text(contact.initials()),)
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
