import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_hub/view/widgets/text_widgets.dart';

class NewsArticleCard extends StatelessWidget {
  const NewsArticleCard({
    Key? key,
    required this.height,
    required this.width,
    required this.title,
    required this.source,
    required this.format,
    required this.dateTime,
  }) : super(key: key);

  final double height;
  final double width;
  final String title;
  final String source;
  final DateFormat format;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(15),
          height: height * 0.22,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // News article title
              SizedBox(
                width: width * 0.7,
                child: PoppinsText(
                  text: title,
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              // Source and date of the news article
              SizedBox(
                width: width * 0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PoppinsText(
                      text: source,
                    ),
                    PoppinsText(
                      text: format.format(dateTime),
                      maxLines: 2,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
