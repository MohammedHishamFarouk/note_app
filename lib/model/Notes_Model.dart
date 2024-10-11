class NotesModel {
  final int indexAtDataBase;
  final bool isDark;
   String noteTitle;
   String notesBody;

   NotesModel(
      {required this.indexAtDataBase,
      required this.isDark,
      required this.noteTitle,
      required this.notesBody});

  NotesModel decrementIndexAtDataBase() {
    return NotesModel(
        indexAtDataBase: indexAtDataBase-1,
        isDark: isDark,
        noteTitle: noteTitle,
        notesBody: notesBody);
  }
}
