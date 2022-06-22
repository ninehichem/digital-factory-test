import 'dart:convert';

import 'package:http/http.dart' as http;

dynamic returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body);
      print(responseJson);
      return responseJson;
    case 400:
      return response.body.toString();
    case 401:
    case 403:
      return response.body.toString();
    case 500:
    default:
        print(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
