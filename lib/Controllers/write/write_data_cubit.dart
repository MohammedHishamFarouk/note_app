import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:noteapp/Hive_constants.dart';
import 'package:noteapp/model/Notes_Model.dart';

part 'write_data_state.dart';

class WriteDataCubit extends Cubit<WriteDataState> {
  WriteDataCubit() : super(WriteDataInitialstate());

  static WriteDataCubit get(context) => BlocProvider.of(context);
  final _box = Hive.box(HiveConstants.notesBox);

  String noteTitle = '';
  String notesBody = '';
  bool isDark = true;

  void updateNoteTitle(String noteTitle) {
    this.noteTitle = noteTitle;
  }

  void updateNoteBody(String notesBody) {
    this.notesBody = notesBody;
  }

  void updateIsDark(bool isDark) {
    this.isDark = isDark;
    emit(WriteDataloadingstate());
  }

  void addNote() {
    _tryAndCatchBlock(() {
      List<NotesModel> notes = _getWordsFromDataBase();
      notes.add(NotesModel(
          indexAtDataBase: notes.length,
          isDark: isDark,
          noteTitle: noteTitle,
          notesBody: notesBody));
      _box.put(HiveConstants.notesList, notes);
    }, 'we ran into a problem while adding the word');
  }

  void deleteNote(int indexAtDataBase) {
    _tryAndCatchBlock(
      () {
        List<NotesModel> notes = _getWordsFromDataBase();
        notes.removeAt(indexAtDataBase);
        for (int i = indexAtDataBase; i < notes.length; i++) {
          notes[i] = notes[i].decrementIndexAtDataBase();
        }
        _box.put(HiveConstants.notesList, notes);
      },
      'something went wrong while deleting the note',
    );
  }

  void saveNote(NotesModel note, int index){
    List<NotesModel> notes = _getWordsFromDataBase();
    notes.removeAt(index);
    notes.insert(index,note);
    _box.put(HiveConstants.notesList, notes);
      // _box.putAt(index, note);
  }

  List<NotesModel> _getWordsFromDataBase() =>
      List.from(_box.get(HiveConstants.notesList, defaultValue: []))
          .cast<NotesModel>();

  void _tryAndCatchBlock(VoidCallback methodToExcute, String massege) {
    emit(WriteDataloadingstate());
    try {
      methodToExcute.call();
      emit(WriteDataSuccessstate());
    } catch (e) {
      emit(WriteDataFailedstate(massege: massege));
    }
  }
}
