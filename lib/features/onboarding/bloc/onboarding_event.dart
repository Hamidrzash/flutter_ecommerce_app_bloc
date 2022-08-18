part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingEvent {}

class SlideChangedEvent extends OnboardingEvent {
  int index;

  SlideChangedEvent({required this.index});
}
