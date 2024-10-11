import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/Controllers/write/write_data_cubit.dart';
import 'package:noteapp/view/Widgets/note_getter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Note App'),
          actions:[ BlocBuilder<WriteDataCubit, WriteDataState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () => _themeChanger(context),
                icon: Icon(WriteDataCubit.get(context).isDark
                    ? Icons.sunny
                    : Icons.nights_stay),
              );
            },
          ),
            const SizedBox(width: 10,)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          WriteDataCubit.get(context).notesBody != ''? WriteDataCubit.get(context).notesBody = '':null;
          WriteDataCubit.get(context).noteTitle != ''? WriteDataCubit.get(context).noteTitle = '':null;
          Navigator.of(context).pushNamed('NoteScreen');
        },
        child: const Icon(Icons.add,color: Colors.black,),
      ),
      body:const Column(
        children: [
          Expanded(child: NoteGetter()
          )
        ],
      ),
    );
  }

  void _themeChanger(BuildContext context) => WriteDataCubit.get(context).isDark
      ? WriteDataCubit.get(context).updateIsDark(false)
      : WriteDataCubit.get(context).updateIsDark(true);
}
