import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/Controllers/read/read_data_cubit.dart';
import 'package:noteapp/model/Notes_Model.dart';
import 'package:noteapp/view/Widgets/loading_widget.dart';
import 'package:noteapp/view/Widgets/note_view_widget.dart';

class NoteGetter extends StatelessWidget {
  const NoteGetter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataState>(
      builder: (context, state) {
        if(state is ReadDataSuccessState){
          if(state.notes.isEmpty){
            return _getEmptyNotesWidget();
          }
          return _getNotesWidget(state.notes);
        }else if(state is ReadDataFaildeState){
          return _getFailedWidget(state.massege);
        }else{
          return _getLoadingWidget();
        }
      },
    );
  }

  Widget _getNotesWidget(List<NotesModel>notes){
    return ListView.builder(itemCount: notes.length,
      itemBuilder: ((context,index){
        return NoteViewWidget(notes: notes[index]);
      }),
    );
  }

  Widget _getEmptyNotesWidget(){
    return const Center(child: Text('No Notes Found'),);
  }

  Widget _getFailedWidget(String massege){
    return  Center(child: Text(massege,textAlign: TextAlign.center,),);
  }

  Widget _getLoadingWidget(){
    return const LoadingWidget();
  }
}


