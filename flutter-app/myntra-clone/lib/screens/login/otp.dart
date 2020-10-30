import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_myntra_clone/common_widgets/back_button.dart' as bb;
import 'package:flutter_myntra_clone/common_widgets/cached_image.dart';
import 'package:flutter_myntra_clone/screens/home_screen.dart';
import 'package:flutter_myntra_clone/utils/asset_constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Otp extends StatefulWidget {
  static const routeName = '/otp';

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  String _otp = "";
  String _mobileNumber;
  StreamController<ErrorAnimationType> errorController;
  bool hasError = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();

  void _validateAndSubmitOTP(BuildContext ctx) {
    formKey.currentState.validate();

    if (!_validateOtp()) {
      errorController.add(ErrorAnimationType.shake);
      setState(() {
        hasError = true;
      });
    } else {
      setState(() {
        hasError = false;
      });
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }

  bool _validateOtp() {
    if (_otp.length != 4) {
      return false;
    }
    if (int.tryParse(_otp) == null) {
      return false;
    }
    return true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mobileNumber = ModalRoute.of(context).settings.arguments.toString();
  }

  @override
  void dispose() {
    super.dispose();
    errorController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Builder(
          builder: (ctx) => SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Positioned(
                    top: 18,
                    left: 18,
                    child: bb.BackButton(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedImage(
                          url: mobile_verification,
                          height: 90,
                          width: 90,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Verify with OTP',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Sent to $_mobileNumber',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          child: Form(
                            key: formKey,
                            child: PinCodeTextField(
                              length: 4,
                              animationType: AnimationType.fade,
                              keyboardType: TextInputType.number,
                              textStyle: TextStyle(
                                color: Colors.black,
                              ),
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                fieldHeight: 40,
                                fieldWidth: 30,
                                activeFillColor: Colors.white,
                                inactiveColor: Colors.grey.shade300,
                                selectedColor: Colors.black87,
                                activeColor: Colors.grey.shade300,
                              ),
                              animationDuration: Duration(milliseconds: 300),
                              errorAnimationController: errorController,
                              controller: textEditingController,
                              onChanged: (value) {
                                setState(() {
                                  _otp = value;
                                });
                              },
                              onCompleted: (value) =>
                                  _validateAndSubmitOTP(ctx),
                              beforeTextPaste: (text) {
                                return false;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'RESEND OTP',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Color.fromRGBO(255, 63, 108, 1),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Log in using ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: 'Password',
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 63, 108, 1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Having trouble logging in? ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: 'Get help',
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 63, 108, 1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
