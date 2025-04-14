import 'package:country_picker/country_picker.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:first_project/pages/SignupPage/bloc/account_bloc.dart';
import 'package:first_project/pages/SignupPage/bloc/account_event.dart';
import 'package:first_project/pages/SignupPage/bloc/account_state.dart';
import 'package:first_project/pages/loginPage/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountBloc(),
      child: const AccountView(),
    );
  }
}

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    pinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
        
        if (state.isSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Create an account",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text("Welcome! Please enter your details"),
                        const SizedBox(height: 20),
                        const Text("Student Name",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        buildNameTextField(context),
                        const Text("Email",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        buildEmailTextField(context),
                        const Text("Mobile Number",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        buildMobileNumberFields(context, state),
                        const SizedBox(height: 10),
                        const Text("Country",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 13),
                        buildLocationPicker(context),
                        buildPinCodeTextField(context),
                        const SizedBox(height: 10),
                        buildTermsCheckbox(context, state),
                        const SizedBox(height: 15),
                        buildSignUpButton(context, state),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildNameTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: nameController,
        onChanged: (value) {
          context.read<AccountBloc>().add(NameChanged(value));
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your name';
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          hintText: "Student Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        ),
      ),
    );
  }

  Widget buildEmailTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: emailController,
        onChanged: (value) {
          context.read<AccountBloc>().add(EmailChanged(value));
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
              .hasMatch(value)) {
            return 'Enter a valid email address';
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          hintText: "Enter your email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        ),
      ),
    );
  }

  Widget buildMobileNumberFields(BuildContext context, AccountState state) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () {
              showCountryPicker(
                context: context,
                onSelect: (Country country) {
                  context.read<AccountBloc>().add(
                        CountryCodeChanged(
                          "+${country.phoneCode}",
                          country.flagEmoji,
                        ),
                      );
                },
              );
            },
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey),
                color: Colors.grey[200],
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.flag, style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 5),
                  Text(state.countryCode, style: const TextStyle(fontSize: 16)),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 5,
          child: TextFormField(
            controller: mobileController,
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              context.read<AccountBloc>().add(MobileNumberChanged(value));
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your mobile number';
              } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                return 'Enter a valid 10-digit number';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Mobile Number",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLocationPicker(BuildContext context) {
    return SelectState(
      onCountryChanged: (value) {
        context.read<AccountBloc>().add(
              LocationChanged(country: value),
            );
      },
      onStateChanged: (value) {
        context.read<AccountBloc>().add(
              LocationChanged(state: value),
            );
      },
      onCityChanged: (value) {
        context.read<AccountBloc>().add(
              LocationChanged(city: value),
            );
      },
    );
  }

  Widget buildPinCodeTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: pinCodeController,
        onChanged: (value) {
          context.read<AccountBloc>().add(PinCodeChanged(value));
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.pin),
          hintText: "Pin Code (Optional)",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        ),
      ),
    );
  }

  Widget buildTermsCheckbox(BuildContext context, AccountState state) {
    return Row(
      children: [
        Checkbox(
          value: state.termsAgreed,
          onChanged: (value) {
            if (value != null) {
              context.read<AccountBloc>().add(TermsAgreedChanged(value));
            }
          },
        ),
        const Expanded(child: Text("I agree with the terms and conditions")),
      ],
    );
  }

  Widget buildSignUpButton(BuildContext context, AccountState state) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor:
              state.termsAgreed ? Colors.grey[700] : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: state.termsAgreed && !state.isLoading
            ? () {
                if (_formKey.currentState!.validate()) {
                  context.read<AccountBloc>().add(const SignUpSubmitted());
                }
              }
            : null,
        child: state.isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                "Sign up",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
      ),
    );
  }
}