import 'package:flutter/material.dart';
import 'package:flutter_meedu_media_kit/meedu_player.dart';

import 'youtube_slider.dart';

class YoutubeBottomControls extends StatelessWidget {
  final Responsive responsive;
  const YoutubeBottomControls({Key? key, required this.responsive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ = MeeduPlayerController.of(context);
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: responsive.fontSize(),
    );
    Widget videoDuration = Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          RxBuilder(
              //observables: [_.duration, _.position],
              (__) {
            return Text(
              _.duration.value.inMinutes >= 60
                  ? printDurationWithHours(_.position.value)
                  : printDuration(_.position.value),
              style: textStyle,
            );
          }),
          const SizedBox(width: 2),
          Text('/', style: textStyle),
          const SizedBox(width: 3),
          RxBuilder(
            //observables: [_.duration],
            (__) => Text(
              _.duration.value.inMinutes >= 60
                  ? printDurationWithHours(_.duration.value)
                  : printDuration(_.duration.value),
              style: textStyle,
            ),
          ),
        ],
      ),
    );
    Widget otherControls = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (_.bottomRight != null) ...[
          _.bottomRight!,
          const SizedBox(width: 5)
        ],
        if (_.enabledButtons.playBackSpeed)
          PlayBackSpeedButton(responsive: responsive, textStyle: textStyle),
        if (_.enabledButtons.videoFit) VideoFitButton(responsive: responsive),
        if (_.enabledButtons.muteAndSound)
          MuteSoundButton(responsive: responsive),
        if (_.enabledButtons.pip) PipButton(responsive: responsive),
        if (_.enabledButtons.fullscreen)
          FullscreenButton(size: responsive.buttonSize()),
        const SizedBox(width: 10)
      ],
    );
    return Positioned(
      left: 0,
      right: 0,
      bottom: 4,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [videoDuration, otherControls],
          ),
        ],
      ),
    );
  }
}
