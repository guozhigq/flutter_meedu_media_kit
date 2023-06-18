import 'package:flutter/material.dart';
import 'package:flutter_meedu_media_kit/meedu_player.dart';

class PlayerButton extends StatelessWidget {
  final double size;
  final String? iconPath;
  final VoidCallback onPressed;
  final Color backgroundColor, iconColor;
  final bool circle;
  final Widget? customIcon;

  const PlayerButton({
    Key? key,
    this.size = 40,
    this.iconPath,
    required this.onPressed,
    this.circle = true,
    this.backgroundColor = Colors.white54,
    this.iconColor = Colors.black,
    this.customIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(minimumSize: const Size(20, 20)),
      //padding: EdgeInsets.zero,
      //minSize: 20,
      onPressed: () {
        onPressed();
        MeeduPlayerController.of(context).controls = true;
      },
      child: customIcon ??
          Container(
            width: size * 0.8,
            height: size * 0.8,
            padding: EdgeInsets.all(size * 0.1),
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: circle ? BoxShape.circle : BoxShape.rectangle,
            ),
            child: Image.asset(
              iconPath!,
              color: iconColor,
              package: 'flutter_meedu_media_kit',
            ),
          ),
    );
  }
}
