import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ui_ecommerce/CBC/models/Account.dart';
import 'package:ui_ecommerce/CBC/models/AllStore.dart';
import 'package:ui_ecommerce/CBC/models/CallCenter.dart';
import 'package:ui_ecommerce/CBC/models/CardAbout.dart';
import 'package:ui_ecommerce/CBC/models/CardSales.dart';
import 'package:ui_ecommerce/CBC/models/CardType.dart';
import 'package:ui_ecommerce/CBC/models/Category.dart';
import 'package:ui_ecommerce/CBC/models/City.dart';
import 'package:ui_ecommerce/CBC/models/Comp.dart';
import 'package:ui_ecommerce/CBC/models/Discount.dart';
import 'package:ui_ecommerce/CBC/models/Message.dart';
import 'package:ui_ecommerce/CBC/models/Qr.dart';
import 'package:ui_ecommerce/CBC/models/Store.dart';
import 'package:ui_ecommerce/CBC/models/StoreModel.dart';
import 'package:ui_ecommerce/CBC/models/subCity.dart';
import 'package:http_parser/http_parser.dart';
import '../models/CardPriceModel.dart';
import '../models/CategoryMapModel.dart';
import '../models/LangStoresModel.dart';
import '../models/OffersModel.dart';
import '../models/RecentlyDiscount.dart';
import '../models/ShoppingModel.dart';
import '../models/Slider.dart';

class RemoteServices {
  static var client = http.Client();
  static var baseUrl = 'https://89.116.110.51:3000/cbc/api/v1/';
  static var baseUrlV2 = 'https://89.116.110.51:3300/cbc/api/v2/';
  // https://89.116.110.51:3300/cbc/api/v2/getOffers?itemsPerPage=10&page=1&sortBy=discount&orderBy=desc&pinStatus=
//Login
// fetch recently discounts
  //addOrderBuy
  static Future<String> addOrderBuy(
      name, phone, city, area, addressRecive, comp, type) async {
    // https://89.116.110.51:3300/cbc/api/v2/AddCardRequest

    /*
        {"FullName":"frgrg" ,
         "type":55 ، سعر البطاقة
        , "institution":543,  = المؤسسة
        "phoneNmuber":8533 ,
        "address":99955 ,
        "gov":12 , المحافطة
        "area":22, المنطقة
        "date":33958,
        }
        */
    // https://89.116.110.51:3300/cbc/api/v2/AddCardRequest
    var endpoint = 'AddCardRequest';
    var body = jsonEncode({
      'FullName': name,
      'phoneNmuber': phone,
      'gov': city,
      'address': addressRecive,
      'area': area,
      'institution': comp,
      'card_id': type
    });
    // var body = jsonEncode({
    //   'FullName': name,
    //   'phoneNmuber': phone,
    //   'gov': city,
    //   'address': address,
    //   'nearPoint': nearPoint,
    //   'comp': comp,
    //   'card_id': type
    // });
    /*
     {
     "FullName":"frgrg" ,
      "card_id":55 ,  ==type
     "phoneNmuber":8533 ,
     "institution":543, ==comp
     "address":99955 ,
     "gov":12 , ==city
     "area":22,
    
     }
    */

    print('\n');
    print('=========-----------------=================');
    print('The Data of Card $body');
    print('\n');
    try {
      var response = await http.post(
        Uri.parse(baseUrlV2 + endpoint),
        body: body,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        var jsonData = response.body;
        print('\n');
        print('=========---------200--------=================');
        print('The Data of Card ${response.body}');
        print('\n');
        return jsonData;
      } else {
        print('\n');
        print('=========-----------------=================');
        print('The Data of Card Error');
        print('\n');
        String rawJson =
            '{"message":"An unexpected error occurred","Status_code":500}';
        return rawJson;
      }
    } catch (e) {
      print('\n');
      print('=========-----------------=================');
      print('The Data of Card $e');
      print('\n');
      String rawJson =
          '{"message":"An unexpected error occurred","Status_code":500}';
      return rawJson;
    }
  }

