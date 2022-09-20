Future<void> delayMilliseconds2(int milliseconds) =>
    Future.delayed(Duration(milliseconds: milliseconds));

Future<void> delaySeconds2(int seconds) =>
    Future.delayed(Duration(seconds: seconds));

Future<void> delayMilliseconds(int milliseconds, Function()? computation) =>
    Future.delayed(Duration(milliseconds: milliseconds), computation);

Future<void> delaySeconds(int seconds, Function()? computation) =>
    Future.delayed(Duration(seconds: seconds), computation);