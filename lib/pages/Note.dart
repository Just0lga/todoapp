import 'package:flutter/material.dart';
import 'package:todoapp/Models/NoteModel2.dart';
import 'package:todoapp/services/GetNote.dart';

class Note extends StatefulWidget {
  Note({super.key, required this.id});
  int id;

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  final Fetch_Note _fetchService = Fetch_Note();
  NoteModel2? foundNote;

  @override
  void initState() {
    fetchNoteById();
    super.initState();
  }

  void fetchNoteById() async {
    final note = await _fetchService.getNoteById(widget.id);
    setState(() {
      foundNote = note;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(foundNote?.title ?? "x")),
      body: Column(
        children: [
          Container(
            color: Colors.red,
            width: 400,
            height: 500,
            child: Text(foundNote?.content ?? "x"),
          )
        ],
      ),
    );
  }
}
