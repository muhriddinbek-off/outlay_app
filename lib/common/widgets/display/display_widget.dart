import 'package:outlay/common/di/injection.dart';
import 'package:outlay/common/extensions/text_extensions.dart';
import 'package:outlay/common/widgets/display/display.dart';
import 'package:outlay/common/widgets/display/display_type.dart';
import 'package:outlay/gen/assets.gen.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';

class DisplayWidget extends StatelessWidget {
  const DisplayWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          child,
          Builder(
            builder: (context) {
              _initDisplay(context);
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  _initDisplay(BuildContext context) {
    final display = getIt<Display>();

    display.setOnDisplayListener(
          (message) {
        final Widget icon;
        final Color color;
        switch (message.type) {
          case DisplayType.error:
                     icon = Assets.icons.verify.image();

            color = Colors.red;
            break;
          case DisplayType.warning:
                        icon = Assets.icons.verify.image();

            color = Colors.orange;
            break;
          case DisplayType.info:
            icon = Assets.icons.verify.image();
            color = Colors.blue;
            break;
          case DisplayType.success:
            icon = Assets.icons.verify.image(
              color: Colors.white,
              height: 28,
              width: 28,
            );
            color = Colors.green;
            break;
        }

        ElegantNotification(
          animationDuration: const Duration(seconds: 1),
          height: 72,
          background: color,
          description: message.description
              .s(16)
              .w(500)
              .c(Colors.white)
              .copyWith(maxLines: 3, overflow: TextOverflow.ellipsis),
          icon: icon,
          showProgressIndicator: false,
          displayCloseButton: false,
        ).show(context);
      },
    );
  }
}
