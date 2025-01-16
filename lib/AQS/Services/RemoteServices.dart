import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ui_ecommerce/AQS/models/Bill.dart';
import 'package:ui_ecommerce/AQS/models/Category.dart';
import 'package:ui_ecommerce/AQS/models/Product.dart';
import 'package:ui_ecommerce/AQS/models/ProductPage.dart';
import 'package:ui_ecommerce/AQS/models/Sale.dart';
import 'package:ui_ecommerce/AQS/models/SubCategory.dart';
import '../models/Slider.dart';
class RemoteServices {
  static var client = http.Client();
  static var baseUrl = 'https://89.116.110.51:3000/aqs/api/v1/';
  static Future deleteAccount(name , user_id) async {
    var endpoint = 'deleteAccount';
    var body = jsonEncode({'name': name , 'user_id': user_id.toString()});
    try {
      print('err 1');
      var response = await client.post(Uri.parse(baseUrl + endpoint),

        body:body,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var jsonData = response.body;
        return jsonData;
      } else {
        print('err');
        String rawJson = '{"message":"An unexpected error occurred","Status_code":500}';
        return rawJson;
      }
    } catch (e) {
      print('errror 3');
      String rawJson = '{"message":"An unexpected error occurred","Status_code":500}';
      return rawJson;
    }
  }
//Login

  static Future login(phone , password) async {
    var endpoint = 'login';
    var body = jsonEncode({'phone': phone , 'password': password});
    try {
      var response = await client.post(Uri.parse(baseUrl + endpoint),
        body:body,
        headers: {'Content-Type': 'application/json'},
      );
      print(response.body);
      if (response.statusCode == 200) {
        var jsonData = response.body;
        return jsonData;
      } else {
        String rawJson = '{"message":"An unexpected error occurred","Status_code":500}';
        return rawJson;
      }
    } catch (e) {
      String rawJson = '{"message":"An unexpected error occurred","Status_code":500}';
      return rawJson;
    }
  }

  //Register User
  static Future register(name , phone , city , address , password) async {
    var endpoint = 'register';
    var body = jsonEncode({
      'name': name ,
      'phone': phone ,
      'city': city,
      'address': address,
      'password': password
    });
    try {
      var response = await client.post(Uri.parse(baseUrl + endpoint),
        body:body,
        headers: {'Content-Type': 'application/json'},
      );
      print(response.body);
      if (response.statusCode == 200) {
        var jsonData = response.body;
        return jsonData;
      } else {
        String rawJson = '{"message":"An unexpected error occurred","Status_code":500}';
        return rawJson;
      }
    } catch (e) {
      String rawJson = '{"message":"An unexpected error occurred","Status_code":500}';
      return rawJson;
    }
  }
  //Fetch Products From Endpoint (getProducts)
  static Future<List<Product>?> fetchProducts() async {
    var endpoint = 'getProducts';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<Product> products = productFromJson(jsonData);
        return products;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future filterProducts(String title) async {
    var endpoint = 'filterProducts/${title}';
    var response = await client.get(Uri.parse(baseUrl + endpoint));
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var items = jsonData;
      return items;
    } else {
      return [];
    }
  }

  //Fetch Items Recently From Endpoint (getProduct)
  static Future<List<Product>?> fetchProductsRecently() async {
    var endpoint = 'getProductsRecently';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<Product> products = productFromJson(jsonData);
        return products;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  //add new bill To Endpoint (addBill)
  static Future<String> addBill(String name, String phone, String city, String address, int price, int delivery, List<Map<String, dynamic>> items, user_id) async {
    var endpoint = 'addBill';
    var body = jsonEncode({
      'name': name,
      'phone': phone,
      'city': city,
      'address': address,
      'price': price,
      'delivery': delivery,
      'items': items,
      'user_id':user_id
    });
    try {
      var response = await http.post(
        Uri.parse(baseUrl + endpoint),
        body: body,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        var jsonData = response.body;
        return jsonData;
      } else {
        String rawJson = '{"message":"An unexpected error occurred","Status_code":500}';
        return rawJson;
      }
    } catch (e) {
      String rawJson = '{"message":"An unexpected error occurred","Status_code":500}';
      return rawJson;
    }
  }
  //Fetch Bills By Id From Endpoint (getBills)
  static Future<List<Bill>?> fetchBills(id) async {
    var endpoint = 'getBills/${id}';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<Bill> bills = billFromJson(jsonData);
        return bills;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  //Fetch Bills By Id From Endpoint (getBills)
  static Future<List<Bill>?> fetchLatestBills(id) async {
    var endpoint = 'getBillsLastest/${id}';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<Bill> bills = billFromJson(jsonData);
        return bills;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  //
  static Future<List<Sale>?> getBill(id) async {
    var endpoint = 'getBill/${id}';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<Sale> Sales = saleFromJson(jsonData);
        return Sales;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  //Fetch Item By Id From Endpoint (getProduct)
  static Future<ProductPage?> fetchProductone(id) async {
    var endpoint = 'getProduct/${id}';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        ProductPage products = productPageFromJson(jsonData);
        return products;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  //Fetch Items By Category From Endpoint (getProductByCategory)
  static Future<List<Product>?> fetchProductByCate(id) async {
    var endpoint = 'getProductByCategory/${id}';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<Product> products = productFromJson(jsonData);
        return products;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //Fetch Sliders From Endpoint (getSliders)
  static Future<List<SliderBar>?> fetchSliders() async {
    var endpoint = 'getSliders';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      print('slider ${response.body}');
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<SliderBar> sliders = sliderFromJson(jsonData);
        return sliders;
      } else {
        print('errro slider');
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //Fetch Categories From Endpoint (getCategories)
  static Future<List<CategoryModel>?> fetchCategories() async {
    var endpoint = 'getCategories';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<CategoryModel> categories = categoryModelFromJson(jsonData);
        return categories;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  //fetchSubCategories
  static Future<List<SubCategory>?> fetchSubCategories(id) async {
    var endpoint = 'getSubCategoryByCategory/${id}';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<SubCategory> categories = subCategoryFromJson(jsonData);
        return categories;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}