part of 'sign_in_bloc.dart';

@immutable
abstract class LoginRegisterEvent {}

class LogInEvent extends LoginRegisterEvent {
  final String email, pass;

  LogInEvent({required this.email, required this.pass});
}

class RegisterEvent extends LoginRegisterEvent {
  final String email, pass, userName;

  RegisterEvent(
      {required this.email, required this.pass, required this.userName});
}

class VisibleObscureTextEvent extends LoginRegisterEvent {}

class FacebookEvent extends LoginRegisterEvent {}

class GetLocationEvent extends LoginRegisterEvent {}

class AcceptConditionEvent extends LoginRegisterEvent {}
