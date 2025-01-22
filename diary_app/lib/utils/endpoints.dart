class ApiEndpoint {
  static const String baseUrl = 'http://192.168.8.124:8000/api';
  static const String storageUrl = 'http://192.168.8.124:8000';
  // static const String baseUrl = '';
  final AuthEndpoints auth = AuthEndpoints();
  final Endpoints api = Endpoints();
}

class AuthEndpoints {
  final String auth = 'auth';
  String get login => '${ApiEndpoint.baseUrl}/$auth/login';
  String get register => '${ApiEndpoint.baseUrl}/$auth/register';
  String get logout => '${ApiEndpoint.baseUrl}/$auth/logout';
}

class Endpoints {
  final String storage = 'storage';
  String get storageUrl => '${ApiEndpoint.storageUrl}/$storage';

  final String prefixCategories = 'categories';
  String get categories => '${ApiEndpoint.baseUrl}/$prefixCategories';

  final String prefixDiaries = 'diaries';
  String get diaries => '${ApiEndpoint.baseUrl}/$prefixDiaries';

  final String prefixUser = 'user';
  String get user => '${ApiEndpoint.baseUrl}/$prefixUser';
}
