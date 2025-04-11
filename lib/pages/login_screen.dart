import 'package:first_project/Utils/dynamic_size.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _phoneNumber;
  bool _isLoading = false;

  Future<void> sendOtp(String phoneNumber) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    final sizes = AppSizes(context);

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

                // Google Button
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.google,
                    size: sizes.iconSize(0.07),
                    color: const Color.fromARGB(255, 74, 142, 197),
                  ),
                  label: Text(
                    "Google",
                    style: TextStyle(
                      fontSize: sizes.fontSize(0.06),
                      color: const Color.fromARGB(255, 74, 142, 197),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(sizes.containerWidth(0.9), sizes.containerHeight(0.065)),
                    backgroundColor: const Color.fromARGB(255, 212, 210, 210),
                  ),
                ),
                SizedBox(height: sizes.sizedBoxHeight(0.015)),

                // Facebook Button
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.facebook,
                    size: sizes.iconSize(0.07),
                    color: const Color.fromARGB(255, 74, 142, 197),
                  ),
                  label: Text(
                    "Facebook",
                    style: TextStyle(
                      fontSize: sizes.fontSize(0.06),
                      color: const Color.fromARGB(255, 74, 142, 197),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(sizes.containerWidth(0.9), sizes.containerHeight(0.065)),
                    backgroundColor: const Color.fromARGB(255, 212, 210, 210),
                  ),
                ),
                SizedBox(height: sizes.sizedBoxHeight(0.015)),

                // Twitter Button
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.twitter,
                    size: sizes.iconSize(0.07),
                    color: const Color.fromARGB(255, 74, 142, 197),
                  ),
                  label: Text(
                    "Twitter",
                    style: TextStyle(
                      fontSize: sizes.fontSize(0.06),
                      color: const Color.fromARGB(255, 74, 142, 197),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(sizes.containerWidth(0.9), sizes.containerHeight(0.065)),
                    backgroundColor: const Color.fromARGB(255, 212, 210, 210),
                  ),
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
                    onChanged: (phone) => _phoneNumber = phone.completeNumber,
                    validator: (phone) {
                      if (phone == null || phone.number.isEmpty) {
                        return 'Please enter a valid mobile number';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: sizes.sizedBoxHeight(0.025)),

                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => _isLoading = true);
                            try {
                              await sendOtp(_phoneNumber!);
                              context.push('/login');
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Failed to send OTP. Try again later.'),
                                ),
                              );
                            } finally {
                              setState(() => _isLoading = false);
                            }
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 81, 79, 79),
                    minimumSize: Size(double.infinity, sizes.containerHeight(0.065)),
                  ),
                  child: _isLoading
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
  }
}
