import 'package:flutter/material.dart';

import '../../widget/home/driver/driver_widget.dart';

class DriverScreen extends StatelessWidget {
  static const routeName = 'driver';

  const DriverScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(
          height: 20,
        ),
        Expanded(child: DriverWidget()),
      ],
    );
  }
}
