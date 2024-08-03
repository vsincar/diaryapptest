import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final List<String> _notes = []; // List to store notes
  final TextEditingController _noteController = TextEditingController();
  int? _editingIndex; // Track which note is being edited

  void _addNote() {
    final note = _noteController.text;
    if (note.isNotEmpty) {
      setState(() {
        if (_editingIndex != null) {
          _notes[_editingIndex!] = note;
          _editingIndex = null;
        } else {
          _notes.add(note);
        }
        _noteController.clear();
      });
      Navigator.of(context).pop(); // Close the dialog
    }
  }

  void _showAddNoteDialog({String? existingNote, int? index}) {
    _noteController.text = existingNote ?? '';
    _editingIndex = index;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(existingNote == null ? 'Yeni Not Ekle' : 'Notu Düzenle'),
          content: TextField(
            controller: _noteController,
            decoration: const InputDecoration(
              hintText: 'Notunuzu buraya yazın...',
            ),
            maxLines: 5,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Kaydet'),
              onPressed: _addNote,
            ),
          ],
        );
      },
    );
  }

  void _editNote(int index) {
    _showAddNoteDialog(existingNote: _notes[index], index: index);
  }

  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notlar'),
      ),
      body: _notes.isEmpty
          ? const Center(child: Text('Henüz not yok.'))
          : ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(_notes[index]),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _deleteNote(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Not silindi')),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5, // Shadow for the card
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        _notes[index],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () => _editNote(index), // Edit note on tap
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNoteDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
