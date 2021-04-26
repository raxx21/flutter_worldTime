import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location; // Location name for UI
  String time; // time of that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  bool isDayTime; // true or false

  WorldTime({this.location,this.flag,this.url});

  Future<void> getTime() async{

    try{
      //Make a req
      Response response = await get('https://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      String offset1 = data['utc_offset'].substring(4,6);

      //create DataTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset),minutes: int.parse(offset1)));

      //set time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('error catch!');
      time = 'Please close and open again';
      isDayTime = false;
    }

  }
}
