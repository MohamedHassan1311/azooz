import 'package:azooz/view/screen/home/orders_history_screen.dart';
import 'package:flutter/material.dart';

import 'orders_history.dart';

class OrdersHistoryPage extends StatelessWidget {
  const OrdersHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: _CustomOrderWidget(
                buttonStyle: OrderButtonStyle(
                  backgroundColor: const Color.fromARGB(255, 234, 255, 235),
                  icon: const Icon(
                    Icons.directions_car_filled,
                    color: Colors.green,
                    size: 70,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MeshoarHistoryScreen(),
                      ),
                    );
                  },
                  title: Text(
                    "مشوار",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: _CustomOrderWidget(
                buttonStyle: OrderButtonStyle(
                  backgroundColor: const Color.fromARGB(255, 233, 246, 255),
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.blue,
                    size: 70,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Scaffold(
                          body: OrdersHistoryScreen(),
                        ),
                      ),
                    );
                  },
                  title: Text(
                    "طلبات",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderButtonStyle {
  final void Function() onTap;
  final Widget title;
  final Icon icon;
  final Color backgroundColor;

  OrderButtonStyle({
    required this.onTap,
    required this.title,
    required this.icon,
    required this.backgroundColor,
  });
}

class _CustomOrderWidget extends StatelessWidget {
  final OrderButtonStyle buttonStyle;

  const _CustomOrderWidget({
    Key? key,
    required this.buttonStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonStyle.onTap,
      child: Container(
        // width: MediaQuery.of(context).size.width / 2.3,
        height: 150,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: buttonStyle.backgroundColor,
          // color: const Color(0xFFDEFAE9),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buttonStyle.icon,
            buttonStyle.title,
          ],
        ),
      ),
    );
  }
}
