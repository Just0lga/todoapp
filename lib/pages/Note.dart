import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/pages/Notes.dart';

class Note extends StatefulWidget {
  Note(
      {super.key,
      required this.id,
      required this.title,
      required this.content});
  int id;
  String title;
  String content;

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  @override
  void initState() {
    setState(() {
      titleController.text = widget.title;
      contentController.text = widget.content;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Notes(),
                    ));
                try {
                  var response = await Dio().put(
                    "http://10.0.2.2:5292/api/notes/${widget.id}",
                    data: {
                      'id': widget.id,
                      'title': titleController.text,
                      'content': contentController.text,
                      'time': "2024-10-15T18:07:34.921Z"
                    },
                  );

                  if (response.statusCode == 200) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Note updated successfully!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Notes())); // Go back to Notes
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Failed to update the note: $e"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              icon: Icon(
                Icons.arrow_back_ios_sharp,
                color: Colors.white,
              )),
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            "My Note",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16),
              TextField(
                controller: titleController,
                cursorColor: Colors.black,
                maxLines: 1,
                maxLength: 10,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: "Title",
                  focusColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: contentController,
                cursorColor: Colors.black,
                minLines: 15,
                maxLines: 20,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: "Content",
                  focusColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Notes(),
                      ));
                  try {
                    var response = await Dio().put(
                      "http://10.0.2.2:5292/api/notes/${widget.id}",
                      data: {
                        'id': widget.id,
                        'title': titleController.text,
                        'content': contentController.text,
                        'time': "2024-10-15T18:07:34.921Z"
                      },
                    );

                    if (response.statusCode == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Note updated successfully!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Notes())); // Go back to Notes
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Failed to update the note: $e"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Container(
                  width: 150,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(4)),
                  child: Text("Update",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
