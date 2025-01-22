import 'dart:convert';
import 'package:diary_app/services/api_service.dart';
import 'package:diary_app/utils/endpoints.dart';
import 'package:get/get.dart';

class CategoryService extends GetxService {
  final ApiService apiService = ApiService();
  final String baseUrl = ApiEndpoint().api.categories;

  Future<Map<String, dynamic>> fetch() async {
    try{
      var response = await apiService.get(baseUrl);
      print(response.body);
      if (response.statusCode == 200) {
        return {
          'statusCode': response.statusCode,
          'data': json.decode(response.body)['data'],
        };
      } else {
        return {
          'statusCode': response.statusCode,
          'data': json.decode(response.body)['message'],
        };
      }
    } catch (e) {
      return {
        'statusCode': 500,
        'data': e.toString()
      };
    }
  }

  Future<Map<String, dynamic>> create(Map<String, dynamic> body) async {
    try {
      var response = await apiService.post(
        baseUrl,
        body: json.encode(body),
      );

      print(response.body);

      if (response.statusCode == 201) {
        return {
          'statusCode': response.statusCode,
          'data': json.decode(response.body)['data'],
        };
      } else {
        return {
          'statusCode': response.statusCode,
          'data': json.decode(response.body)['message'],
        };
      }
    } catch (e) {
      return {
        'statusCode': 500,
        'data': e.toString()
      };
    }
  }

  Future<Map<String, dynamic>> show(String id) async {
    try{
      var response = await apiService.get('$baseUrl/$id');
      if (response.statusCode == 200) {
        return {
          'statusCode': response.statusCode,
          'data': json.decode(response.body)['data'],
        };
      } else {
        return {
          'statusCode': response.statusCode,
          'data': json.decode(response.body)['message'],
        };
      }
    } catch (e) {
      return {
        'statusCode': 500,
        'data': e.toString()
      };
    }
  }

  Future<Map<String, dynamic>> update(
      String id, Map<String, dynamic> body) async {
    try{
      var response = await apiService.put(
        '$baseUrl/$id',
        body: json.encode(body),
      );

      print(response.body);

      if (response.statusCode == 200) {
        return {
          'statusCode': response.statusCode,
          'data': json.decode(response.body)['data'],
        };
      } else {
        return {
          'statusCode': response.statusCode,
          'data': json.decode(response.body)['message'],
        };
      }
    } catch (e) {
      return {
        'statusCode': 500,
        'data': e.toString()
      };
    }
  }

  Future<Map<String, dynamic>> delete(String id) async {
    try{
      var response = await apiService.delete('$baseUrl/$id');
      print(response.body);
      if (response.statusCode == 200) {
        return {
          'statusCode': response.statusCode,
          'data': json.decode(response.body)['data'],
        };
      } else {
        return {
          'statusCode': response.statusCode,
          'data': json.decode(response.body)['message'],
        };
      }
    } catch (e) {
      return {
        'statusCode': 500,
        'data': e.toString()
      };
    }
  }
}
