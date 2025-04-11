import 'package:first_project/Utils/dynamic_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final _formKey = GlobalKey<FormState>();
  String otp = '';

  late AppSizes sizes;

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _verifyOtp() {
    if (_formKey.currentState!.validate()) {
      otp = _controllers.map((controller) => controller.text).join();
      if (otp.length == 6) {
        context.go('/verify');
      } else {
        _showSnackbar("Please enter all 6 digits.");
      }
    }
  }

  void _resendOtp() {
    for (var controller in _controllers) {
      controller.clear();
    }
    FocusScope.of(context).requestFocus(_focusNodes[0]);
    _showSnackbar("A new OTP has been sent to your mobile number.");
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildDigitField(int index) {
    return SizedBox(
      height: sizes.containerHeight(0.08),
      width: sizes.containerWidth(0.11),
      child: TextFormField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: sizes.fontSize(0.06)),
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }
          return null;
        },
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < 5) {
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            } else {
              _focusNodes[index].unfocus();
            }
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          filled: true,
          fillColor: const Color(0xFFE5E7EB),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          errorStyle: const TextStyle(height: 0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    sizes = AppSizes(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sizes.sizedBoxWidth(0.06)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: sizes.sizedBoxHeight(0.02)),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Verify Code",
                  style: TextStyle(
                    fontSize: sizes.fontSize(0.06),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: sizes.sizedBoxHeight(0.01)),
              Text(
                "A 6-digit code has been sent to your number.",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: sizes.fontSize(0.04),
                ),
              ),
              Text(
                "Enter it below to verify your identity.",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: sizes.fontSize(0.04),
                ),
              ),
              SizedBox(height: sizes.sizedBoxHeight(0.04)),
              Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, _buildDigitField),
                ),
              ),
              SizedBox(height: sizes.sizedBoxHeight(0.06)),
              Text(
                "Didn't receive the code?",
                style: TextStyle(
                  fontSize: sizes.fontSize(0.042),
                  color: Colors.grey,
                ),
              ),
              TextButton(
                onPressed: _resendOtp,
                child: Text(
                  "Resend OTP",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: sizes.fontSize(0.045),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: sizes.sizedBoxHeight(0.05)),
              ElevatedButton(
                onPressed: _verifyOtp,
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      Size(double.infinity, sizes.containerHeight(0.065)),
                  backgroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Verify",
                  style: TextStyle(
                    fontSize: sizes.fontSize(0.05),
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
