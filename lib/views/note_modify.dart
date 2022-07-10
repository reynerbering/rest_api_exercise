import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_it/get_it.dart';

import '../models/note.dart';
import '../models/note_insert.dart';
import '../services/notes_service.dart';

class NoteModify extends StatefulWidget {
  final String? noteID;
  NoteModify({this.noteID});

  @override
  State<NoteModify> createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.noteID != null;

  NotesService get notesService => GetIt.I<NotesService>();

  String? errorMessage;
  late Note note;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      setState(() {
        _isLoading = true;
      });

      notesService.getNote(widget.noteID!).then((response) {
        setState(() {
          _isLoading = false;
        });
        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occurred.';
        }
        note = response.data!;
        _titleController.text = note.noteTitle!;
        _contentController.text = note.noteContent!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(isEditing ? 'Edit note' : 'Create note')),
        body: Padding(
          padding: EdgeInsets.all(12.0),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(hintText: 'Note Title'),
                    ),
                    Container(height: 8),
                    TextField(
                      controller: _contentController,
                      decoration: InputDecoration(hintText: 'Note Content'),
                    ),
                    Container(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 35,
                      child: MaterialButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () async {
                          if (isEditing) {
                            // update note
                          } else {
                            setState(() {
                              _isLoading = true;
                            });
                            final note = NoteInsert(
                              noteTitle: _titleController.text,
                              noteContent: _contentController.text,
                            );
                            final result = await notesService.createNote(note);

                            setState(() {
                              _isLoading = false;
                            });

                            final title = 'Done';
                            final text = result.error
                                ? (result.errorMessage ?? "An error occurred")
                                : 'Your note was created';

                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      title: Text(title),
                                      content: Text(text),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Ok'))
                                      ],
                                    )).then((data) {
                              if (result.data!) {
                                Navigator.of(context).pop();
                              }
                            });
                          }
                        },
                        child: const Text('Submit',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
        ));
  }
}
