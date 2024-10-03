import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/product_detail_screen.dart';
import '../screens/splash_screen.dart';

import './screens/cart_screen.dart';

import 'package:provider/provider.dart';

import './providers/products.dart';
import './providers/cart.dart';

import 'providers/orders.dart';
import 'providers/auth.dart';
import './screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';

Future<bool> checkuserlogin() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool isLoggedIn = pref.getBool('userLoggedIn') ?? false;
  return isLoggedIn;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Myshop());
}

class Myshop extends StatelessWidget {
  const Myshop();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: checkuserlogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(body: CircularProgressIndicator()),
            );
          } else {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => Auth()),
                ChangeNotifierProvider(
                  create: (context) => Products(),
                ),
                ChangeNotifierProvider(
                  create: (context) => Cart(),
                ),
                ChangeNotifierProvider(
                  create: (context) => Orders(),
                ),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: "Myshop",
                theme: ThemeData(
                  primaryColor: Colors.deepOrange,
                  primarySwatch: Colors.deepOrange,
                  fontFamily: "Lato",
                ),
                home: snapshot.data == true
                    ? const Splashscreen()
                    : const AuthScreen(),
                routes: {
                  ProductDetailScreen.routeName: (context) =>
                      const ProductDetailScreen(),
                  CartScreen.routeName: (context) => CartScreen(),
                  OrderScreen.routeName: (context) => const OrderScreen(),
                  UserProductsScreen.routeName: (context) =>
                      const UserProductsScreen(),
                  EditProductScreen.routeName: (context) => EditProductScreen(),
                },
              ),
            );
          }
        });
  }
}
