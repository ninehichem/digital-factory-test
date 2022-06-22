import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../../core/httperror.dart';

class RequestService {
  requestRandomEvent() async {
    try {
      var responseJson;
      http.Response response;

      response = await http.get(Uri.parse(randomeventurl), headers: {
        "Accept": "application/json; charset=utf-8",
      });

      //return jsonDecode(response.body);
      return returnResponse(response);
    } catch (e) {
      print(e);
      return e;
      // ignore: dead_code_catch_following_catch
    } on SocketException {
      print('No Internet connection');
    }
  }

  requestEventbyType(String type) async {
    try {
      var responseJson;
      http.Response response;
      response = await http.get(Uri.parse(randomevenType + type), headers: {
        "Accept": "application/json; charset=utf-8",
      });

      //return jsonDecode(response.body);
      return returnResponse(response);
    } catch (e) {
      print(e);
      return e;
      // ignore: dead_code_catch_following_catch
    } on SocketException {
      print('No Internet connection');
    }
  }

  requestEventbyPrice(num type) async {
    try {
      var responseJson;
      http.Response response;
      response = await http
          .get(Uri.parse(randomeventprice + type.toString()), headers: {
        "Accept": "application/json; charset=utf-8",
      });
      print(response.body);
       var k = json.decode(response.body);
      return jsonDecode(response.body);

    } catch (e) {
      print("e == $e");
      return e;
      // ignore: dead_code_catch_following_catch
    } on SocketException {
      print('No Internet connection');
    }
  }
}
