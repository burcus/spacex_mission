import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer';

import 'package:space_api/models/api_response.dart';

class SpaceXRepo {

  static Future<ApiResponse?> fetchLatest() async {
    try {
      final response = await http.get(
          Uri.parse("https://api.spacexdata.com/v4/launches/latest"));

      if (response.statusCode == 200) {
        String result = response.body;
        log(result);
        return ApiResponse.fromJson(jsonDecode(result));
      } else {
        return null;
      }
    } catch (Exception) {
      log(Exception.toString());
      return null;
    }
  }
}
