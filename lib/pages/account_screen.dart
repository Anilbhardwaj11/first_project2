import 'package:first_project/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  String? selectedCountryCode = "+91";
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  String? selectedFlag = "🇮🇳";

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    buildValidatedTextField(
                        Icons.person, "Student Name", nameController, (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    }),
                    const Text("Email",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    buildValidatedTextField(
                        Icons.email, "Enter your email", emailController,
                        (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    }),
                    const Text("Mobile Number",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    buildMobileNumberFields(),
                    const SizedBox(height: 10),
                    const Text("Country",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 13),
                    SelectState(
                      onCountryChanged: (value) {
                        setState(() {
                          selectedCountry = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          selectedState = value;
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          selectedCity = value;
                        });
                      },
                    ),
                    buildValidatedTextField(Icons.pin, "Pin Code (Optional)",
                        pinCodeController, null),
                    const SizedBox(height: 10),
                    buildTermsCheckbox(),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor:
                              isChecked ? Colors.grey[700] : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: isChecked
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()),
                                  );
                                }
                              }
                            : null,
                        child: const Text(
                          "Sign up",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildValidatedTextField(
    IconData icon,
    String hintText,
    TextEditingController controller,
    String? Function(String?)? validator,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        ),
      ),
    );
  }

  Widget buildMobileNumberFields() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () {
              showCountryPicker(
                context: context,
                onSelect: (Country country) {
                  setState(() {
                    selectedCountryCode = "+${country.phoneCode}";
                    selectedFlag = country.flagEmoji;
                  });
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
                  Text(selectedFlag!, style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 5),
                  Text(selectedCountryCode!,
                      style: const TextStyle(fontSize: 16)),
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

  Widget buildTermsCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        const Expanded(child: Text("I agree with the terms and conditions")),
      ],
    );
  }
}
