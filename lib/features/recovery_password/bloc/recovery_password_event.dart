part of 'recovery_password_bloc.dart';

@immutable
abstract class RecoveryPasswordEvent {}

class InputValidateEvent extends RecoveryPasswordEvent {
  final String email;

  InputValidateEvent({required this.email});
}
