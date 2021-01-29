import 'package:shared_preferences/shared_preferences.dart';

class CartPreferences {
  static SharedPreferences _preferences;

  static const _keyItemsCounter = 'itemsCounter';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setItemsCounter(String itemsCount) async {

    await _preferences.setString(_keyItemsCounter, itemsCount);

    print('itemCount is set as $itemsCount');
  }

  static getItemsCounter() {
   final val = _preferences.getString(_keyItemsCounter);
      print('getItemsCounter Triggered' + '   '+ val);
      return val;
  }

}
