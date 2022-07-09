import 'package:flutter/material.dart';

class NoteModify extends StatelessWidget {
  final String? noteID;
  bool get isEditing => noteID != null;

  NoteModify({this.noteID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit note' : 'Create note')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(hintText: 'Note title'),
            ),
            Container(
              height: 8,
            ),
            const TextField(
              decoration: InputDecoration(hintText: 'Note content'),
            ),
            Container(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              height: 35,
              child: ElevatedButton(
                onPressed: () {
                  if (isEditing) {
                    //update note in api
                  } else {
                    //create note in api
                  }
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    textStyle: const TextStyle(color: Colors.white)),
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
