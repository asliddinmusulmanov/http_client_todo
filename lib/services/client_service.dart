import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http_client_todo/data/products_model.dart';

@immutable
final class ClientService {
  static List<NoteModel> list = [];

  static const ClientService _service = ClientService._internal();

  const ClientService._internal();

  factory ClientService() {
    return _service;
  }

  static const String _baseUrl = "https://65c4be6adae2304e92e33e36.mockapi.io";

  static const String apiProducts = "/user/products";

  static Future<String?> get() async {
    // dart io kutubxonasidagi HttpClient classidan object olinayabdi
    HttpClient httpClient = HttpClient();

    // url yasab olinayabdi
    Uri url = Uri.parse('$_baseUrl/$apiProducts');

    // get methodi orqali so'rov jo'natilayabdi
    HttpClientRequest request = await httpClient.getUrl(url);

    // jo'natilgan so'rov close qilib yopilayabdi
    HttpClientResponse response = await request.close();

    // tekshirilayabdi agar ok bo'lsa response body qaytarilayabdi
    if (response.statusCode == HttpStatus.ok) {
      String responseBody = await response.transform(utf8.decoder).join();

      httpClient.close();

      debugPrint("ResponseBody:  ${responseBody}");

      NoteModel? noteModel;

      list = (jsonDecode(responseBody) as List)
          .map((e) => NoteModel.fromJson(e))
          .toList();

      debugPrint("List : $list");

      return responseBody;

      // throw exception
    } else {
      httpClient.close();
      throw Exception('Failed to load data');
    }
  }

  static Future<String?> post(
      {required String api, required NoteModel data}) async {
    // dart io kutubxonasidagi HttpClient classidan object olinayabdi
    HttpClient httpClient = HttpClient();

    // url yasab olinayabdi
    Uri url = Uri.parse('$_baseUrl/$apiProducts');

    // get methodi orqali so'rov jo'natilayabdi
    HttpClientRequest request = await httpClient.postUrl(url);

    // headers qo'shilayabdi
    request.headers.set('Content-Type', 'application/json');

    //  Map data avval string formatga keyin esa utf8 characterga o'tib requestga qo'shilayabdi
    request.add(utf8.encode(jsonEncode(data)));

    // jo'natilgan so'rov close qilib yopilayabdi
    HttpClientResponse response = await request.close();

    // tekshirilayabdi agar ok bo'lsa response body qaytarilayabdi
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      String responseBody = await response.transform(utf8.decoder).join();

      httpClient.close();

      return responseBody;

      // throw exception
    } else {
      httpClient.close();
      throw Exception('Failed to load data');
    }
  }

  static Future<String?> put(
      {required String id, required NoteModel data}) async {
    // dart io kutubxonasidagi HttpClient classidan object olinayabdi
    HttpClient httpClient = HttpClient();

    // url yasab olinayabdi
    Uri url = Uri.parse('$_baseUrl/$apiProducts/$id');

    // get methodi orqali so'rov jo'natilayabdi
    HttpClientRequest request = await httpClient.putUrl(url);

    // headers qo'shilayabdi
    request.headers.set('Content-Type', 'application/json');

    //  Map data avval string formatga keyin esa utf8 characterga o'tib requestga qo'shilayabdi
    request.add(utf8.encode(jsonEncode(data)));

    // jo'natilgan so'rov close qilib yopilayabdi
    HttpClientResponse response = await request.close();

    // tekshirilayabdi agar ok bo'lsa response body qaytarilayabdi
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      String responseBody = await response.transform(utf8.decoder).join();

      httpClient.close();

      return responseBody;

      // throw exception
    } else {
      httpClient.close();
      throw Exception('Failed to load data');
    }
  }

  static Future<String?> delete({required String id}) async {
    // dart io kutubxonasidagi HttpClient classidan object olinayabdi
    HttpClient httpClient = HttpClient();

    try {
      // url yasab olinayabdi
      Uri url = Uri.parse('$_baseUrl/$apiProducts/$id');

      // delete methodi orqali so'rov jo'natilayabdi
      HttpClientRequest request = await httpClient.deleteUrl(url);

      // jo'natilgan so'rov close qilib yopilayabdi
      HttpClientResponse response = await request.close();

      String responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode == HttpStatus.noContent ||
          response.statusCode == HttpStatus.ok) {
        return responseBody;
      } else {
        throw Exception(
            'Failed to delete resource: ${response.statusCode}, $responseBody');
      }
    } finally {
      httpClient.close();
    }
  }
}
