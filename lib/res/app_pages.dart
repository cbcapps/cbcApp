import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/views/AllCategories.dart';
import 'package:ui_ecommerce/CBC/views/Cities.dart';
import 'package:ui_ecommerce/CBC/views/HighestStories.dart';
import 'package:ui_ecommerce/CBC/views/Home.dart';
import 'package:ui_ecommerce/CBC/views/Categories.dart';
import 'package:ui_ecommerce/AQS//Bindings/Billing_bindings.dart';
import 'package:ui_ecommerce/AQS/Bindings/Checkout_bindings.dart';
import 'package:ui_ecommerce/AQS/Bindings/ItemBilling_bindings.dart';
import 'package:ui_ecommerce/AQS/Bindings/RecentlyProducts_bindings.dart';
import 'package:ui_ecommerce/AQS/Bindings/Cart_bindings.dart';
import 'package:ui_ecommerce/AQS/Bindings/Category_bindings.dart';
import 'package:ui_ecommerce/AQS/Bindings/Home_bindings.dart';
import 'package:ui_ecommerce/AQS/Bindings/Landing_bindings.dart';
import 'package:ui_ecommerce/AQS/Bindings/Product_bindings.dart';
import 'package:ui_ecommerce/AQS/Bindings/Products_bindings.dart';
import 'package:ui_ecommerce/AQS/middleware/auth_middleware.dart';
import 'package:ui_ecommerce/AQS/views/Billing.dart';
import 'package:ui_ecommerce/AQS/views/Checkout.dart';
import 'package:ui_ecommerce/AQS/views/Item_Billing.dart';
import 'package:ui_ecommerce/AQS/views/RecentlyProducts.dart';
import 'package:ui_ecommerce/AQS/views/Cart.dart';
import 'package:ui_ecommerce/AQS/views/Categories.dart';
import 'package:ui_ecommerce/AQS/views/Home.dart';
import 'package:ui_ecommerce/AQS/views/Landing.dart';
import 'package:ui_ecommerce/AQS/views/Login.dart';
import 'package:ui_ecommerce/AQS/views/ProductPage.dart';
import 'package:ui_ecommerce/AQS/views/Products.dart';
import 'package:ui_ecommerce/CBC/views/RecentlyStories.dart';
import 'package:ui_ecommerce/Togather/views/landing.dart';
final List<GetPage> appPages = [
  GetPage(name: '/togather', page: ()=>  Landing_togather() ),
  GetPage(name: '/home_cbc', page: ()=>  Home_cbc()),
  GetPage(name: '/', page: ()=>  Login() ,binding: Landing_bindings(),middlewares: [auth_middleware()]),
  GetPage(name: '/product', page: ()=>  ProductPage() ,binding: Product_bindings()),
  GetPage(name: '/landing', page: ()=>  Landing() ,binding: Landing_bindings()),
  GetPage(name: '/homeAQS', page: ()=>  Home_AQS() , binding: Home_Bindings()),
  GetPage(name: '/bestProducts', page: ()=>RecentlyProducts() , binding: RecentlyProducts_bindings()),
  GetPage(name: '/cart', page: ()=>CartPage() , binding: Cart_bindings()),
  GetPage(name: '/categories', page: ()=>Categories() , binding: Category_bindings()),
  GetPage(name: '/products', page: ()=>Products() , binding: Products_bindings()),
  GetPage(name: '/checkout', page: ()=>Checkout() , binding: Checkout_bindings()),
  GetPage(name: '/billing', page: ()=>Billing() , binding: Billing_bindings()),
  GetPage(name: '/Item_Billing', page: ()=>Item_Billing() , binding: ItemBilling_bindings()),
  GetPage(name: '/cities', page: ()=>Cities_view()),
  //cbc
  GetPage(name: '/categories_cbc', page: ()=>CategoriesView()),
  GetPage(name: '/recentlyStories', page: ()=>RecentlyStories()),
  GetPage(name: '/HighestStories', page: ()=>HighestStories()),
  GetPage(name: '/AllCategories', page: ()=>AllCategories()),
];
