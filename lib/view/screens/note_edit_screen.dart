import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/Controllers/read/read_data_cubit.dart';
import 'package:noteapp/Controllers/write/write_data_cubit.dart';
import 'package:noteapp/model/Notes_Model.dart';
import 'package:noteapp/view/Widgets/custom_edit_form.dart';

class NoteEditScreen extends StatefulWidget {
  const NoteEditScreen({super.key, required this.notes});
  final NotesModel notes;

  @override
  State<NoteEditScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteEditScreen> {
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  final GlobalKey<FormState>_titleFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<WriteDataCubit, WriteDataState>(
      listener: (context, state) {
        if(state is WriteDataSuccessstate){
          Navigator.of(context).pop();
        }else if(state is WriteDataFailedstate){
          ScaffoldMessenger.of(context).showSnackBar(_getSnackBar(state.massege));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: () {
                    Navigator.of(context).pop();
                  },
                    child: const Text('cancel'),
                  ),
                  TextButton(onPressed: () {
                      final NotesModel newNote = NotesModel(
                        notesBody: CustomBodyEditForm.body,
                        noteTitle: CustomTitleEditForm.title,
                        isDark: widget.notes.isDark,
                        indexAtDataBase: widget.notes.indexAtDataBase
                      );
                      WriteDataCubit.get(context).saveNote(newNote, widget.notes.indexAtDataBase);
                      ReadDataCubit.get(context).getwords();
                      Navigator.of(context).pop();
                  },
                    child: const Text('save'),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            BlocBuilder<WriteDataCubit, WriteDataState>(
              builder: (context, state) {
                return CustomTitleEditForm(titleFormKey: _titleFormKey, notes:widget.notes,);
              },
            ),
            Expanded(
              child: BlocBuilder<WriteDataCubit, WriteDataState>(
                builder: (context, state) {
                  return CustomBodyEditForm(formKey: _formKey, notes: widget.notes,);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

SnackBar _getSnackBar(String massege)=>SnackBar(content:Text(massege),backgroundColor: Colors.red,);