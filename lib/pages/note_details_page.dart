import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteDetailsPage extends StatelessWidget {
  final DocumentSnapshot note;
  final TextEditingController controller;

  NoteDetailsPage(this.note) : controller = TextEditingController(text: note['content']);

  Future<void> _saveNote() async {
    await note.reference.update({'content': controller.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveNote();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controller,
          maxLines: null,
          decoration: InputDecoration.collapsed(hintText: 'Enter your note'),
        ),
      ),
    );
  }
}
