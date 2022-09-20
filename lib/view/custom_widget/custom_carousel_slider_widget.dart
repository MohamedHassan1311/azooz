import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../common/style/colors.dart';
import 'custom_cached_image_widget.dart';

class CustomCarouselSliderWidget extends StatefulWidget {
  final List? list;
  final CarouselController? controller;
  int? currentIndex;
  final bool? withDots;
  final double? aspectRatio;

  /// It means List of Strings of Images - It doesn't mean List of another field called ImageUrl and shows its Images
  final bool isPureList;

  CustomCarouselSliderWidget({
    Key? key,
    required this.list,
    required this.controller,
    required this.currentIndex,
    this.withDots = false,
    this.aspectRatio = 16 / 7,
    this.isPureList = false,
  }) : super(key: key);

  @override
  CustomCarouselSliderWidgetState createState() =>
      CustomCarouselSliderWidgetState();
}

class CustomCarouselSliderWidgetState
    extends State<CustomCarouselSliderWidget> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        CarouselSlider.builder(
          // itemCount: widget.list!.isEmpty ? 1 : widget.list?.length,
          itemCount: widget.list == null ? 0 : widget.list?.length,
          itemBuilder: (context, index, pageViewIndex) =>
              CachedImageBorderRadius(
            imageUrl: widget.isPureList == false
                ? widget.list![index].imageURL
                : widget.list!.isEmpty
                    ? ''
                    : widget.list![index],
            borderRadius: 5,
            width: screenWidth,
            boxFit: BoxFit.fill,
            onTap: () {},
          ),
          options: CarouselOptions(
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 1500),
              autoPlayCurve: Curves.fastOutSlowIn,
              disableCenter: false,
              enlargeCenterPage: true,
              aspectRatio: widget.aspectRatio!,
              scrollDirection: Axis.horizontal,
              scrollPhysics: const AlwaysScrollableScrollPhysics(),
              onPageChanged: (index, reason) {
                setState(() {
                  widget.currentIndex = index;
                });
              }),
        ),
        if (widget.withDots == true) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.list!.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => widget.controller!.animateToPage(entry.key),
                child: Container(
                  width: widget.currentIndex == entry.key ? 7 : 6,
                  height: widget.currentIndex == entry.key ? 7 : 6,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 4.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Palette.kBadgeColor
                        : widget.currentIndex == entry.key
                            ? Palette.kAccent
                            : Palette.primaryColor,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
