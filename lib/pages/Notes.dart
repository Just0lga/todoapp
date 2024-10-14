import 'package:flutter/material.dart';
import 'package:todoapp/Models/NoteModel.dart';
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
      // Handle error case (e.g., show a message or retry)
      setState(() {
        foundNotes = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Notes"),
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

                    return ListTile(
                      title: Text(note.title),
                      subtitle: Text(note.content),
                      trailing: Text(note.time.toLocal().toString()),
                    );
                  },
                ),
    );
  }
}
