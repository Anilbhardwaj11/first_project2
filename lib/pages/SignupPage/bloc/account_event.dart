import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

class NameChanged extends AccountEvent {
  final String name;

  const NameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class EmailChanged extends AccountEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class MobileNumberChanged extends AccountEvent {
  final String mobileNumber;

  const MobileNumberChanged(this.mobileNumber);

  @override
  List<Object?> get props => [mobileNumber];
}

class CountryCodeChanged extends AccountEvent {
  final String countryCode;
  final String flag;

  const CountryCodeChanged(this.countryCode, this.flag);

  @override
  List<Object?> get props => [countryCode, flag];
}

class LocationChanged extends AccountEvent {
  final String? country;
  final String? state;
  final String? city;

  const LocationChanged({this.country, this.state, this.city});

  @override
  List<Object?> get props => [country, state, city];
}

class PinCodeChanged extends AccountEvent {
  final String pinCode;

  const PinCodeChanged(this.pinCode);

  @override
  List<Object?> get props => [pinCode];
}

class TermsAgreedChanged extends AccountEvent {
  final bool agreed;

  const TermsAgreedChanged(this.agreed);

  @override
  List<Object?> get props => [agreed];
}

class SignUpSubmitted extends AccountEvent {
  const SignUpSubmitted();
}