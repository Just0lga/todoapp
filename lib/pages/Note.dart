import 'package:flutter/material.dart';
import 'package:todoapp/Models/NoteModel2.dart';
import 'package:todoapp/pages/Notes.dart';
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
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Notes()));
              },
              icon: Icon(
                Icons.arrow_back_ios_sharp,
                color: Colors.white,
              )),
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            foundNote?.title ?? "Title",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(
                foundNote?.content ?? "Content",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Container(
            width: 150,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(4)),
            child: Text("Edit",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
          )
        ],
      ),
    );
  }
}
