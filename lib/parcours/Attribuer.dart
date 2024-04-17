import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Attribuer extends StatefulWidget {
  const Attribuer({Key? key}) : super(key: key);

  @override
  State<Attribuer> createState() => _AttribuerState();
}

class _AttribuerState extends State<Attribuer> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isLoading = false;
  List<String> stationNames = [];
  String? selectedStation;

  @override
  void initState() {
    super.initState();
    fetchStationNames();
  }

  void fetchStationNames() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('station').get();
    setState(() {
      stationNames =
          snapshot.docs.map((doc) => doc['nomstation'] as String).toList();
    });
  }

  void addBus(String selectedStation) async {
    try {
      await FirebaseFirestore.instance.collection('bus').add({
        'nomstation': selectedStation,
        'nombus': 'Your Bus Name', // Add your bus name here
        'immat': 'Your Bus Immatriculation', // Add your bus immatriculation here
        // Add other fields if needed
      });
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushNamedAndRemoveUntil(
          "/HomeBus", (route) => false);
    } catch (e) {
      print("Error $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF25243A),
        iconTheme: IconThemeData(color: Color(0xFFffd400)),
        title: const Text(
          'Ajouter Bus',
          style: TextStyle(color: Color(0xFFffd400)),
        ),
      ),
      body: Form(
        key: formState,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 65, vertical: 55),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Informations Générales",
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF25243A),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: ' Nom Station',
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 14),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFFFCA20)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            value: selectedStation,
                            onChanged: (newValue) {
                              setState(() {
                                selectedStation = newValue;
                              });
                            },
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Veuillez sélectionner une station';
                              }
                              return null;
                            },
                            items: stationNames.toSet().map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
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
                      child: Text(
                        "Sauvegarder",
                        style: TextStyle(color: Color(0xFF25243A), fontSize: 17.0),
                      ),
                     onPressed: () {
  if (formState.currentState!.validate()) {
    setState(() {
      isLoading = true;
    });
    Navigator.of(context).pop(selectedStation);
  }
},

                    ),
                    
                  ],
                ),
              ),
      ),
    );
  }
}
