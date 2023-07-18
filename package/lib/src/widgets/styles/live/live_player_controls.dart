import 'package:flutter/material.dart';
import 'package:flutter_meedu_media_kit/meedu_player.dart';
import 'package:flutter_meedu_media_kit/src/widgets/styles/controls_container.dart';
import 'package:flutter_meedu_media_kit/src/widgets/styles/live/live_bottom_controls.dart';

class LiveVideoPlayerControls extends StatelessWidget {
  final Responsive responsive;
  const LiveVideoPlayerControls({Key? key, required this.responsive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ = MeeduPlayerController.of(context);

    return ControlsContainer(
      responsive: responsive,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // RENDER A CUSTOM HEADER
          if (_.header != null)
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: _.header!,
            ),
          SizedBox(
            height: responsive.height,
            width: responsive.width,
          ),

          LiveBottomControls(
            responsive: responsive,
          ),
        ],
      ),
    );
  }
}
