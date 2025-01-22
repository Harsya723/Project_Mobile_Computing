import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService extends GetxService {
  final http.Client client = http.Client();

  // Function to make a GET request with headers
  Future<http.Response> get(String url, {Map<String, String>? headers}) async {
    // Adding interceptor logic for headers
    var finalHeaders = await _getHeaders(headers);

    // Making the GET request with the final headers
    var response = await client.get(Uri.parse(url), headers: finalHeaders);

    // Handling the response (e.g., checking status code)
    _handleResponse(response);

    return response;
  }

  // Function to make a POST request with headers and a body
  Future<http.Response> post(String url,
      {Map<String, String>? headers, Object? body}) async {
    var finalHeaders = await _getHeaders(headers);

    // Making the POST request with the final headers and body
    var response =
        await client.post(Uri.parse(url), headers: finalHeaders, body: body);

    _handleResponse(response);

    return response;
  }

  // Multipar POST request
  Future<http.Response> postMultipart(String url,
      {Map<String, String>? headers, Object? body}) async {
    var finalHeaders = await _getHeaders(headers);

    // Membuat request multipart
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(finalHeaders);

    // Menambahkan fields biasa (non-file)
    if (body != null) {
      // Body yang bukan file
      Map<String, dynamic> fields = Map<String, dynamic>.from(body as Map);
      fields.forEach((key, value) {
        print('key: $key, value: $value');
        request.fields[key] = value;
      });
    }

    // Menambahkan file jika ada
    if (body != null && (body as Map<String, dynamic>)['attachment'] != null) {
      var imageFile = await http.MultipartFile.fromPath(
        'attachment', // Nama field untuk file gambar
        body['attachment'], // Path file gambar
        contentType: MediaType('image', 'jpeg'), // Ubah sesuai tipe file gambar
      );
      request.files.add(imageFile);
    }

    // Mengirimkan request
    var response = await request.send();
    var responseString = await response.stream.bytesToString();

    _handleResponse(http.Response(responseString, response.statusCode));

    return http.Response(responseString, response.statusCode);
  }

  // Function to make a PUT request with headers and a body
  Future<http.Response> put(String url,
      {Map<String, String>? headers, Object? body}) async {
    var finalHeaders = await _getHeaders(headers);

    // Making the PUT request with the final headers and body
    var response =
        await client.put(Uri.parse(url), headers: finalHeaders, body: body);

    _handleResponse(response);

    return response;
  }

  // Function to make a DELETE request with headers
  Future<http.Response> delete(String url,
      {Map<String, String>? headers}) async {
    var finalHeaders = await _getHeaders(headers);

    // Making the DELETE request with the final headers
    var response = await client.delete(Uri.parse(url), headers: finalHeaders);

    _handleResponse(response);

    return response;
  }

  // Function to generate headers, including token if available
  Future<Map<String, String>> _getHeaders(Map<String, String>? headers) async {
    Map<String, String> defaultHeaders = {
      'Content-Type': 'application/json', // Default content type for API
      'Accept': 'application/json', // Accepts JSON responses
    };

    // Merging custom headers (if any) with default headers
    if (headers != null) {
      defaultHeaders.addAll(headers);
    }

    // Get the token from SharedPreferences
    String? token = await _getToken(); // Fetch token from SharedPreferences
    if (token != null && token.isNotEmpty) {
      // If token exists, add it to the Authorization header
      defaultHeaders['Authorization'] = 'Bearer $token';
      // defaultHeaders['Authorization'] = 'Bearer 12|ZbXzOGbuGu9kNvNz4LA8CIsp5xs4VhmcFOUPUwsR199e5c49';
    }

    return defaultHeaders;
  }

  // Function to retrieve the token from SharedPreferences
  Future<String?> _getToken() async {
    final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    final getPrefs = await prefs;
    return getPrefs
        .getString('token'); // Retrieve the token using the key 'token'
  }

  // Function to handle errors or status codes in the response
  void _handleResponse(http.Response response) {
    if (response.statusCode == 401) {
      // If the status code is 401, it indicates that the token might be expired or invalid
      print('Unauthorized - Token might be expired');
    } else if (response.statusCode >= 400) {
      // Handle other client or server errors (400 and above)
      print('Error: ${response.statusCode}');
    }
  }
}
