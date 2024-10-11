import 'package:flutter/material.dart';
import 'package:noteapp/Controllers/write/write_data_cubit.dart';
import 'package:noteapp/model/Notes_Model.dart';

class CustomTitleEditForm extends StatefulWidget{
  const CustomTitleEditForm({super.key,required this.titleFormKey, required this.notes});

  final GlobalKey<FormState>titleFormKey;
  final NotesModel notes;
  static late String title;
  @override
  State<CustomTitleEditForm> createState() => _CustomTitleFormState();
}

class _CustomTitleFormState extends State<CustomTitleEditForm> {
  late TextEditingController _titleTextEditingController = TextEditingController();

  @override
  void initState(){
    super.initState();
    _titleTextEditingController = TextEditingController(
      text: widget.notes.noteTitle ??''
    );
    CustomTitleEditForm.title = _titleTextEditingController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.titleFormKey,
      child: TextFormField(
        controller: _titleTextEditingController,
        style: _textFieldTextStyle(context, 24),
        cursorColor: Colors.grey,
        decoration:const InputDecoration(
          hintText: 'Enter Title',
          focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        ),
        onChanged: (value){CustomTitleEditForm.title = value;},
      ),
    );
  }
}
class CustomBodyEditForm extends StatefulWidget{
  const CustomBodyEditForm({super.key,required this.formKey, required this.notes});

  final GlobalKey<FormState>formKey;
  final NotesModel notes;
  static late String body;

  @override
  State<CustomBodyEditForm> createState() => _CustomBodyFormState();
}

class _CustomBodyFormState extends State<CustomBodyEditForm> {
  late TextEditingController _bodyTextEditingController = TextEditingController();

  @override
  void initState(){
    super.initState();
    _bodyTextEditingController = TextEditingController(
      text: widget.notes.notesBody??''
    );
    CustomBodyEditForm.body = _bodyTextEditingController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
          controller: _bodyTextEditingController,
          maxLines: null,
          decoration: const InputDecoration(border: InputBorder.none),
          style: _textFieldTextStyle(context, 19),
          cursorColor: Colors.grey,
          cursorHeight: 24,
          onChanged: (value){
            CustomBodyEditForm.body = value;},
      ),
    );
  }
}
TextStyle _textFieldTextStyle(BuildContext context,double fontsize){
  return TextStyle(
      color: WriteDataCubit.get(context).isDark
          ? Colors.white
          : Colors.black,
      fontSize: fontsize
  );
}