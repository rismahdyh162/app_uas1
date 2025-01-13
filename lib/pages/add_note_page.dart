import 'package:flutter/material.dart';
import 'package:app_uas1/database/db_helper.dart';
import 'package:app_uas1/models/note.dart';

class AddNotePage extends StatefulWidget {
  final Note? note;
  const AddNotePage({super.key, this.note});

  @override
  // ignore: library_private_types_in_public_api
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final DBHelper dbHelper = DBHelper();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;
    }
  }

  // Fungsi untuk menyimpan atau mengupdate catatan
  void saveNote() async {
    // Validasi untuk memastikan bahwa title dan content tidak kosong
    if (titleController.text.isEmpty || contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title and Content cannot be empty!')),
      );
      return;
    }

    if (widget.note == null) {
      // Membuat objek Note baru
      Note newNote = Note(
        title: titleController.text,
        content: contentController.text,
      );
      await dbHelper.insertNote(newNote);
    } else {
      // Memperbarui note yang ada jika widget.note sudah ada
      widget.note!.title = titleController.text;
      widget.note!.content = contentController.text;
      await dbHelper.updateNote(widget.note!);
    }
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(widget.note == null ? 'Add Note' : 'Edit Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveNote,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
