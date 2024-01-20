// import 'package:fast_contacts/fast_contacts.dart';
// import 'package:flutter/material.dart';
// import 'package:leger_manager/Components/app_colors.dart';
// import 'package:permission_handler/permission_handler.dart';

// class ContactPage extends StatefulWidget {
//   const ContactPage({super.key});

//   @override
//   State<ContactPage> createState() => _ContactPageState();
// }

// class _ContactPageState extends State<ContactPage> {
//   List<Contact> contacts = [];
//   TextEditingController Searchcontroller = new TextEditingController();
  
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: Searchcontroller,
//                 decoration: InputDecoration(
//                   hintText: 'Search by name',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                     borderSide: BorderSide(
//                       width: 1.0,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                     borderSide: BorderSide(
//                       color: AppColors.secondaryColor,
//                       width: 2.0,
//                     ),
//                   ),
//                   prefixIcon: Icon(
//                     Icons.search,
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: FutureBuilder(
//                 future: getContacts(),
//                 builder: (context, AsyncSnapshot snapshot) {
//                   if (snapshot.data == null) {
//                     return const Center(
//                       child: SizedBox(
//                           height: 50, child: CircularProgressIndicator()),
//                     );
//                   }
//                   return ListView.builder(
//                       itemCount: snapshot.data.length,
//                       itemBuilder: (context, index) {
//                         Contact contact = snapshot.data[index];
//                         return Column(children: [
//                           ListTile(
//                             leading: const CircleAvatar(
//                               radius: 20,
//                               child: Icon(
//                                 Icons.person,
//                               ),
//                             ),
//                             title: Text(contact.displayName),
//                             subtitle: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 if (contact.phones.isNotEmpty)
//                                   Text(contact.phones[0].number),
//                               ],
//                             ),
//                           ),
//                           const Divider()
//                         ]);
//                       });
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Future<List<Contact>> getContacts() async {
//   bool isGranted = await Permission.contacts.status.isGranted;
//   if (!isGranted) {
//     isGranted = await Permission.contacts.request().isGranted;
//   }
//   if (isGranted) {
//     return await FastContacts.getAllContacts();
//   }
//   return [];
// }
