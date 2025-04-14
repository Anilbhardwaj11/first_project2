import 'package:flutter_bloc/flutter_bloc.dart';
import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(const AccountState()) {
    on<NameChanged>(_onNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<MobileNumberChanged>(_onMobileNumberChanged);
    on<CountryCodeChanged>(_onCountryCodeChanged);
    on<LocationChanged>(_onLocationChanged);
    on<PinCodeChanged>(_onPinCodeChanged);
    on<TermsAgreedChanged>(_onTermsAgreedChanged);
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  void _onNameChanged(
    NameChanged event,
    Emitter<AccountState> emit,
  ) {
    final isValid = event.name.trim().isNotEmpty;
    emit(state.copyWith(
      name: event.name,
      isNameValid: isValid,
    ));
  }

  void _onEmailChanged(
    EmailChanged event,
    Emitter<AccountState> emit,
  ) {
    final isValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(event.email);
    emit(state.copyWith(
      email: event.email,
      isEmailValid: isValid,
    ));
  }

  void _onMobileNumberChanged(
    MobileNumberChanged event,
    Emitter<AccountState> emit,
  ) {
    final isValid = RegExp(r'^\d{10}$').hasMatch(event.mobileNumber);
    emit(state.copyWith(
      mobileNumber: event.mobileNumber,
      isMobileNumberValid: isValid,
    ));
  }

  void _onCountryCodeChanged(
    CountryCodeChanged event,
    Emitter<AccountState> emit,
  ) {
    emit(state.copyWith(
      countryCode: event.countryCode,
      flag: event.flag,
    ));
  }

  void _onLocationChanged(
    LocationChanged event,
    Emitter<AccountState> emit,
  ) {
    emit(state.copyWith(
      country: event.country,
      state: event.state,
      city: event.city,
    ));
  }

  void _onPinCodeChanged(
    PinCodeChanged event,
    Emitter<AccountState> emit,
  ) {
    emit(state.copyWith(
      pinCode: event.pinCode,
    ));
  }

  void _onTermsAgreedChanged(
    TermsAgreedChanged event,
    Emitter<AccountState> emit,
  ) {
    emit(state.copyWith(
      termsAgreed: event.agreed,
    ));
  }

  Future<void> _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<AccountState> emit,
  ) async {
    if (!state.isFormValid) {
      emit(state.copyWith(
        errorMessage: 'Please fill all required fields correctly',
      ));
      return;
    }

    emit(state.copyWith(isLoading: true));

    try {
      // Simulate API call for registration
      await Future.delayed(const Duration(seconds: 1));
      
      // If successful
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to create account. Please try again.',
      ));
    }
  }
}