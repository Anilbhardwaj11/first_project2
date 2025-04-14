import 'package:equatable/equatable.dart';

class AccountState extends Equatable {
  final String name;
  final bool isNameValid;
  
  final String email;
  final bool isEmailValid;
  
  final String mobileNumber;
  final bool isMobileNumberValid;
  
  final String countryCode;
  final String flag;
  
  final String? country;
  final String? state;
  final String? city;
  
  final String pinCode;
  
  final bool termsAgreed;
  
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;
  
  const AccountState({
    this.name = '',
    this.isNameValid = false,
    this.email = '',
    this.isEmailValid = false,
    this.mobileNumber = '',
    this.isMobileNumberValid = false,
    this.countryCode = "+91",
    this.flag = "🇮🇳",
    this.country,
    this.state,
    this.city,
    this.pinCode = '',
    this.termsAgreed = false,
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  bool get isFormValid => 
      isNameValid && 
      isEmailValid && 
      isMobileNumberValid && 
      country != null && 
      state != null && 
      city != null && 
      termsAgreed;

  AccountState copyWith({
    String? name,
    bool? isNameValid,
    String? email,
    bool? isEmailValid,
    String? mobileNumber,
    bool? isMobileNumberValid,
    String? countryCode,
    String? flag,
    String? country,
    String? state,
    String? city,
    String? pinCode,
    bool? termsAgreed,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return AccountState(
      name: name ?? this.name,
      isNameValid: isNameValid ?? this.isNameValid,
      email: email ?? this.email,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      isMobileNumberValid: isMobileNumberValid ?? this.isMobileNumberValid,
      countryCode: countryCode ?? this.countryCode,
      flag: flag ?? this.flag,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      pinCode: pinCode ?? this.pinCode,
      termsAgreed: termsAgreed ?? this.termsAgreed,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
    name,
    isNameValid,
    email,
    isEmailValid,
    mobileNumber,
    isMobileNumberValid,
    countryCode,
    flag,
    country,
    state,
    city,
    pinCode,
    termsAgreed,
    isLoading,
    errorMessage,
    isSuccess,
  ];
}