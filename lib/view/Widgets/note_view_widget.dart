import 'package:flutter/material.dart';
import 'package:noteapp/Controllers/read/read_data_cubit.dart';
import 'package:noteapp/Controllers/write/write_data_cubit.dart';
import 'package:noteapp/model/Notes_Model.dart';
import 'package:noteapp/view/screens/note_edit_screen.dart';

class NoteViewWidget extends StatelessWidget{
  const NoteViewWidget({super.key,required this.notes});

  final NotesModel notes;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: ()=>_onUpdate(context,notes),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(12)
          ),
          child: ListTile(
            title: Text(notes.noteTitle == '' ? notes.notesBody:notes.noteTitle,
              maxLines: 1,
            ),
            subtitle: Text(notes.noteTitle == ''?'':notes.notesBody,
              maxLines: 2,
            ),
            trailing: IconButton(
                onPressed: ()=>_deleteNote(context),
                icon:const Icon(Icons.delete, size: 30,)),
          ),
        ),
      ),
    );
  }
  void _deleteNote(BuildContext context){
    WriteDataCubit.get(context).deleteNote(notes.indexAtDataBase);
    ReadDataCubit.get(context).getwords();
  }
  void _onUpdate(BuildContext context,NotesModel notes){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return NoteEditScreen(notes:notes);
      },
     ),
    );
  }
}