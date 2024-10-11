import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/Controllers/read/read_data_cubit.dart';
import 'package:noteapp/Controllers/write/write_data_cubit.dart';
import 'package:noteapp/view/Widgets/custom_form.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
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
                    if (_formKey.currentState!.validate() ||
                        _titleFormKey.currentState!.validate()) {
                      WriteDataCubit.get(context).addNote();
                      ReadDataCubit.get(context).getwords();
                    } else {
                      Navigator.of(context).pop();
                    }
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
                return CustomTitleForm(titleFormKey: _titleFormKey);
              },
            ),
            Expanded(
              child: BlocBuilder<WriteDataCubit, WriteDataState>(
                builder: (context, state) {
                  return CustomBodyForm(formKey: _formKey);
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