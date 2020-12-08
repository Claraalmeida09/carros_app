import 'package:carros_app/pages/carros/home_page.dart';
import 'package:carros_app/pages/favoritos/db_helper.dart';
import 'package:carros_app/pages/login/login_page.dart';
import 'package:carros_app/pages/login/usuarios.dart';
import 'package:carros_app/utils/push.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // Future.delayed(Duration(seconds: 5), (){
    //   push(context, LoginPage());
    // });

    Future futureA = DatabaseHelper.getInstance().db;

    Future futureB = Future.delayed(Duration(seconds: 3));

    Future<Usuario> futureC = Usuario.get();
    // future.then((Usuario user) {
    //   if(user != null) {
    //     push(context, HomePage(), replace: true);
    //   }
    // });
    
    Future.wait([futureA, futureB, futureC]).then((List values) {
      Usuario user = values[2];

      if(user != null) {
        push(context, HomePage(), replace: true);
      } else
        push(context, LoginPage());
      }
    );
    
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }


}
