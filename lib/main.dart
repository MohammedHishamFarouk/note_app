import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noteapp/Controllers/read/read_data_cubit.dart';
import 'package:noteapp/Controllers/write/write_data_cubit.dart';
import 'package:noteapp/Hive_constants.dart';
import 'package:noteapp/model/Notes_type_adaptor.dart';
import 'package:noteapp/view/screens/Home_Page.dart';
import 'package:noteapp/view/screens/Note_Screen.dart';
import 'package:noteapp/view/styles/Theme_Manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter;
  Hive.registerAdapter(NotesTypeAdaptor());
  await Hive.openBox(HiveConstants.notesBox);
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(create: (context) => ReadDataCubit()..getwords()),
      BlocProvider(create: (context) => WriteDataCubit()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WriteDataCubit, WriteDataState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeManager.getThemeData(WriteDataCubit.get(context).isDark,context),
          initialRoute: '/',
          routes:{
            '/':(context) =>const HomePage(),
            'NoteScreen':(context) =>const NoteScreen(),
          },
        );
      },
    );
  }
}
