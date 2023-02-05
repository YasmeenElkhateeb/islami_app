import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/AladhanResponse.dart';

class ApiManger {
  // http://api.aladhan.com/v1/timingsByCity?city=Dubai&country=United Arab Emirates&method=8

  static const String baseUrl = 'api.aladhan.com';

  static Future<AladhanResponse> getPrayTime(String city,String country) async {
    var url = Uri.http(baseUrl, '/v1/timingsByCity',
        {
          'city': city,
          'country': country,
          // 'method' : 5
        }
    );
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var bodyJson = jsonDecode(bodyString);
      var Aladhan = AladhanResponse.fromJson(bodyJson);
      // print(Aladhan);
      return Aladhan;
    } catch (e) {
      throw e;
    }
  }
}