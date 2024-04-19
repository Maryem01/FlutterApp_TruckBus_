import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/admin/addadmin.dart';
import 'package:flutter_app/admin/view-admin.dart';
import 'package:flutter_app/auth/home_admin.dart';
import 'package:flutter_app/auth/logiin.dart';
import 'package:flutter_app/bus/addbus.dart';
import 'package:flutter_app/bus/editbus.dart';
import 'package:flutter_app/parcours/addparcours.dart';
import 'package:flutter_app/parcours/view-parcours.dart';
import 'package:flutter_app/station/addstation.dart';
import 'package:flutter_app/station/view-station.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBus extends StatefulWidget {
  const HomeBus({Key? key}) : super(key: key);

  @override
  _HomeBusState createState() => _HomeBusState();
}

class _HomeBusState extends State<HomeBus> {
  List<QueryDocumentSnapshot> data = [];
  bool isLoading = true;

  getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("bus").get();

    setState(() {
      data.addAll(querySnapshot.docs);
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedStation = ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFFCA20),
        foregroundColor: Colors.black54,
        onPressed: () {
          Navigator.of(context).pushNamed("/AddBus");
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF25243A),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).popAndPushNamed("/dashboard", arguments: 3);
          },
        ),
        iconTheme: IconThemeData(color: Color(0xFFffd400)),
        title: const Text(
          'Liste de Bus',
          style: TextStyle(color: Color(0xFFffd400), fontSize: 17),
        ),
      ),
      body: WillPopScope(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                itemCount: data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisExtent: 100,
                ),
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {},
                    onLongPress: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.rightSlide,
                        title: 'Confirmation',
                        desc: 'Voulez-vous vraiment modifier ou supprimer ce bus?',
                        btnCancelText: "Supprimer",
                        btnOkText: "Modifier",
                        btnCancelOnPress: () async {
                          await FirebaseFirestore.instance.collection("bus").doc(data[i].id).delete();
                          Navigator.of(context).pushReplacementNamed("/HomeBus");
                        },
                        btnOkOnPress: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditBus(
                              docid: data[i].id,
                              oldnombus: data[i]["nombus"],
                              oldimmat: data[i]["immat"],
                            ),
                          ));
                        },
                      ).show();
                    },
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        color: Color.fromARGB(255, 236, 236, 236),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              "images/308.png",
                              height: 50,
                            ),
  MaterialButton(
  color: Color(0xFFFFCA20),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  elevation: 5.0,
  child: Text(
    "add",
    style: TextStyle(color: Color(0xFF25243A), fontSize: 17.0),
  ),
  onPressed: () async {
    final selectedStations = await Navigator.of(context).pushNamed(
      "/Attribuer",
    );

    if (selectedStations != null && selectedStations is List<String>) {
      // Convert the selectedStations to a list of strings
      List<String> newStations = List<String>.from(selectedStations);

      // Update the current document in Firestore by appending the new stations to the existing list
      await FirebaseFirestore.instance.collection("bus").doc(data[i].id).update({
        'nomstation': FieldValue.arrayUnion(newStations),
      });

      // Show a SnackBar with the added stations
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nomstations added: ${newStations}'),
          duration: Duration(seconds: 2), // Adjust the duration as needed
        ),
      );
      
      // Refresh data to reflect changes
   
    }
  },
),





                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Bus: ${data[i]['nombus']}"),
                                Text("immat: ${data[i]['immat']}"),
                               
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
        onWillPop: () {
          Navigator.of(context).pushNamedAndRemoveUntil("/HomeAdmin", (route) => false);
          return Future.value(false);
        },
      ),
    );































  }
}