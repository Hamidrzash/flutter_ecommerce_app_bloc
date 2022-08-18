import 'package:dio/dio.dart';
import 'package:testproject/model/location_model.dart';
import 'package:testproject/model/location_suggest_model.dart';
import 'package:testproject/model/order_model.dart';
import 'package:testproject/model/product_model.dart';

class Request {
  static final Request _singleton = Request._internal();

  factory Request() => _singleton;

  Request._internal() {
    _dio.options.receiveTimeout = 5000;
    _dio.options.connectTimeout = 5000;
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (option, handler) {
        handler.next(option);
      },
      onError: (option, handler) {
        handler.next(option);
      },
      onResponse: (option, handler) {
        handler.next(option);
      },
    ));
  }

  final _dio = Dio();

  Future<List<SuggestLocationModel>> autoCompleteLocation({
    required String input,
    required double latitude,
    required double longitude,
  }) async {
    List<SuggestLocationModel> addresses = [];
    Response response = await _dio.get(
      'https://api.neshan.org/v1/search?term=$input&lat=$latitude&lng=$longitude',
      options: Options(
        headers: {
          'Api-Key': 'service.pqhBjCcGV282IfroYBBAYkUY8Tyy0mGPfYBoLaVt'
        },
      ),
    );

    for (int i = 0; i < response.data['items'].length; i++) {
      if (addresses.isEmpty) {
        addresses.add(SuggestLocationModel.fromMap(response.data['items'][i]));
      }
      if (!addresses.any((element) =>
          element.address == response.data['items'][i]['address'])) {
        addresses.add(SuggestLocationModel.fromMap(response.data['items'][i]));
      }
    }
    return addresses;
  }

  Future<LocationModel> getLocation(double latitude, double longitude) async {
    Response response = await _dio.get(
        'http://api.openweathermap.org/geo/1.0/reverse?lat=$latitude&lon=$longitude&limit=1&appid=929bc78423be7175b5f56999daac7cf7');

    return LocationModel.fromMap((response.data as List<dynamic>)[0]);
  }

  Future<List<ProductModel>> getCategoriesItems() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      ProductModel(
          id: 1,
          name: 'Speakers',
          imageUrl: 'assets/images/item1.png',
          price: 1600,
          rate: 5,
          inStock: 100),
      ProductModel(
          id: 2,
          name: 'Headphones',
          imageUrl: 'assets/images/item2.png',
          price: 1600,
          rate: 5,
          inStock: 15),
    ];
  }

  final List<ProductModel> _allItems = [
    ProductModel(
        id: 1,
        name: 'Beosound 1',
        imageUrl: 'assets/images/item3.png',
        price: 1600,
        rate: 5,
        inStock: 100),
    ProductModel(
        id: 2,
        name: 'Beolit 18',
        imageUrl: 'assets/images/item4.png',
        price: 550,
        rate: 5,
        inStock: 15),
    ProductModel(
        id: 3,
        name: 'Beosound 2',
        imageUrl: 'assets/images/item3.png',
        price: 1600,
        rate: 5,
        inStock: 100),
    ProductModel(
        id: 4,
        name: 'Beolit 19',
        imageUrl: 'assets/images/item4.png',
        price: 550,
        rate: 5,
        inStock: 15),
    ProductModel(
        id: 5,
        name: 'Beosound 3',
        imageUrl: 'assets/images/item3.png',
        price: 1600,
        rate: 5,
        inStock: 100),
    ProductModel(
        id: 6,
        name: 'Beolit 20',
        imageUrl: 'assets/images/item4.png',
        price: 550,
        rate: 5,
        inStock: 15),
    ProductModel(
        id: 7,
        name: 'Beosound 4',
        imageUrl: 'assets/images/item3.png',
        price: 1600,
        rate: 5,
        inStock: 100),
    ProductModel(
        id: 8,
        name: 'Beolit 21',
        imageUrl: 'assets/images/item4.png',
        price: 550,
        rate: 5,
        inStock: 15),
  ];

  Future<List<ProductModel>> getRecommendedItems() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    return _allItems;
  }

  Future<List<ProductModel>> getPopularItems() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    return _allItems;
  }

  List<OrderModel> _orderList = [];

  Future<List<OrderModel>> getOrderData() async {
    await Future.delayed(const Duration(seconds: 1));
    return _orderList;
  }

  Future<List<ProductModel>> searchItem(String text) async {
    await Future.delayed(const Duration(milliseconds: 300));
    List<ProductModel> foundedItems = [];
    for (ProductModel item in _allItems) {
      if (item.name.toLowerCase().contains(text.toLowerCase())) {
        foundedItems.add(item);
      }
    }
    return foundedItems;
  }

  Future<void> changeOrderData(List<OrderModel> orderList) async {
    await Future.delayed(const Duration(seconds: 1));
    _orderList = orderList;
  }
}
