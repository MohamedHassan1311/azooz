// import '../../../common/routes/app_router_control.dart';
// import '../../../common/style/colors.dart';
// import 'package:flutter/material.dart';

// class VendorAppBarWidget extends StatelessWidget {
//   final bool? isFavorite;
//   final bool? inFavorites;
//   final String? title;
//   final bool? isBackButton;
//   final Function()? onPressed;
//   final Function()? onPressedFavorite;

//   const VendorAppBarWidget({
//     Key? key,
//     this.isFavorite = false,
//     this.isBackButton = true,
//     this.inFavorites,
//     this.onPressed,
//     this.onPressedFavorite,
//     required this.title,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       centerTitle: true,
//       automaticallyImplyLeading: false,
//       title: Text(
//         title!,
//         style: Theme.of(context).textTheme.subtitle1,
//       ),
//       leading: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (isFavorite == true)
//             IconButton(
//               splashRadius: 30,
//               onPressed: onPressedFavorite,
//               icon: Icon(
//                 inFavorites == true
//                     ? Icons.favorite
//                     : Icons.favorite_border_outlined,
//                 color: Palette.secondaryLight,
//               ),
//             ),
//           // IconButton(
//           //   splashRadius: 30,
//           //   onPressed: () {},
//           //   icon: const Icon(
//           //     Icons.star,
//           //     color: Colors.amber,
//           //   ),
//           // ),
//         ],
//       ),
//       actions: [
//         if (isBackButton == true) ...[
//           IconButton(
//             onPressed: onPressed ??
//                 () {
//                   Navigator.of(context).pop();
//                 },
//             icon: const Icon(
//               Icons.arrow_forward_ios,
//               color: Palette.secondaryLight,
//             ),
//           ),
//         ],
//       ],
//     );
//     //   Row(
//     //   // crossAxisAlignment: CrossAxisAlignment.center,
//     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //   children: [
//     //     if (isBackButton == true) ...[
//     //       IconButton(
//     //         onPressed: () => routerPop(context),
//     //         icon: const Icon(
//     //           Icons.arrow_forward_ios,
//     //           color: Palette.kBlack,
//     //         ),
//     //       ),
//     //     ],
//     //     Text(
//     //       title!,
//     //       style: Theme.of(context).textTheme.subtitle1,
//     //     ),
//     //     if (isFavorite == true) ...[
//     //       IconButton(
//     //         onPressed: () {},
//     //         icon: const Icon(
//     //           Icons.favorite_border_outlined,
//     //           color: Palette.kBlack,
//     //         ),
//     //       ),
//     //     ],
//     //   ],
//     //   // enableFeedback: true,
//     //   // title: Center(
//     //   //   child: Text(
//     //   //     title!,
//     //   //     style: Theme.of(context).textTheme.subtitle1,
//     //   //   ),
//     //   // ),
//     //   // trailing: isBackButton == true
//     //   //     ? IconButton(
//     //   //         onPressed: () => routerPop(context),
//     //   //         icon: const Icon(
//     //   //           Icons.arrow_forward_ios,
//     //   //           color: Palette.kBlack,
//     //   //         ),
//     //   //       )
//     //   //     : const Text(''),
//     //   // leading: isFavorite == true
//     //   //     ? IconButton(
//     //   //         onPressed: () {},
//     //   //         icon: const Icon(
//     //   //           Icons.favorite_border_outlined,
//     //   //           color: Palette.kBlack,
//     //   //         ),
//     //   //       )
//     //   //     : const Text(''),
//     // );
//   }
// }
