import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http; // Import the http package

class CustomerProfilePageController extends GetxController {
  // Initialize the http client
  final http.Client httpClient = http.Client();

  Future<int> getCustomerID(String yourStringData) async {
    print(yourStringData);
    String apiUrl =
        'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/fetchcustomerid';

    try {
      final response = await httpClient.post(
        // Use httpClient instead of http
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "contactinfo": yourStringData,
        }),
      );

      if (response.statusCode == 200) {
        print("all is Oka nddjnadkv djfdafjfasjknask");
        final Map<String, dynamic> responseData = json.decode(response.body);

        int customer_id = responseData['customerId'];

        return customer_id;
      } else {
        throw Exception(
            'Failed to get customer id. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<void> MoveCustomer(String contactinfo) async {
    // Define the endpoint URL where you want to send the POST request
    final String url =
        'https://1kv5glweui.execute-api.ap-south-1.amazonaws.com/development/update_type';

    // Create a map containing the data to be sent in the request body
    int postid = await getCustomerID(contactinfo);
    print(postid);
    final Map<String, dynamic> data = {
      'customer_id': postid,
      'type': 0,
    };

    try {
      // Send the POST request
      final response = await httpClient.put(
        // Use httpClient instead of http
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Handle the response here if needed
        print(
            'request successful Customer Updated Succesfully !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      } else {
        // Handle any errors or unexpected status codes here
        print('Error: ${response.reasonPhrase}');
      }
    } catch (error) {
      // Handle any errors that occur during the request
      print('Error: $error');
    }
  }
}
