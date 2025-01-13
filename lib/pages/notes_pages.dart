import 'package:app_uas1/database/db_helper.dart';
import 'package:app_uas1/models/note.dart';
import 'package:app_uas1/pages/profil.dart';
import 'package:flutter/material.dart';
import 'add_note_page.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final DBHelper dbHelper = DBHelper();
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  // Fungsi untuk mengambil data catatan dari database
  void loadNotes() async {
    List<Note> loadNotes = await dbHelper.getAllNotes();
    setState(() {
      notes = loadNotes;
    });
  }

  // Fungsi untuk menghapus catatan
  void deleteNote(int id) async {
    await dbHelper.deleteNote(id);
    loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text(
          'SafeMemo',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Profil(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(notes[index].id.toString()), // Key unik untuk setiap item
            direction:
                DismissDirection.endToStart, // Geser ke kiri untuk menghapus
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              // Hapus note dari database
              deleteNote(notes[index].id!);

              // Tampilkan pesan konfirmasi
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Catatan "${notes[index].title}" dihapus'),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 15.0, vertical: 8.0), // Margin antar catatan
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0), // Sudut melengkung
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.grey.withOpacity(0.3), //warna bayangan
                    spreadRadius: 1, // ukuran bayangan
                    blurRadius: 5, // efek Blur bayangan
                    offset: const Offset(0, 2), // posisi bayangan
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  notes[index].title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(notes[index].content),
                onTap: () {
                  // Navigasi halaman edit jika catatan ditekan
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddNotePage(note: notes[index]),
                    ),
                  ).then((_) {
                    loadNotes(); // Memuat ulang catatan setelah mengedit
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNotePage()),
          ).then((_) {
            loadNotes(); // Memuat ulang catatan setelah menambah
          });
        },
        child: const Icon(Icons.add, color: Colors.blue),
      ),
    );
  }
}
