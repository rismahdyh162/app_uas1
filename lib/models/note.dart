class Note {
  int? id;
  String title;
  String content;

  Note({this.id, required this.title, required this.content});

  // Fungsi untuk mengubah objek Note menjadi Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }

  // Fungsi untuk mengubah Map menjadi objek Note
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
    );
  }
}
