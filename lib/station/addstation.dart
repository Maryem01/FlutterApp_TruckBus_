import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/componenents/custombuttonauth.dart';
import 'package:flutter_app/componenents/customlogoauth.dart';
import 'package:flutter_app/componenents/textformfield.dart';
import 'package:flutter_app/componenents/custombuttonauth.dart';
import 'package:flutter_app/componenents/customlogoauth.dart';
import 'package:flutter_app/componenents/textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddStation extends StatefulWidget {
  const AddStation({super.key});

  @override
  State<AddStation> createState() => _AddStationState();
}

class _AddStationState extends State<AddStation> {
 GlobalKey<FormState> formState=  GlobalKey<FormState>();
 TextEditingController nomstation= TextEditingController();
 TextEditingController latitude= TextEditingController();
 TextEditingController longtude= TextEditingController();
 
 CollectionReference station = FirebaseFirestore.instance.collection('station');
bool isLoading= false;
AddStation() async{
  if (formState.currentState!.validate()){
    try {
      isLoading= true;
      setState(() {
        
      });
    DocumentReference response = await station.add(
  {
     "Utilisateur": {
              "id": FirebaseAuth.instance.currentUser!.uid,
            },
    "nomstation": nomstation.text,
    "latitude": latitude.text,
    "longtude": longtude.text,
    
    // Ajoutez d'autres champs du bus au besoin
  },
);
    Navigator.of(context).pushNamedAndRemoveUntil("/HomeStation", (route) => false);
    } catch(e) {
      isLoading= false;
      setState(() {
        
      });
      print("Error $e");
    }
  }
}
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nomstation.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF25243A),
        iconTheme: IconThemeData(color: Color(0xFFffd400)),
        title:  const Text('Ajouter Station',  style: TextStyle(color: Color(0xFFffd400)),),
       
        ),
      body: Form(
        key: formState,
        child: isLoading ? Container(child: CircularProgressIndicator()) 
        : SingleChildScrollView(
          child: Column(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 65, vertical: 55),
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
              Center(
                            child: Text("Informations Générales",
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color:  Color(0xFF25243))),
                          ),
                          SizedBox(
                              height:
                                  40), 
               
                TextFormField(
           
          controller: nomstation,
         decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: ' Nom Station',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 14),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFFFCA20)),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                   
                                    
                                  ),
          validator: (val) {
            if (val == "") {
              return "Ne peut pas être vide";
            }
          }, 
                ),
                SizedBox(height: 30),
                // Ajout d'un espace vertical entre les champs de texte
                TextFormField(
          
          controller: latitude,
          decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: ' Latitude',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 14),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFFFCA20)),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                   
                                    
                                  ),
          validator: (val) {
            if (val == "") {
              return "Ne peut pas être vide";
            }
          },
                ),
                SizedBox(height: 30), // Ajout d'un espace vertical entre les champs de texte
               
                TextFormField(
          
          controller: longtude,
          decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: ' Longitude',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 14),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFFFCA20)),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                   
                                    
                                  ),
          validator: (val) {
            if (val == "") {
              return "Ne peut pas être vide";
            }
          },
                ),
                
              ],
            ),
          ),
            MaterialButton(
               color: Color(0xFFFFCA20),
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
        elevation: 5.0,
        minWidth: 200.0,
        height: 45,
              
                     child: Text("Sauvegarder",  style: TextStyle(color : Color(0xFF25243A ),fontSize: 17.0, )),
              onPressed: (){
                AddStation();
              },)
          
          ],),
        ),
      ),

    );
  }
}