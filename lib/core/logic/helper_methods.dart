
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:tasky/core/widget/app_snack_bar.dart';
final navigatorKey = GlobalKey<NavigatorState>();


enum MassageType {
  success,
  failed,
  warning,
}

enum TaskType {
all,
  inpogress,
  waiting,
  finished

}
enum TaskPriority {
low,
  medium,
  high,

}


void showMessage({
  required String message,
  MassageType type = MassageType.failed,
}) {
  debugPrint('message is $message');
  if (message.isNotEmpty) {
    type == MassageType.success?
        SnackBarApp.success(navigatorKey.currentContext!, text: message):
        type == MassageType.failed?
        SnackBarApp(navigatorKey.currentContext!, text: message, text2: ''):
SnackBarApp.required(navigatorKey.currentContext!, text: message, text2: '');

  }
}
class ListItems extends StatelessWidget {
  const ListItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          InkWell(
            onTap: () {

            },
            child: Container(
              height: 50,
              color: Colors.amber[100],
              child: const Center(child: Text('Entry A')),
            ),
          ),
          const Divider(),
          Container(
            height: 50,
            color: Colors.amber[200],
            child: const Center(child: Text('Entry B')),
          ),
          const Divider(),
          Container(
            height: 50,
            color: Colors.amber[300],
            child: const Center(child: Text('Entry C')),
          ),
        ],
      ),
    );
  }
}

void showAppMenu() {
  showPopover(
    context: navigatorKey.currentContext!,
    bodyBuilder: (context) => const ListItems(),
    onPop: () => print('Popover was popped!'),

    direction: PopoverDirection.bottom,
    width: 200,
    height: 400,
    arrowHeight: 15,
    arrowWidth: 30,
  );
}
MaterialColor? primarySwatch() {
  Color color = const Color(0xFF5F33E1);
  return MaterialColor(color.value, {
    50: color.withOpacity(0.1),
    100: color.withOpacity(0.2),
    200: color.withOpacity(0.3),
    300: color.withOpacity(0.4),
    400: color.withOpacity(0.5),
    500: color.withOpacity(0.6),
    600: color.withOpacity(0.7),
    700: color.withOpacity(0.8),
    800: color.withOpacity(0.9),
    900: color.withOpacity(1.0),
  });
}
