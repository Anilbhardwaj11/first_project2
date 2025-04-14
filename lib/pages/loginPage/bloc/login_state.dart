import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String phoneNumber;
  final bool isPhoneNumberValid;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  const LoginState({
    this.phoneNumber = '',
    this.isPhoneNumberValid = false,
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  LoginState copyWith({
    String? phoneNumber,
    bool? isPhoneNumberValid,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return LoginState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isPhoneNumberValid: isPhoneNumberValid ?? this.isPhoneNumberValid,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
        phoneNumber,
        isPhoneNumberValid,
        isLoading,
        errorMessage,
        isSuccess,
      ];
}