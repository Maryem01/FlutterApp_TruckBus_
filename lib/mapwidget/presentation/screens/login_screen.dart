import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/mapwidget/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:flutter_app/mapwidget/constnats/my_colors.dart';
import 'package:flutter_app/mapwidget/constnats/strings.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _phoneFormKey = GlobalKey();

  late String phoneNumber;

  Widget _buildIntroTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '',
          style: TextStyle(
              color: Color.fromARGB(255, 164, 164, 164), fontSize: 24, fontWeight: FontWeight.bold),
        ),
    
        Container(
          
        child: RichText(
                                        text: TextSpan(
                                          children: [
                                           TextSpan(
                  text: 'Planifiez votre trajet',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF25243A),
                  ),
                ),
                TextSpan(
                  text: ' sans perdre de temps\n \n',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[800],
                  ),
                ),
                TextSpan(
                  text: 'à attendre',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF25243A),
                  ),
                ),
                TextSpan(
                  text: ' le bus',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[800],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
        ),
      ],
    );
  }

  Widget _buildPhoneFormField() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all( color: Color(0xFF25243A)),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Text(
              generateCountryFlag() + ' +216',
              style: TextStyle(fontSize: 18, letterSpacing: 2.0, color: Color(0xFF25243A)),
            ),
          ),
        ),
      SizedBox(width: 10,),
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
           
            child: TextFormField(
              
              autofocus: true,
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 2.0,
              ),
              decoration: InputDecoration(border: OutlineInputBorder(),
                                    labelText: ' Téléphone',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelStyle: TextStyle(
                                      color: Color(0xFF25243A),
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF25243A)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:  Color(0xFF25243A)),
                                      borderRadius: BorderRadius.circular(5),
                                    ),),
                
              cursorColor: Colors.orange[800],
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter yout phone number!';
                } else if (value.length < 8) {
                  return 'Too short for a phone number!';
                }
                return null;
              },
              onSaved: (value) {
                phoneNumber = value!;
              },
            ),
          ),
        ),
      ],
    );
  }

  String generateCountryFlag() {
    String countryCode = 'tn';

    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

    return flag;
  }

  Future<void> _register(BuildContext context) async {
    if (!_phoneFormKey.currentState!.validate()) {
      Navigator.pop(context);
      return;
    } else {
      Navigator.pop(context);
      _phoneFormKey.currentState!.save();
      BlocProvider.of<PhoneAuthCubit>(context).submitPhoneNumber(phoneNumber);
    }
  }

  void navigateToOtherComponent(BuildContext context) {
    Navigator.pushNamed(context, '/register');
  }

  Widget _buildNextButton(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: MaterialButton(
        
        color: Colors.orange[800],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
        elevation: 5.0,
        minWidth: 435.0,
        height: 50,
        
        onPressed: () {
          showProgressIndicator(context);

          _register(context);
        }, 
        /*MaterialButton(
              color: Color(0xFFFFCA20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        elevation: 5.0,
        minWidth: 200.0,
        height: 45,
              
              child: Text("Sauvegarder",  style: TextStyle(color : Color(0xFF25243A ),fontSize: 17.0, )),*/
        child: Text("Envoyer un code",  style: TextStyle(color : Color.fromARGB(255, 247, 247, 248),fontSize: 18.0, )),
          
        
      ),

         
    );
    
  }

  Widget _buildOtherComponentButton(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      
      child: TextButton(
        onPressed: () {
          
          navigateToOtherComponent(context);
          
        },

       child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
         children: [
           RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Se connecter en tant',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color:  Color(0xFF25243A ),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' qu\'administrateur ? ',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.orange[800],
                                                  ),
                                                ),
                                               
                                              ],
                                            ),
                                          ),
         ],
       ),
                                      
      ),
      
    );

  }

  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
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

  Widget _buildPhoneNumberSubmitedBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
        }

        if (state is PhoneNumberSubmited) {
          Navigator.pop(context);
          Navigator.of(context).pushNamed(otpScreen, arguments: phoneNumber);
        }

        if (state is ErrorOccurred) {
          Navigator.pop(context);
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
    backgroundColor: Color.fromARGB(255, 244, 244, 244),
    body: Padding(
       padding: const EdgeInsets.only(right: 40.0, left: 40,),
      child: Form(
        key: _phoneFormKey,
       
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIntroTexts(),
              SizedBox(
                height: 20,
              ),
              _buildPhoneFormField(),
              SizedBox(
                height: 20,
              ),
              _buildNextButton(context),
              SizedBox(
                height: 20,
              ),
              _buildPhoneNumberSubmitedBloc(),
              _buildOtherComponentButton(context),
             
              
            ],
          ),
        
      ),
    ),
  ),
);

  }
}