import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkLoggedInStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('islogin') ?? false;
}
