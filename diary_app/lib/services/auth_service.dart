import 'dart:convert';
import 'package:diary_app/services/api_service.dart';
import 'package:diary_app/utils/endpoints.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final ApiService apiService = ApiService();
  final ApiEndpoint apiEndpoint = ApiEndpoint();
  final Endpoints api = ApiEndpoint().api;

  Future<Map<String, dynamic>> login(String username, String password) async {
    try{
        var response = await apiService.post(
          apiEndpoint.auth.login,
          body: json.encode({'username': username, 'password': password}),
        );

        if (response.statusCode == 200) {
          return {
            'statusCode': response.statusCode,
            'data': json.decode(response.body)['data']
          };
        } else {
          return {
            'statusCode': response.statusCode,
            'data': json.decode(response.body)['message']
          };
        }
    } catch (e) {
        return {
          'statusCode': 500,
          'data': e.toString()
        };
    }
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> body) async {
    try{
        var response = await apiService.post(
          apiEndpoint.auth.register,
          body: json.encode(body),
        );

        print(response.body);

        if (response.statusCode == 201) {
          return {
            'statusCode': response.statusCode,
            'data': json.decode(response.body)['data']
          };
        } else if(response.statusCode == 422) {
          return {
            'statusCode': response.statusCode,
            'data': json.decode(response.body)['data']
          };
        } else {
          return {
            'statusCode': response.statusCode,
            'data': json.decode(response.body)['message']
          };
        }
    } catch (e) {
        return {
          'statusCode': 500,
          'data': e.toString()
        };
    }
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> body) async {
    try{
        var response = await apiService.put(
          '${api.user}/profile',
          body: json.encode(body),
        );

        print(response.body);

        if (response.statusCode == 200) {
          return {
            'statusCode': response.statusCode,
            'data': json.decode(response.body)['data']
          };
        } else if(response.statusCode == 422) {
          return {
            'statusCode': response.statusCode,
            'data': json.decode(response.body)['data']
          };
        } else {
          return {
            'statusCode': response.statusCode,
            'data': json.decode(response.body)['message']
          };
        }
    } catch (e) {
        return {
          'statusCode': 500,
          'data': e.toString()
        };
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try{
        var response = await apiService.post(
          apiEndpoint.auth.logout,
        );

        if (response.statusCode == 200) {
          return {
            'statusCode': response.statusCode,
            'data': json.decode(response.body)['message']
          };
        } else {
          return {
            'statusCode': response.statusCode,
            'data': json.decode(response.body)['message']
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
