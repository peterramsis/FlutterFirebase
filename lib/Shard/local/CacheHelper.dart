import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences? _sharedPreferences;

  static init() async{
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setBool({
    @required String? key , @required bool? value
  }) async{
    return _sharedPreferences!.setBool(key!, value!);
  }

  static dynamic getData({
    @required String? key
  }){
    return _sharedPreferences!.get(key!);
  }

  static Future<bool> setData({  @required String? key , @required dynamic value}){
    if(value is bool)
    {
      return _sharedPreferences!.setBool(key!, value);
    }else if(value is String){
      return _sharedPreferences!.setString(key!, value);
    }else if(value is int){
      return _sharedPreferences!.setInt(key!, value);
    }else {
      return _sharedPreferences!.setDouble(key!, value);
    }
  }
  static Future<bool> removeData({ @required String? key}){
    return _sharedPreferences!.remove(key!);
  }
}