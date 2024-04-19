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
  List<String> selectedStations = [];
  List<String> stationIds = [];

  @override
  void initState() {
    super.initState();
    fetchStationNames();
  }

  void fetchStationNames() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('station').get();
    setState(() {
      stationNames = snapshot.docs
          .map((doc) => "${doc['nomstation']} (ID: ${doc.id})")
          .toList();
    });
  }

  void addBus(List<String> selectedStations) async {
    try {
      await FirebaseFirestore.instance.collection('bus').add({
        'nomstations': selectedStations,
        'nombus': 'Your Bus Name', // Add your bus name here
        'immat':
            'Your Bus Immatriculation', // Add your bus immatriculation here
      });
      setState(() {
        isLoading = false;
      });
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/HomeBus", (route) => false);
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 65, vertical: 55),
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
                              labelText: 'Nom Stations',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 14),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFFFCA20)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            value: null,
                            onChanged: (newValue) {
                              setState(() {
                                selectedStations.add(newValue!);
                              });
                            },
                            items: stationNames
                                .toSet()
                                .map<DropdownMenuItem<String>>((String value) {
                              // Split the value to get only the station name
                              String stationName =
                                  value.split('(ID:')[0].trim();
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(stationName),
                              );
                            }).toList(),
                            isExpanded: true,
                            // Allow multiple selection
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            dropdownColor: Colors.white,
                            // Clear selected station after it's selected
                            onSaved: (value) {
                              selectedStations.add(value!);
                            },
                          ),
                          SizedBox(height: 20),
                          // Display selected stations
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: selectedStations
                                .map((station) => Chip(
                                      label: Text(station
                                          .split('(ID:')[0]
                                          .trim()), // Display only the station name
                                      onDeleted: () {
                                        setState(() {
                                          selectedStations.remove(station);
                                        });
                                      },
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      color: Color(0xFFFFCA20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      elevation: 5.0,
                      child: Text(
                        "Sauvegarder",
                        style:
                            TextStyle(color: Color(0xFF25243A), fontSize: 17.0),
                      ),
                      onPressed: () {
                        if (formState.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          Navigator.of(context).pop(selectedStations);
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
