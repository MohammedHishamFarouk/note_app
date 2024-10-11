part of 'read_data_cubit.dart';

@immutable
sealed class ReadDataState {}

final class ReadDataInitialState extends ReadDataState {}

final class ReadDataloadingState extends ReadDataState {}

final class ReadDataSuccessState extends ReadDataState {
  final List<NotesModel>notes;
  ReadDataSuccessState({required this.notes});
}

final class ReadDataFaildeState extends ReadDataState {
  final String massege;
  ReadDataFaildeState({required this.massege});
}
