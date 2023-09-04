import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

class VideoPlayerContainer extends StatefulWidget {
  const VideoPlayerContainer({super.key, required this.episodeUrl});
  final String episodeUrl;

  @override
  State<VideoPlayerContainer> createState() => VideoPlayerContainerState();
}

class VideoPlayerContainerState extends State<VideoPlayerContainer> {
  late BetterPlayerController betterPlayerController;

  @override
  void initState() {
    super.initState();
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.episodeUrl.substring(0, widget.episodeUrl.indexOf('.php')),
      useAsmsSubtitles: false
    );
    betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        allowedScreenSleep: false,
        fit: BoxFit.contain,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          forwardSkipTimeInMilliseconds: 5000,
          backwardSkipTimeInMilliseconds: 5000,
          skipForwardIcon: Icons.forward_5_outlined,
          skipBackIcon: Icons.replay_5_outlined
        )
      ),
      betterPlayerDataSource: betterPlayerDataSource
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer(
        controller: betterPlayerController,
      ),
    );
  }
}