import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leger_manager/Classes/allcustomer.dart';
import 'package:leger_manager/Classes/customer.dart';
import 'package:leger_manager/Components/app_colors.dart';
import 'package:leger_manager/Controller/customer_controller.dart';
import 'package:leger_manager/Controller/transcation_controller.dart';
import 'package:leger_manager/view/master_page/master_page_pages/Transcation_module/transaction_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  CustomerController customercontroller = Get.find<CustomerController>();
  TranscationController transcationcontroller =
      Get.put(TranscationController());
  List<AllCustomer> customers = [];
  List<AllCustomer> customersFiltered = [];
  TextEditingController searchController = TextEditingController();
  bool customersLoaded = false;
  bool onTapExecuted = false;

  @override
  void initState() {
    super.initState();
    getAllContacts();
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  getAllContacts() async {
    List<AllCustomer> _customers = await customercontroller.fetchCustomers();

    setState(() {
      customers = _customers;
      customersLoaded = true;
    });
  }

  filterContacts() {
    List<AllCustomer> _customers = List.from(customers);
    if (searchController.text.isNotEmpty) {
      _customers.retainWhere((customer) {
        String searchTerm = searchController.text.toLowerCase();
        String customerName = customer.name.toLowerCase();

        return customerName.contains(searchTerm);
      });
    }
    setState(() {
      customersFiltered = _customers;
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
                  onChanged: (value) {
                    filterContacts();
                  },
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
                    isSearching ? customersFiltered.length : customers.length,
                itemBuilder: (context, index) {
                  AllCustomer customer =
                      isSearching ? customersFiltered[index] : customers[index];

                  String phoneNumber = customer.contactInfo;

                  return ListTile(
                      onTap: () async {
                        if (!onTapExecuted) {
                          onTapExecuted = true;

                          int shop_id = await transcationcontroller
                              .getShopId("9427662325");

                          int cust_id = await transcationcontroller
                              .getCustomerID(phoneNumber);

                          transcationcontroller.maintainRelation(
                              shop_id, cust_id);

                          transcationcontroller.getAlltranscation(
                              shop_id, cust_id);
                          Get.to(TransactionPage(
                            customerName: customercontroller
                                .customerlist[index].customerName,
                            contactinfo: customercontroller
                                .customerlist[index].contactInfo,
                          ));

                          // transcationcontroller.postTranscation(
                          //     shop_id.toString(), cust_id.toString(), 0, "0");

                          Get.off(TransactionPage(
                              customerName: customer.name ?? "No name",
                              contactinfo: phoneNumber));
                        }
                      },
                      title: Text(customer.name ?? ""),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(phoneNumber),
                          Text(
                            customer.type == 0 ? "Supplier" : "Customer",
                          ),
                        ],
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
