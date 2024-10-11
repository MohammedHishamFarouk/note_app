import 'package:flutter/material.dart';
import 'package:noteapp/Controllers/write/write_data_cubit.dart';

class CustomTitleForm extends StatefulWidget{
  const CustomTitleForm({super.key,required this.titleFormKey});

  final GlobalKey<FormState>titleFormKey;

  @override
  State<CustomTitleForm> createState() => _CustomTitleFormState();
}

class _CustomTitleFormState extends State<CustomTitleForm> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.titleFormKey,
      child: TextFormField(
      controller: _textEditingController,
      style: _textFieldTextStyle(context, 24),
      cursorColor: Colors.grey,
      decoration:const InputDecoration(
        hintText: 'Enter Title',
        focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
      onChanged: (value)=>WriteDataCubit.get(context).updateNoteTitle(value),
      validator: (value){
        if(value == null || value.trim().length == 0){
          return'this Title should not be empty';
        }
      },
    ),);
  }
}
class CustomBodyForm extends StatefulWidget{
  const CustomBodyForm({super.key,required this.formKey});
  final GlobalKey<FormState>formKey;

  @override
  State<CustomBodyForm> createState() => _CustomBodyFormState();
}

class _CustomBodyFormState extends State<CustomBodyForm> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
      controller: _textEditingController,
      maxLines: null,
      decoration: const InputDecoration(border: InputBorder.none),
      style: _textFieldTextStyle(context, 19),
      cursorColor: Colors.grey,
      cursorHeight: 24,
      onChanged: (value)=>WriteDataCubit.get(context).updateNoteBody(value),
      validator:(value){
        if(value == null || value.trim().length == 0){
          return'this body should not be empty';
        }
      }
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