import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Models/NoteModel.dart';
import 'package:todoapp/pages/Note.dart';
import 'package:todoapp/services/GetNotes.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final Fetch_Notes _fetchService = Fetch_Notes();
  List<NoteModel>? foundNotes;

  @override
  void initState() {
    fetchAllNotes();
    super.initState();
  }

  void fetchAllNotes() async {
    final notes = await _fetchService.getAllNotes();
    if (notes != null) {
      setState(() {
        foundNotes = notes;
      });
    } else {
      setState(() {
        foundNotes = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "My Notes",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: foundNotes == null
          ? Center(child: CircularProgressIndicator())
          : foundNotes!.isEmpty
              ? Center(child: Text("No notes available"))
              : ListView.builder(
                  itemCount: foundNotes!.length,
                  itemBuilder: (context, index) {
                    final note = foundNotes![index];

                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Note(id: note.id),
                              ));
                        },
                        child: ListTile(
                            title: Text(
                              note.title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              note.content,
                              maxLines: 2,
                              style: TextStyle(color: Colors.black),
                            ),
                            trailing: IconButton(
                              onPressed: () async {
                                try {
                                  print(note?.id);
                                  var response = await Dio().delete(
                                      "http://localhost:5292/api/notes/${note.id}");
                                  if (response.statusCode == 200) {
                                    print("Item deleted successfully");
                                  }
                                } catch (e) {
                                  print("Failed to delete the item: $e");
                                }
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.black,
                              ),
                            )));
                  },
                ),
    );
  }
}