  static Future<List<RecentlyDiscount>?> fetchDiscountRecently(
      String page) async {
    // var endpoint = 'getDiscountrecently';
    var endpoint =
        'getDiscountrecently?itemsPerPage=20&page=$page&sortBy=id&orderBy=desc';
    // New Api
    // https://89.116.110.51:3300/cbc/api/v2/getDiscountrecently?itemsPerPage=10&page=1&sortBy=id&orderBy=desc
    try {
      var response = await client.get(Uri.parse(baseUrlV2 + endpoint));
      // https://89.116.110.51:3000/cbc/api/v1/getDiscountrecently
      if (response.statusCode == 200) {
        // var jsonData = response.body;
        final jsonData = json.decode(response.body);
        final extracted = jsonData['DataOfTable'];
        List<RecentlyDiscount> stories =
            recentlDiscountFromJsonDecode(extracted);
        return stories;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<OffersModel>?> fetchOffersSection(
      String page, String orderBy) async {
    final String endpoint =
        'getOffers?itemsPerPage=20&page=$page&sortBy=discount&orderBy=$orderBy&pinStatus=';

    // String url = 'https://89.116.110.51:3300/cbc/api/v2/getDiscountrecently';
    // String url =
    //     'https://89.116.110.51:3300/cbc/api/v2/getDiscountHighest?itemsPerPage=25&page=2&orderBy=desc';
    // 'https://89.116.110.51:3300/cbc/api/v2/getDiscountHighest?itemsPerPage=25&page=2&orderBy=desc';
    // String url =
    //     'https://89.116.110.51:3300/cbc/api/v2/getDiscountHighest?itemsPerPage=25&page=$page&orderBy=$orderBy';

    try {
      var response = await client.get(Uri.parse(baseUrlV2 + endpoint));

      // var response = await client.get(Uri.parse(baseUrl + endpoint));
      //Original // https://89.116.110.51:3000/cbc/api/v1/getDiscountrecently
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final extracted = jsonData['DataOfTable'];

        List<OffersModel> stories = offerModelFromJson(extracted);
        return stories;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<ShoppingModel>?> fetchShoppingModel(
    String page,
    String typeFilter,
    String descAsc,
    String txtSearch,
    String numbrItem,
    String userId,
    String getUserFavorite,
  ) async {
    final String endPoint =
        'getShopping?q=$txtSearch&itemsPerPage=$numbrItem&page=$page&sortBy=$typeFilter&orderBy=$descAsc&userId=$userId&favoriteStatus=$getUserFavorite';

    try {
      var response = await client.get(Uri.parse(baseUrlV2 + endPoint));

      // print('\n');
      // print('===============-------------------====================454=====');
      // print('\n');
      // print('The URL Shoping is ${baseUrlV2 + endPoint}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final extracted = jsonData['DataOfTable'];

        List<ShoppingModel> stories = shoppingModelFromJson(extracted);
        return stories;
      } else {
        // print('\n');
        // print('=============================');
        // print(
        // print('\n');
        return null;
      }
    } catch (e) {
      print('\n');
      print('=============================');
      print('fetchShoppingModel Error response.statusCode  == ${e}');
      print('\n');
      return null;
    }
  }

  static Future<String> addShopingToFavoriteData(
    String userId,
    String storeId,
  ) async {
    const String endPoint = 'Favorite';
    // https://89.116.110.51:3300/cbc/api/v2/Favorite
    // 'getShopping?q=$txtSearch&itemsPerPage=$numbrItem&page=$page&sortBy=$typeFilter&orderBy=$descAsc&userId=$userId';
    try {
      /*
      body should be like this {"userId":2222,"savedId":9785}
      */

      final body = {
        'userId': userId,
        'savedId': storeId,
      };

      final jsonBody = json.encode(body);

      var response = await client.post(
        Uri.parse(baseUrlV2 + endPoint),
        body: jsonBody,
        headers: {'Content-Type': 'application/json'},
      );
      print('\n');
      print('=============================');
      print('\n');
      print('Url Add Favorite is ${baseUrlV2 + endPoint}');
      print('\n');
      print('The User Id = $userId And Store id is $storeId');
      print('\n');
      print('=============================');
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('\n');
        print('=============================');
        print('Add To Favorite is $jsonData');
        print('\n');
        // final extracted = jsonData['DataOfTable'];

        return 'success';
      } else {
        return 'wrong';
      }
    } catch (e) {
      print('\n');
      print('=============================');
      print('Add Shoping Favorite Error response.statusCode  == ${e}');
      print('\n');
      return 'wrong';
    }
  }

  static Future<String> deleteShopingToFavoriteData(
    String userId,
    String storeId,
  ) async {
    const String endPoint = 'Favorite';
    try {
      /*
      body should be like this {"userId":2222,"savedId":9785}
      */

      final body = {
        'userId': userId,
        'savedId': storeId,
      };

      final jsonBody = json.encode(body);

      var response = await client.delete(
        Uri.parse(baseUrlV2 + endPoint),
        body: jsonBody,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('\n');
        print('=============================');
        print('Delete Shoping   Favorite is $jsonData');
        print('\n');
        // final extracted = jsonData['DataOfTable'];

        return 'success';
      } else {
        return 'wrong';
      }
    } catch (e) {
      print('\n');
      print('=============================');
      print('Delete Shoping  Error response.statusCode  == ${e}');
      print('\n');
      return 'wrong';
    }
  }

  static Future<List<LangStoresModel>?> fetchLatLangStoresData(
    String latitude,
    String longitude,
    String? categorySearch,
  ) async {
    // String url =
    //     'https://89.116.110.51:3300/cbc/api/v2/GetAllStories?q=$txtSearch&itemsPerPage=$numbrItem&page=$page&sortBy=$typeFilter&orderBy=$descAsc&subCity=';
    // baseUrlV2 = 'https://89.116.110.51:3300/cbc/api/v2/';
    // final String endPoint =
    //     'getShopping?q=$txtSearch&itemsPerPage=$numbrItem&page=$page&sortBy=$typeFilter&orderBy=$descAsc&pinStatus=';

    /*
    https://89.116.110.51:3300/cbc/api/v2/getBranches?itemsPerPage=10&page=1&sortBy=id&orderBy=desc&lat=33.3045585&lng=44.3421706
    */

    final String endPoint =
        'getBranches?itemsPerPage=10000&page=1&sortBy=id&orderBy=desc&lat=$latitude&lng=$longitude&categorySearch=$categorySearch';
    // lat =33.3045585
    // lang =44.3421706
    // 'getBranches?itemsPerPage=10000&page=1&sortBy=id&orderBy=desc&lat=33.3045585&lng=44.3421706&categorySearch=$categorySearch';

    try {
      print('\n');
      print('The Url is ${baseUrlV2 + endPoint}');
      print('\n');
      var response = await client.get(Uri.parse(baseUrlV2 + endPoint));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final extracted = jsonData['DataOfTable'];
        // print('\n');
        // print('====================================');
        // print('\n');
        // print('Branched is $extracted');
        // print('\n');

        List<LangStoresModel> stories =
            LangStoresModelFromJsonDecode(extracted);
        return stories;
      } else {
        // print('\n');
        // print('=============================');
        // print(
        // print('\n');
        return null;
      }
    } catch (e) {
      print('\n');
      print('=============================');
      print('LangStoresModel Error response.statusCode  == ${e}');
      print('\n');
      return null;
    }
  }

  static Future<List<CategoryMapModel>?> fetchCategoryForLatLongData(
    String page,
  ) async {
    //  https://89.116.110.51:3300/cbc/api/v2/getCategories?itemsPerPage=10&page=1&orderby=asc
    final String endPoint =
        'getCategories?itemsPerPage=1000&page=$page&orderby=asc';

    try {
      var response = await client.get(Uri.parse(baseUrlV2 + endPoint));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final extracted = jsonData['DataOfTable'];

        List<CategoryMapModel> stories =
            categoryMapModelFromJsonDecode(extracted);
        return stories;
      } else {
        // print('\n');
        // print('=============================');
        // print(
        // print('\n');
        return null;
      }
    } catch (e) {
      print('\n');
      print('=============================');
      print('fetchCategoryForLatLongData Error response.statusCode  == ${e}');
      print('\n');
      return null;
    }
  }

  //fetch Comps
  static Future<List<Comp>?> fetchComps() async {
    var endpoint = 'getAllComps';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<Comp> items = compFromJson(jsonData);
        return items;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //fetch Messages
  static Future<List<Message>?> fetchMessages() async {
    var endpoint = 'getMessages';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<Message> items = messageFromJson(jsonData);
        return items;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //fetch Sub City
  static Future<List<SubCity>?> fetchSubCity(id) async {
    var endpoint = 'getSubCity/${id}';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<SubCity> list = subCityFromJson(jsonData);
        return list;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //fetch categories
  static Future<List<Category>?> fetchCategories(id) async {
    var endpoint = 'getCategory/${id}';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<Category> list = categoryFromJson(jsonData);
        return list;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //fetch highest Discount
  static Future<List<Discount>?> fetchDiscountHighest(
      String page, String isDinnar) async {
    // var endpoint = 'getDiscountHighest';
    // var endpoint = 'getDiscountHighest?itemsPerPage=20&page=$page&orderBy=desc';
    var endpoint =
        // https://89.116.110.51:3300/cbc/api/v2/getDiscountHighest?itemsPerPage=10&page=1&orderBy=desc&sortBy=final_discount&discountWithoutPercent=true
        'getDiscountHighest?itemsPerPage=20&page=$page&orderBy=desc&sortBy=final_discount&discountWithoutPercent=$isDinnar';
    // 'getdiscountHighest?itemsPerPage=20&page=$page&orderby=asc&discountWithoutPercent=$isDinnar';
    try {
      var response = await client.get(Uri.parse(baseUrlV2 + endpoint));

      //
      if (response.statusCode == 200) {
        // var jsonData = response.body;
        final jsonData = json.decode(response.body);
        final extracted = jsonData['DataOfTable'];
        List<Discount> stories = discountFromJsonDecode(extracted);
        // print('loooad');
        return stories;
      } else {
        print('errror');
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //fetch highest Discount
  static Future<List<CardPriceModel>?> fetchCardPriceData() async {
    var endpoint = 'getCardTypes';
    // https://89.116.110.51:3300/cbc/api/v2/getCardTypes
    try {
      var response = await client.get(Uri.parse(baseUrlV2 + endpoint));
      //
      if (response.statusCode == 200) {
        // var jsonData = response.body;
        final jsonData = json.decode(response.body);
        // final extracted = jsonData['DataOfTable'];
        List<CardPriceModel> stories = cardPriceFromJson(jsonData);

        // print('loooad');
        return stories;
      } else {
        print('errror');
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //fetch cities
  static Future<List<City>?> fetchCities() async {
    var endpoint = 'getAllCities';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<City> cities = cityFromJson(jsonData);
        return cities;
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
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<SliderBar> sliders = sliderFromJson(jsonData);
        // print('\n');
        // print('-----------------------------');
        // print('The Result Reserach');
        // print('-----------------------------');
        // print('\n');
        return sliders;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<Store?> fetchStoriesBySubCity(subCity) async {
    var endpoint = 'getStoresBySubCity/${subCity}';
    var response = await client.get(Uri.parse(baseUrl + endpoint));
    // print(response.body);
    if (response.statusCode == 200) {
      // print(111);
      var jsonData = response.body;
      return storeFromJson(jsonData);
    } else {
      // print(222);
      return null;
    }
  }

  //Fetch Stories From Endpoint (getStories)
  static Future<Store?> fetchStories(cate, city, orderby) async {
    var endpoint = 'getStoriesBy/${cate}/${city}/${orderby}';
    var response = await client.get(Uri.parse(baseUrl + endpoint));
    // print(response.body);
    if (response.statusCode == 200) {
      // print(111);
      var jsonData = response.body;
      Store sliders = storeFromJson(jsonData);
      return sliders;
    } else {
      // print(222);
      return null;
    }
  }

  //Fetch Stories From Endpoint (getStories)
  static Future<List<CategoryAll>?> fetchFilterCategories(orderby, city) async {
    var endpoint = 'getFilterCategories/${city}/${orderby}';
    try {
      // print('\n');
      // print('\n');
      // print('===========================================');
      // print('The City is $city && Orderby is $orderby');
      // print('===========================================');
      // print('\n');
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      // https://89.116.110.51:3000/cbc/api/v1/getFilterCategories/-1/1
      // print(response.body);
      var jsonData = response.body;
      List<CategoryAll> list = categoryAllFromJson(jsonData);
      return list;
    } catch (e) {
      return null;
    }
  }

//Fetch Stories From Endpoint (getStories)
  static Future<StoreModel?> fetchStore(id) async {
    print('\n');
    print('============================');
    print('\n');
    print('The ID Store is $id');
    print('============================');
    var endpoint = 'getStore/$id';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        // print('Raw JSON response: $jsonData'); // Log the raw JSON response
        StoreModel store = storeModelFromJson(jsonData);
        // print('Parsed StoreModel: $store'); // Log the parsed StoreModel
        return store;
      } else {
        // print('Failed to fetch store: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // print('Exception caught: $e');
      return null;
    }
  }

  //Fetch Card About From Endpoint (getCardAbout)
  static Future<CardAbout?> fetchCardAbout() async {
    var endpoint = 'getCardAbout';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        CardAbout cardAbout = cardAboutFromJson(jsonData);
        return cardAbout;
      } else {
        // print('not about');
        return null;
      }
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  //Fetch Card Types From Endpoint (getCardType)
  static Future<CardType?> fetchCardTypes() async {
    var endpoint = 'getCardType';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        CardType cardType = cardTypeFromJson(jsonData);
        return cardType;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //Fetch Card Sales From Endpoint (getCardSales)
  static Future<CardSale?> fetchCardSales() async {
    var endpoint = 'getCardSales';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      // print('saless: ${response.body}');
      if (response.statusCode == 200) {
        // print("on data");
        var jsonData = response.body;
        CardSale? cardSale = cardSaleFromJson(jsonData);
        return cardSale;
      } else {
        // print("out data");
        return null;
      }
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  //Fetch Account From Endpoint (getAccount)
  static Future<List<AccountModel>?> fetchAccount(id) async {
    var endpoint = 'getAccount/${id}';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<AccountModel> account = accountModelFromJson(jsonData);
        return account;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //Fetch CallCenter From Endpoint (getCallCenter)
  static Future<List<CallCenterModel>?> fetchCallCenter() async {
    var endpoint = 'getCallCenter';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<CallCenterModel> callCenter = callCenterModelFromJson(jsonData);
        return callCenter;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //Fetch Qr From Endpoint (getQr)
  static Future<List<QrModel>?> fetchQr() async {
    var endpoint = 'getQr';
    try {
      var response = await client.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        List<QrModel> qr = qrModelFromJson(jsonData);
        return qr;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //filter Stories
  static Future filterStories(String title) async {
    var endpoint = 'filterStories/${title}';
    var response = await client.get(Uri.parse(baseUrl + endpoint));
    // https://89.116.110.51:3000/cbc/api/v1/filterStories

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var items = jsonData;
      return items;
    } else {
      return [];
    }
  }

  static Future<String> uploadImage(
      String imagePath, String userName, String amount, String storeId) async {
    var endpoint = 'uploadFatora'; // Replace with your actual API endpoint

    try {
      var uri = Uri.parse(baseUrl + endpoint);

      // Prepare the file for upload
      var file = await http.MultipartFile.fromPath(
        'image', // Field name on the server
        imagePath,
        contentType: MediaType('image',
            'jpeg'), // Adjust if you're uploading other types of images
      );

      // Create the multipart request
      var request = http.MultipartRequest('POST', uri);

      // Add form fields (title, amount) to the request body
      request.fields['userName'] = userName; // Adding title to the request
      request.fields['amount'] =
          amount.toString(); // Adding amount to the request
      request.fields['storeId'] = storeId; // Adding storeId to the request

      // Add the image file to the request
      request.files.add(file);

      // Send the request
      var response = await request.send();

      // Check the response status code and read the response body
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        // print('Response body: $responseBody');
        return 'Upload successful! Response: $responseBody';
      } else {
        // print(request.fields);
        var errorResponse = await response.stream.bytesToString();
        // print('Error response: $errorResponse');
        return 'Failed to upload image: $errorResponse';
      }
    } catch (e) {
      // print('Error occurred while uploading: $e');
      return 'Error occurred while uploading: $e';
    }
  }

  static Future<String> rateStore(
      String storeId, String userId, String rate) async {
    var endpoint = 'RateStore';
    var body = jsonEncode({
      'storeId': storeId,
      'userName': userId,
      'rate': rate,
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
        String rawJson =
            '{"message":"An unexpected error occurred","Status_code":500}';
        return rawJson;
      }
    } catch (e) {
      String rawJson =
          '{"message":"An unexpected error occurred","Status_code":500}';
      return rawJson;
    }
  }
}
