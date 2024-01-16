import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Repository {
  Future<List<Map<String, String>>> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://asia-northeast1-wc2022-bot.cloudfunctions.net/brands'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Map<String, String>> formattedData = data
            .cast<Map<String, dynamic>>()
            .map<Map<String, String>>((item) => {
                  'name': item['name'],
                  'logo': item['logo'],
                })
            .toList();
        return formattedData;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}

class RepositoryApple {
  Future<List<Map<String, String>>> fetchData() async {
    try {
      final responseApple = await http.get(Uri.parse(
          'https://asia-northeast1-wc2022-bot.cloudfunctions.net/products?brand=apple'));

      if (responseApple.statusCode == 200) {
        final List<dynamic> data1 = jsonDecode(responseApple.body);
        if (data1.isEmpty) {
          throw Exception('โครงสร้างข้อมูลไม่คาดคิด');
        }

        final List<Map<String, String>> formattedData = data1
            .cast<Map<String, dynamic>>()
            .map<Map<String, String>>((item) => {
                  'id': item['id'].toString(),
                  'name': item['name'] ?? '',
                  'image': item['image'] ?? '',
                  'brand': item['brand'] ?? '',
                  'price': item['price'].toString(),
                })
            .toList();
        return formattedData;
      } else {
        throw Exception('การดึงข้อมูลล้มเหลว: ${responseApple.statusCode}');
      }
    } on http.ClientException catch (error) {
      throw Exception('ข้อผิดพลาด HTTP Client: $error');
    } on FormatException catch (error) {
      throw Exception('ข้อผิดพลาดการถอดรหัส: $error');
    } on Exception catch (error) {
      throw Exception('ข้อผิดพลาด: $error');
    }
  }
}

class RepositorySamsung {
  Future<List<Map<String, String>>> fetchData() async {
    try {
      final responseSamsung = await http.get(Uri.parse(
          'https://asia-northeast1-wc2022-bot.cloudfunctions.net/products?brand=samsung'));

      if (responseSamsung.statusCode == 200) {
        final List<dynamic> data2 = jsonDecode(responseSamsung.body);

        // จัดการข้อมูลที่ไม่คาดคิดหรือค่า null อย่างสุภาพ
        if (data2.isEmpty) {
          throw Exception('โครงสร้างข้อมูลไม่คาดคิด');
        }

        final List<Map<String, String>> formattedData = data2
            .cast<Map<String, dynamic>>()
            .map<Map<String, String>>((item) => {
                  'id': item['id'].toString(),
                  'name': item['name'] ?? '',
                  'image': item['image'] ?? '',
                  'brand': item['brand'] ?? '',
                  'price': item['price'].toString(),
                })
            .toList();
        return formattedData;
      } else {
        throw Exception('การดึงข้อมูลล้มเหลว: ${responseSamsung.statusCode}');
      }
    } on http.ClientException catch (error) {
      throw Exception('ข้อผิดพลาด HTTP Client: $error');
    } on FormatException catch (error) {
      throw Exception('ข้อผิดพลาดการถอดรหัส: $error');
    } on Exception catch (error) {
      throw Exception('ข้อผิดพลาด: $error');
    }
  }
}
