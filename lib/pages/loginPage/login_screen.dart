import 'package:first_project/Utils/dynamic_size.dart';
import 'package:first_project/pages/loginPage/bloc/login_bloc.dart';
import 'package:first_project/pages/loginPage/bloc/login_event.dart';
import 'package:first_project/pages/loginPage/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _phoneNumber;

  @override
  Widget build(BuildContext context) {
    final sizes = AppSizes(context);

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
        
        if (state.isSuccess) {
          context.push('/login'); // Navigate to OTP screen
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: sizes.sizedBoxWidth(0.05)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: sizes.sizedBoxHeight(0.025)),
                    Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: sizes.fontSize(0.075),
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 71, 69, 69),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(sizes.sizedBoxWidth(0.05)),
                      child: Image.asset(
                        "assets/images/undraw_secure-login_m11a.png",
                        fit: BoxFit.cover,
                        height: sizes.containerHeight(0.25),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: sizes.sizedBoxHeight(0.015)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Continue with",
                            style: TextStyle(
                              fontSize: sizes.fontSize(0.065),
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 71, 69, 69),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Social Media Buttons
                    _buildSocialButton(
                      context,
                      'Google',
                      FontAwesomeIcons.google,
                      sizes,
                    ),
                    SizedBox(height: sizes.sizedBoxHeight(0.015)),

                    _buildSocialButton(
                      context,
                      'Facebook',
                      FontAwesomeIcons.facebook,
                      sizes,
                    ),
                    SizedBox(height: sizes.sizedBoxHeight(0.015)),

                    _buildSocialButton(
                      context,
                      'Twitter',
                      FontAwesomeIcons.twitter,
                      sizes,
                    ),
                    SizedBox(height: sizes.sizedBoxHeight(0.03)),

                    Text(
                      "━━━━ Or ━━━━",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(height: sizes.sizedBoxHeight(0.015)),

                    Text(
                      "Enter your mobile number",
                      style: TextStyle(
                        fontSize: sizes.fontSize(0.04),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: sizes.sizedBoxHeight(0.015)),

                    // Phone Number Form
                    Form(
                      key: _formKey,
                      child: IntlPhoneField(
                        decoration: InputDecoration(
                          labelText: "Mobile number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(sizes.sizedBoxWidth(0.025)),
                          ),
                        ),
                        initialCountryCode: "IN",
                        onChanged: (phone) {
                          _phoneNumber = phone.completeNumber;
                          context.read<LoginBloc>().add(
                                PhoneNumberChanged(phone.completeNumber),
                              );
                        },
                        validator: (phone) {
                          if (phone == null || phone.number.isEmpty) {
                            return 'Please enter a valid mobile number';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: sizes.sizedBoxHeight(0.025)),

                    // Continue Button
                    ElevatedButton(
                      onPressed: state.isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<LoginBloc>().add(
                                      SendOtpPressed(_phoneNumber!),
                                    );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 81, 79, 79),
                        minimumSize: Size(double.infinity, sizes.containerHeight(0.065)),
                      ),
                      child: state.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Continue",
                              style: TextStyle(color: Colors.white, fontSize: sizes.fontSize(0.045)),
                            ),
                    ),
                    SizedBox(height: sizes.sizedBoxHeight(0.025)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSocialButton(
    BuildContext context,
    String provider,
    IconData icon,
    AppSizes sizes,
  ) {
    return ElevatedButton.icon(
      onPressed: () {
        context.read<LoginBloc>().add(LoginWithSocialMedia(provider));
      },
      icon: Icon(
        icon,
        size: sizes.iconSize(0.07),
        color: const Color.fromARGB(255, 74, 142, 197),
      ),
      label: Text(
        provider,
        style: TextStyle(
          fontSize: sizes.fontSize(0.06),
          color: const Color.fromARGB(255, 74, 142, 197),
        ),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(sizes.containerWidth(0.9), sizes.containerHeight(0.065)),
        backgroundColor: const Color.fromARGB(255, 212, 210, 210),
      ),
    );
  }
}