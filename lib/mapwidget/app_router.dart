import 'package:flutter/material.dart';
import 'package:flutter_app/admin/addadmin.dart';
import 'package:flutter_app/admin/view-admin.dart';
import 'package:flutter_app/auth/home_admin.dart';
import 'package:flutter_app/auth/logiin.dart';
import 'package:flutter_app/auth/login_admin.dart';
import 'package:flutter_app/auth/signup_admin.dart';
import 'package:flutter_app/admin/view-admin.dart';
import 'package:flutter_app/bus/addbus.dart';
import 'package:flutter_app/bus/viewbus.dart';
import 'package:flutter_app/parcours/Attribuer.dart';
import 'package:flutter_app/parcours/addparcours.dart';
import 'package:flutter_app/parcours/view-parcours.dart';
import 'package:flutter_app/role/home.dart';
import 'package:flutter_app/role/login.dart';
import 'package:flutter_app/role/register.dart';
import 'package:flutter_app/station/addstation.dart';
import 'package:flutter_app/station/view-station.dart';
import 'package:flutter_app/view/dashboard/dashboard_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/mapwidget/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:flutter_app/mapwidget/presentation/screens/map_screen.dart';
import 'package:flutter_app/mapwidget/presentation/screens/otp_screen.dart';
import '../auth/Homepage.dart';
import 'business_logic/cubit/maps/maps_cubit.dart';
import 'constnats/strings.dart';
import 'data/repository/maps_repo.dart';
import 'data/webservices/places_webservices.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/locationfirestore.dart';

class AppRouter {
  PhoneAuthCubit? phoneAuthCubit;

  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mapScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                MapsCubit(MapsRepository(PlacesWebservices())),
            child: MapScreen(),
          ),
        );

      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: LoginScreen(),
          ),
        );

      case otpScreen:
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: OtpScreen(phoneNumber: phoneNumber),
          ),
        );

        case Login:
        return MaterialPageRoute(
          builder: (_) =>  LoginUser(),
        );

        case Connecter:
        return MaterialPageRoute(
          builder: (_) =>  LoginAdmin(),
        );

        case bus:
        return MaterialPageRoute(
          builder: (_) =>  DashboardScreen(),
        );
    

         case  Inscrire:
        return MaterialPageRoute(
          builder: (_) =>  signupAdmin(),
        );
       
        
        
         case  Initial:
        return MaterialPageRoute(
          builder: (_) =>  Register(),
        );
         

         

        case  loginuser:
        return MaterialPageRoute(
          builder: (_) =>  LoginUser(),
        );
        case  addBus:
        return MaterialPageRoute(
          builder: (_) =>  AddBus(),
        );
        case  homeBus:
        return MaterialPageRoute(
          builder: (_) =>  HomeBus(),
        );

        
         case  addAdmin:
        return MaterialPageRoute(
          builder: (_) =>  AddAdmin(),
        );
        
      

         case  Accueil:
        return MaterialPageRoute(
          builder: (_) =>  AccueilAdmin(),
        );


         case homeStation:
         return MaterialPageRoute(
          builder: (_) =>  HomeStation(),
        );
       

        case addStation:
         return MaterialPageRoute(
          builder: (_) =>  AddStation(),
        );

        

         case addParcours:
         return MaterialPageRoute(
          builder: (_) =>  AddParcours(),
        );

        
          case homeParcours:
         return MaterialPageRoute(
          builder: (_) =>  HomeParcours(),
        );
       case AttParcours:
         return MaterialPageRoute(
          builder: (_) =>  Attribuer(),
        );
   case mapSation:
         return MaterialPageRoute(
          builder: (_) =>  StationsMap(),
        );

        
        
    }
  }
}



