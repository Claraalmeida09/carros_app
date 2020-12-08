import 'package:carros_app/utils/simple_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class LoripsumBloc extends SimpleBloc<String>{

  static String lorim;

  loadData() async {

      String s = lorim ?? await LoripsumApi.getLoripsum();

      lorim = s;

      add(s);

    }
  }

class LoripsumApi {
  static Future<String> getLoripsum( ) async {
    var url = 'https://loripsum.net/api';


    print("GET > $url");

    var response = await http.get(url);

    String text = response.body;
    //print(text);

    text = text.replaceAll("<p>", "");
    text = text.replaceAll("</p>", "");

    return text;
  }
}