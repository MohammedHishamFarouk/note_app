part of 'write_data_cubit.dart';

@immutable
sealed class WriteDataState {}

final class WriteDataInitialstate extends WriteDataState {}

final class WriteDataloadingstate extends WriteDataState {}

final class WriteDataSuccessstate extends WriteDataState {}

final class WriteDataFailedstate extends WriteDataState {
  final String massege;
  WriteDataFailedstate({required this.massege});
}

