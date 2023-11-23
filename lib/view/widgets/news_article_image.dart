import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NewsArticleImage extends StatelessWidget {
  const NewsArticleImage({
    super.key,
    required this.width,
    required this.height,
    required this.image,
  });

  final double width;
  final double height;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.8,
      height: height * 0.9,
      margin: EdgeInsets.symmetric(
        horizontal: height * .02,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.cover,
          placeholder: (context, url) => const SpinKitFadingCircle(
            size: 50,
            color: Colors.amber,
          ),
          errorWidget: (context, url, error) => const Center(
            child: Icon(
              Icons.error_outline,
            ),
          ),
        ),
      ),
    );
  }
}
