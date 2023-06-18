import 'package:flutter/material.dart';
import 'package:flutter_meedu_media_kit/meedu_player.dart';

class YoutubePlayerSlider extends StatelessWidget {
  const YoutubePlayerSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ = MeeduPlayerController.of(context);
    return SizedBox(
      height: 8,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          LayoutBuilder(builder: (ctx, constraints) {
            return RxBuilder(
              //observables: [_.buffered, _.duration],
              (__) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  color: Colors.white30,
                  width: constraints.maxWidth * _.bufferedPercent.value,
                  height: 3,
                );
              },
            );
          }),
          RxBuilder(
            //observables: [_.sliderPosition, _.duration],
            (__) {
              final int value = _.sliderPosition.value.inSeconds;
              final double max = _.duration.value.inSeconds.toDouble();
              if (value > max || max <= 0) {
                return Container();
              }
              return SizedBox(
                height: 10,
                child: SliderTheme(
                  data: SliderThemeData(
                    trackShape: MSliderTrackShape(),
                    thumbColor: _.colorTheme,
                    activeTrackColor: _.colorTheme,
                    trackHeight: 4,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 0.0),
                  ),
                  child: Slider(
                    min: 0,
                    divisions: _.duration.value.inSeconds,
                    value: value.toDouble(),
                    thumbColor: Colors.transparent,
                    onChangeStart: (v) {
                      _.onChangedSliderStart();
                    },
                    onChangeEnd: (v) {
                      _.onChangedSliderEnd();
                      _.seekTo(
                        Duration(seconds: v.floor()),
                      );
                    },
                    label: printDuration(_.sliderPosition.value),
                    max: max,
                    onChanged: _.onChangedSlider,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class MSliderTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    SliderThemeData? sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    const double trackHeight = 1;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2 + 4;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
