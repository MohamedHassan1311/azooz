import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../common/style/colors.dart';
import 'drawer_head_widget.dart';
import 'drawer_items_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
    required this.zoomDrawerController,
  }) : super(key: key);
  final ZoomDrawerController zoomDrawerController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => zoomDrawerController.toggle!(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              // end: AlignmentDirectional.bottomCenter,
              end: Alignment.bottomCenter,

              colors: [
                Palette.primaryColor,
                Palette.primaryColor,
                Palette.secondaryLight,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 12, top: 40),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeadWidget(),
                DrawerItemsWidget(
                  zoomDrawerController: zoomDrawerController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
