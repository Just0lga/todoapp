import 'dart:io';
import 'package:dio/dio.dart';
import 'package:todoapp/Models/NoteModel2.dart';

class Fetch_Note {
  final Dio _dio = Dio();

  Future<NoteModel2?> getNoteById(int id) async {
    try {
      final response = await _dio.get("http://10.0.2.2:5292/api/notes/$id");

      if (response.statusCode == HttpStatus.ok) {
        NoteModel2 data = NoteModel2.fromJson(response.data);
        print(data.title);
        return data;
      } else {
        print('Unexpected response format or status code.');
      }
    } catch (e) {
      print("Get Notes Error: $e");
    }
    return null;
  }
}
