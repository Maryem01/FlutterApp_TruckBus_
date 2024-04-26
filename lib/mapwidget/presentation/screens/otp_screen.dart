import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/mapwidget/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:flutter_app/mapwidget/constnats/my_colors.dart';
import 'package:flutter_app/mapwidget/constnats/strings.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class OtpScreen extends StatelessWidget {
  final phoneNumber;

  OtpScreen({Key? key, required this.phoneNumber}) : super(key: key);

  late String otpCode;

  Widget _buildIntroTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       
         Image.asset(
                               "images/otp.png",
                                width: 100,
                              ),
        
        SizedBox(
          height: 30,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: RichText(
            text: TextSpan(
              text: 'Entrez vos numéros de code à six chiffres envoyés à ',
              style: TextStyle(
                  color:  Color(0xFF25243A), fontSize: 18, height: 1.4),
              children: <TextSpan>[
                TextSpan(
                  text: '$phoneNumber',
                  style: TextStyle(color:Colors.orange[800]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
    );

    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  Widget _buildPinCodeFields(BuildContext context) {
    return Container(
      child: PinCodeTextField(
        appContext: context,
        autoFocus: true,
        cursorColor: Colors.orange[800],
        keyboardType: TextInputType.number,
        length: 6,
        obscureText: false,
        animationType: AnimationType.scale,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          borderWidth: 1,
          activeColor: Colors.orange[800],
          inactiveColor:  Color.fromARGB(255, 248, 80, 2),
          inactiveFillColor: Colors.white,
          activeFillColor: Color.fromARGB(255, 243, 213, 194),
          selectedColor: Colors.orange[800],
          selectedFillColor: Colors.white,
        ),
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Colors.white,
        enableActiveFill: true,
        onCompleted: (submitedCode) {
          otpCode = submitedCode;
          print("Completed");
        },
        onChanged: (value) {
          print(value);
        },
      ),
    );
  }

  void _login(BuildContext context) {
    BlocProvider.of<PhoneAuthCubit>(context).submitOTP(otpCode);
  }

  Widget _buildVrifyButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: MaterialButton(
        color: Colors.orange[800],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        elevation: 5.0,
        minWidth: 435.0,
        height: 50,
        onPressed: () {
          showProgressIndicator(context);

          _login(context);
        },
        child: Text("Continuer",
            style: TextStyle(
              color: Color.fromARGB(255, 247, 247, 248),
              fontSize: 24.0,
            )),
      ),
    );
  }

  Widget _buildPhoneVerificationBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
        }

        if (state is PhoneOTPVerified) {
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed("/map-screen");
        }

        if (state is ErrorOccurred) {
          //Navigator.pop(context);
          String errorMsg = (state).errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 32, vertical: 88),
          child: Column(
            children: [
              _buildIntroTexts(),
              SizedBox(
                height: 20,
              ),
              _buildPinCodeFields(context),
              SizedBox(
                height: 20,
              ),
              _buildVrifyButton(context),
              _buildPhoneVerificationBloc(),
            ],
          ),
        ),
      ),
    );
  }
}
