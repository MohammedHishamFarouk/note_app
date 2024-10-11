import 'package:hive/hive.dart';
import 'package:noteapp/model/Notes_Model.dart';

class NotesTypeAdaptor extends TypeAdapter<NotesModel> {
  @override
  read(BinaryReader reader) {
    return NotesModel(
        indexAtDataBase: reader.readInt(),
        isDark: reader.readBool(),
        noteTitle: reader.readString(),
        notesBody: reader.readString());
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, NotesModel obj) {
    writer.writeInt(obj.indexAtDataBase);
    writer.writeBool(obj.isDark);
    writer.writeString(obj.noteTitle);
    writer.writeString(obj.notesBody);
  }
}
