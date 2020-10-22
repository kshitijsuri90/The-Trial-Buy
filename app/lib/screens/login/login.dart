import 'package:flutter/material.dart';
import 'package:flutter_myntra_clone/common_widgets/cached_image.dart';
import 'package:flutter_myntra_clone/common_widgets/primary_button.dart';
import 'package:flutter_myntra_clone/screens/login/otp.dart';
import 'package:flutter_myntra_clone/utils/asset_constants.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _form = GlobalKey<FormState>();
  int _mobileNumber;

  void _validateAndLogin(BuildContext ctx) async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();

    Navigator.of(context)
        .pushNamed(Otp.routeName, arguments: _mobileNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Builder(
        builder: (ctx) => SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CachedImage(
                  url: banner_login_landing,
                  height: 165,
                  width: double.infinity,
                ),
                Padding(
                  padding: EdgeInsets.all(36),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Login ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: 'or',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                TextSpan(
                                  text: ' Signup',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Form(
                          key: _form,
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              labelText: 'Mobile Number',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              alignLabelWithHint: true,
                              errorStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onFieldSubmitted: (_) => _validateAndLogin(ctx),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            validator: (value) =>
                                validateMobileNumberInput(value),
                            onSaved: (value) {
                              _mobileNumber = int.parse(value);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Container(
                          width: double.infinity,
                          child: ButtonTheme(
                            child: PrimaryButton(
                              title: 'CONTINUE',
                              onPressed: () => _validateAndLogin(ctx),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String validateMobileNumberInput(value) {
    if (value.isEmpty) {
      return 'Please enter a valid mobile number (10 digits)';
    }
    if (value.length != 10) {
      return 'Please enter a valid mobile number (10 digits)';
    }
    if (int.tryParse(value) == null) {
      return 'Please enter a valid mobile number (10 digits)';
    }
    return null;
  }
}
