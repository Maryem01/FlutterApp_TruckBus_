
import 'package:flutter/material.dart';
import 'package:flutter_app/otpverify/otp_screen.dart';
import 'package:flutter_app/otpverify/controllers/login_controller.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final phone = TextEditingController();
  final LoginController loginController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text('Login Screen'),
        ),
        body: loginController.isLoading(false)
            ? Center(child: CircularProgressIndicator())
            : ListView(children: [
                new Column(
                  children: [
                    Form(
                        child: Column(
                      children: [
                        Container(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: TextFormField(
                            controller: phone,
                            keyboardType: TextInputType.phone,
                            decoration:
                                InputDecoration(labelText: 'Phone Number'),
                          ),
                        )),
                        Container(
                            margin: EdgeInsets.only(top: 40, bottom: 5),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    loginController.verifyPhone(phone.text);
                                    Get.to(OtpScreen());
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15.0,
                                        horizontal: 15.0,
                                      ),
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                              child: Text(
                                            "Sign In",
                                            textAlign: TextAlign.center,
                                          )),
                                        ],
                                      )),
                                ))),
                      ],
                    ))
                  ],
                )
              ]));
  }
} 
