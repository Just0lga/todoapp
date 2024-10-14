import 'dart:io';
import 'package:dio/dio.dart';
import 'package:todoapp/Models/NoteModel.dart';

class Fetch_Notes {
  final Dio _dio = Dio();

  Future<List<NoteModel>?> getAllNotes() async {
    try {
      final response = await _dio.get("http://10.0.2.2:5292/api/notes");

      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

      if (response.statusCode == HttpStatus.ok && response.data is List) {
        final List<dynamic> data = response.data;
        return data.map((e) => NoteModel.fromJson(e)).toList();
      } else {
        print('Unexpected response format or status code.');
      }
    } catch (e) {
      print("Get Notes Error: $e");
    }
    return null;
  }
}
