import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginWithSocialMedia extends LoginEvent {
  final String provider;

  const LoginWithSocialMedia(this.provider);

  @override
  List<Object?> get props => [provider];
}

class PhoneNumberChanged extends LoginEvent {
  final String phoneNumber;

  const PhoneNumberChanged(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class SendOtpPressed extends LoginEvent {
  final String phoneNumber;

  const SendOtpPressed(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}
