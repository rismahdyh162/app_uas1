import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/note.dart';

class DBHelper {
  static Database? _database;

  // Fungsi untuk mendapatkan instance database
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initDB();
      return _database!;
    }
  }

  // Fungsi untuk inisialisasi database
  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Buat tabel users
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE,
            password TEXT
          )
        ''');

        // Buat tabel notes
        await db.execute('''
          CREATE TABLE notes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT
          )
        ''');
      },
    );
  }

  // ================================
  // Bagian Data Users
  // ================================

  // Fungsi untuk hash password
  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  // Fungsi untuk register user baru
  Future<bool> registerUser(String username, String password) async {
    final db = await database;
    final hashedPassword = hashPassword(password);

    try {
      await db.insert('users', {
        'username': username,
        'password': hashedPassword,
      });
      return true;
    } catch (e) {
      return false; // Gagal register (contoh: username sudah digunakan)
    }
  }

  // Fungsi untuk login user
  Future<bool> loginUser(String username, String password) async {
    final db = await database;
    final hashedPassword = hashPassword(password);

    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, hashedPassword],
    );

    return result.isNotEmpty; // Jika result tidak kosong, login berhasil
  }

  // ================================
  // Bagian Data Notes
  // ================================

  // Fungsi untuk menambah catatan baru
  Future<int> insertNote(Note note) async {
    final db = await database;
    return await db.insert('notes', note.toMap());
  }

  // Fungsi untuk mengambil semua catatan
  Future<List<Note>> getAllNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('notes');

    // Mengonversi hasil query ke dalam bentuk List<Note>
    return List.generate(
      maps.length,
      (i) {
        return Note.fromMap(maps[i]);
      },
    );
  }

  // Fungsi untuk memperbarui catatan
  Future<int> updateNote(Note note) async {
    final db = await database;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  // Fungsi untuk menghapus catatan berdasarkan ID
  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
