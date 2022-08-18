import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:testproject/model/location_suggest_model.dart';
import 'package:testproject/model/user_model.dart';

class Pref {
  static final Pref _singleton = Pref._internal();

  factory Pref() => _singleton;

  Pref._internal();

  // Create storage
  final storage = const FlutterSecureStorage();

  Future<bool> get isLoggedIn async {
    return (await storage.read(key: 'isLoggedIn')) == 'true';
  }

  set isLoggedIn(isTrue) {
    storage.write(key: 'isLoggedIn', value: isTrue.toString());
  }

  static String deviceLocation = '';

  void registerUser(UserModel user) async {
    await storage.write(key: user.userName, value: json.encode(user.toMap()));
    await storage.write(key: user.email, value: json.encode(user.toMap()));
  }

  Future<bool> logInUser(String key, String password) async {
    String? result = await storage.read(key: key);
    if (result != null) {
      return (jsonDecode(result)['token'] == password);
    }
    return false;
  }

  Future<int> get selectedAddress async {
    String? selectedIndex = await storage.read(key: 'selectedAddress');
    if (selectedIndex != null) {
      return int.parse(selectedIndex);
    } else {
      return 0;
    }
  }

  set selectedAddress(selectedAddress) {
    storage.write(key: 'selectedAddress', value: selectedAddress.toString());
  }

  Future<List<String>> get recentAddresses async {
    String? result = await storage.read(key: 'recentAddresses');
    if (result != null) {
      return (json.decode(result) as List<dynamic>).cast<String>();
    } else {
      return [];
    }
  }

  set recentAddresses(recentAddresses) {
    storage.write(key: 'recentAddresses', value: json.encode(recentAddresses));
  }

  Future<List<SuggestLocationModel>> get recentAddressesLatLng async {
    String? result = await storage.read(key: 'recentAddressesLatLng');
    if (result != null) {
      final resultDecode = json.decode(result) as List<dynamic>;
      List<SuggestLocationModel> data = [];
      for (int i = 0; i < resultDecode.length; i++) {
        data.add(SuggestLocationModel.fromMapStorage(resultDecode[i]));
      }
      return data;
    } else {
      return [];
    }
  }

  set recentAddressesLatLng(recentAddressesLatLng) {
    List<Map<String, dynamic>> map = [];
    for (var element in recentAddressesLatLng) {
      map.add(element.toMap());
    }

    storage.write(key: 'recentAddressesLatLng', value: json.encode(map));
  }
}
