import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import 'style/colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    Key? key,
    this.isDismissible = false,
  }) : super(key: key);

  final bool isDismissible;

  @override
  Widget build(BuildContext context) {
    String currentLang = context.watch<AppProvider>().locale;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 8),
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Palette.primaryColor),
          ),
          Text(
            currentLang.isEmpty
                ? 'Loading'
                : (currentLang != 'ar' ? 'Loading' : 'تحميل'),
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
