import 'package:flutter_app/admin/view-admin.dart';
import 'package:flutter_app/bus/viewbus.dart';
import 'package:flutter_app/controller/dashboard_controller.dart';


import 'package:flutter/material.dart';
import 'package:flutter_app/parcours/view-parcours.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import '../../auth/home_admin.dart';
import '../../station/view-station.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) => Scaffold(
        
        body: SafeArea(
          
          child: IndexedStack(
            
            index: controller.tabIndex ?? 0,
           children: [
            
            Container(
              color: Colors.red,
              child:
                  AccueilAdmin(), // Add HomeAdmin() as the child of the first Container
            ),
            Container(
              color: Colors.blue,
              child: HomeStation(),
            ),
            Container(
              color: Colors.orange,
               child: HomeParcours(),
            ),
            Container(
              color: Colors.orange,
              child: HomeBus(),
            ),
          ]

          ),
        ),
        bottomNavigationBar: Container(
          
          
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 0.7
                  )
              )
          ),
          child: SnakeNavigationBar.color(
            behaviour: SnakeBarBehaviour.floating,
            snakeShape: SnakeShape.circle,
           height: 75,
            unselectedLabelStyle: const TextStyle(fontSize: 11),
            snakeViewColor: Theme.of(context).primaryColor,
            unselectedItemColor: Color(0xFF25243A),
            selectedItemColor:Color(0xFFffd400),
            showUnselectedLabels: true,
            currentIndex: controller.tabIndex,
            onTap: (val){
              controller.updateIndex(val);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.account_circle
                ), label: 'Admin',),
              BottomNavigationBarItem(icon: Icon(Icons.chair_alt_outlined
                  ), label: 'Station'),
              BottomNavigationBarItem(icon: Icon(Icons.route), label: 'Parcours',),
            BottomNavigationBarItem(
  icon: Icon(Icons.bus_alert, ),
  label: 'Bus',
  
   // Adjust the font size as needed
)

            ],
          ),
        ),
      ),
    );
  }
}