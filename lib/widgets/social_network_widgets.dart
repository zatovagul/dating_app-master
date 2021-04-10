import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialNetworkWidget extends StatelessWidget {
  final String assetSvg;
  final BoxDecoration decoration;
  SocialNetworkWidget({
    @required this.assetSvg,
    @required this.decoration,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 42,
      width: 42,
      decoration: decoration,
      child: Center(
        child: SvgPicture.asset(assetSvg),
      ),
    );
  }
}

class TwitterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SocialNetworkWidget(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF389FFE),
      ),
      assetSvg: 'assets/images/twitter.svg',
    );
  }
}

class FacebookWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SocialNetworkWidget(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF214F94),
      ),
      assetSvg: 'assets/images/facebook.svg',
    );
  }
}

class YoutubeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SocialNetworkWidget(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFDD4223),
      ),
      assetSvg: 'assets/images/youtube.svg',
    );
  }
}

class InstagramWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SocialNetworkWidget(
      assetSvg: 'assets/images/instagram.svg',
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFFFFC107), Color(0xFFF44336), Color(0xFF9C27B0)],
          stops: [0.1464, 0.5049, 0.8464],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
    );
  }
}
