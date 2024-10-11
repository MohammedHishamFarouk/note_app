import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:noteapp/Hive_constants.dart';
import 'package:noteapp/model/Notes_Model.dart';

part 'read_data_state.dart';

class ReadDataCubit extends Cubit<ReadDataState> {
  ReadDataCubit() : super(ReadDataInitialState());
  static ReadDataCubit get(context)=>BlocProvider.of(context);

  final Box _box = Hive.box(HiveConstants.notesBox);

 void getwords(){
   emit(ReadDataloadingState());
   try{
     List<NotesModel>notesToReturn = List.from(_box.get(HiveConstants.notesList,defaultValue: [])).cast<NotesModel>();
     emit(ReadDataSuccessState(notes: notesToReturn));
   }catch(e){
     emit(ReadDataFaildeState(massege: 'we ran in an error in the get method'));
   }
 }
}
