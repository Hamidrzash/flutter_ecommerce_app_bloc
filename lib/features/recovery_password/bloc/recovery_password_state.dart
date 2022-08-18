part of 'recovery_password_bloc.dart';

@immutable
abstract class RecoveryPasswordState {}

class RecoveryPasswordInitial extends RecoveryPasswordState {}

class InputValidateState extends RecoveryPasswordState {}
