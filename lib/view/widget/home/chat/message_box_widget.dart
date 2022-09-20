import '../../../../common/config/app_status.dart';
import '../../../../common/config/assets.dart';
import '../../../../common/style/colors.dart';
import '../../../../common/style/dimens.dart';
import '../../../custom_widget/custom_cached_image_widget.dart';
import 'package:flutter/material.dart';

class MessageBoxWidget extends StatelessWidget {
  final bool isMe;
  final String? message;
  final String? date;
  final bool? withLogo;
  final int? typeID;
  final bool? isRead;

  const MessageBoxWidget({
    Key? key,
    required this.isMe,
    this.message,
    this.date,
    this.withLogo = false,
    this.typeID,
    this.isRead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isMe) {
      return Padding(
        padding: edgeInsetsSymmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: Palette.kLightBlue.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: edgeInsetsAll(13.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      typeID == AppStatus.mediaType['Text']
                          ? Text(
                              message.toString(),
                              style: const TextStyle(fontSize: 14),
                            )
                          : sizedBox(
                              child: CachedImageBorderRadius(
                                imageUrl: message.toString(),
                                boxFit: BoxFit.cover,
                                borderRadius: 0,
                              ),
                              width: 140,
                              height: 140,
                            ),
                      Text(
                        date.toString(),
                        style: const TextStyle(fontSize: 10),
                      ),
                      // const SizedBox(height: 5),
                      // isRead == true
                      //     ? const Icon(
                      //         FluentIcons.checkmark_12_regular,
                      //         size: 18,
                      //         color: Palette.primaryColor,
                      //       )
                      //     : const SizedBox(
                      //         width: 14,
                      //         height: 14,
                      //         child: Center(
                      //           child: CircularProgressIndicator(
                      //             strokeWidth: 2.0,
                      //             valueColor: AlwaysStoppedAnimation(
                      //               Color.fromARGB(255, 40, 37, 37),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return withLogo == true
          ? Padding(
              padding: edgeInsetsSymmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Palette.kGrey.withOpacity(0.3),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: edgeInsetsAll(13.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            sizedBox(
                              width: 35,
                              height: 35,
                              child: logoWhiteImg,
                            ),
                            sizedBox(width: 5),
                            Flexible(
                              child: Text(
                                message!,
                                style: const TextStyle(
                                  color: Palette.kBlack,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          : Padding(
              padding: edgeInsetsSymmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Palette.kGrey.withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: edgeInsetsAll(13.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            typeID == AppStatus.mediaType['Text']
                                ? Text(
                                    message.toString(),
                                    style: const TextStyle(fontSize: 14),
                                  )
                                : sizedBox(
                                    child: CachedImageBorderRadius(
                                      imageUrl: message.toString(),
                                      boxFit: BoxFit.cover,
                                      borderRadius: 0,
                                    ),
                                    width: 140,
                                    height: 140,
                                  ),
                            Text(
                              date.toString(),
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
    }
  }
}
