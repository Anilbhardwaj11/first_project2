import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<SendOtpPressed>(_onSendOtpPressed);
    on<LoginWithSocialMedia>(_onLoginWithSocialMedia);
  }

  void _onPhoneNumberChanged(
    PhoneNumberChanged event,
    Emitter<LoginState> emit,
  ) {
    final isValid = event.phoneNumber.length > 9;
    emit(state.copyWith(
      phoneNumber: event.phoneNumber,
      isPhoneNumberValid: isValid,
    ));
  }

  Future<void> _onSendOtpPressed(
    SendOtpPressed event,
    Emitter<LoginState> emit,
  ) async {
    if (!state.isPhoneNumberValid) {
      emit(state.copyWith(
        errorMessage: 'Please enter a valid phone number',
      ));
      return;
    }

    emit(state.copyWith(isLoading: true));

    try {
      await Future.delayed(const Duration(seconds: 1));
      
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to send OTP. Please try again.',
      ));
    }
  }

  Future<void> _onLoginWithSocialMedia(
    LoginWithSocialMedia event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      await Future.delayed(const Duration(seconds: 1));
      
      print('Logging in with ${event.provider}');
      
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to login with ${event.provider}',
      ));
    }
  }
}