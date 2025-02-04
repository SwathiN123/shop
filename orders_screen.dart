import 'package:flutter/material.dart';
import '/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/orders';

  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isloading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isloading = false;
      });

      await Provider.of<Orders>(context, listen: false).fetchAndSetOrder();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yours Orders'),
      ),
      drawer: const AppDrawer(),
      body: _isloading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: ordersData.orders.length,
              itemBuilder: (context, index) =>
                  OrderItem(ordersData.orders[index]),
            ),
    );
  }
}
