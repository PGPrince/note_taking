import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  // CREATE - a note and save in supabase

  final textController = TextEditingController();

  void addNewNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          decoration: InputDecoration(hintText: 'Enter your note'),
        ),
        actions: [
          //Save Button
          TextButton(
            onPressed: () {
              saveNote();
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void saveNote() async {
    await Supabase.instance.client.from('notes').insert({
      'body': textController.text,
    });
  }

  // Read notes from supabase in app

  final _notesStream = Supabase.instance.client
      .from('notes')
      .stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addNewNote,
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _notesStream,
        builder: (context, snapshot) {
          //loading
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          //loaded
          final notes = snapshot.data!;

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              //get individual note
              final note = notes[index];

              // get the column you want
              final noteText = note['body'];

              //return as UI
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(noteText, style: const TextStyle(fontSize: 16)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
