import 'dart:convert';
import 'package:diary_app/services/api_service.dart';
import 'package:diary_app/utils/endpoints.dart';
import 'package:get/get.dart';

class DiaryService extends GetxService {
  final ApiService apiService = ApiService();
  final String baseUrl = ApiEndpoint().api.diaries;

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
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> selectCategory() async {
    try{
      var response = await apiService.get(ApiEndpoint().api.categories);
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
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> create(Map<String, dynamic> body) async {
    try {
      var response = await apiService.postMultipart(
        baseUrl,
        body: body,
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
      print(e.toString());
      throw Exception(e.toString());
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
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> update(
      String id, Map<String, dynamic> body) async {
    try{
      var response = body['attachment'] != null ? await apiService.postMultipart(
        '$baseUrl/$id',
        body: body,
      ) : await apiService.post('$baseUrl/$id', body: json.encode(body));

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
      throw Exception(e.toString());
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
      print(e.toString());
      throw Exception(e.toString());
    }
  }
}
