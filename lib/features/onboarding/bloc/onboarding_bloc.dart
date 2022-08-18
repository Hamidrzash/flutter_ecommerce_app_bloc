import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'onboarding_event.dart';

part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  int slideIndex = 1;

  OnboardingBloc() : super(OnboardingInitial()) {
    on<SlideChangedEvent>((event, emit) {
      slideIndex = event.index;
      emit(SlideChangeState());
    });
  }
}
