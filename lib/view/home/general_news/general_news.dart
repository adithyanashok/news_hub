import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:news_hub/models/category_news_model/category_news_model.dart';
import 'package:news_hub/view/news_details/news_details_screen.dart';
import 'package:news_hub/view/widgets/text_widgets.dart';
import 'package:news_hub/view_model/news_view_model.dart';

class GeneralNewsSection extends StatelessWidget {
  const GeneralNewsSection({
    super.key,
    required this.newsViewModel,
    required this.height,
    required this.width,
    required this.format,
  });

  final NewsViewModel newsViewModel;
  final double height;
  final double width;
  final DateFormat format;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: FutureBuilder<CategoryNewsModel>(
        future: newsViewModel.fetchNewsByCategory('general'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Loading spinner while fetching data
            return const Center(
              child: SpinKitCircle(
                size: 50,
                color: Colors.blue,
              ),
            );
          } else {
            // Displaying a vertical list of news articles by category
            return SingleChildScrollView(
              child: Column(
                children: List.generate(
                  snapshot.data?.articles?.length ?? 0,
                  (index) {
                    final data = snapshot.data?.articles![index];
                    DateTime dateTime = DateTime.parse(
                      '${data?.publishedAt}',
                    );
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: () {
                          // Navigation to the news details screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetailsScreen(
                                newsImg: "${data?.urlToImage}",
                                newsTitle: "${data?.title}",
                                newsDesc: "${data?.description}",
                                date: "${data?.publishedAt}",
                                source: "${data?.source?.name}",
                                author: "${data?.author}",
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            // News article image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: '${data?.urlToImage}',
                                fit: BoxFit.cover,
                                height: height * 0.18,
                                width: width * .3,
                                placeholder: (context, url) =>
                                    const SpinKitFadingCircle(
                                  size: 50,
                                  color: Colors.amber,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Center(
                                  child: Icon(
                                    Icons.error_outline,
                                  ),
                                ),
                              ),
                            ),
                            // Container for news article details
                            Expanded(
                              child: Container(
                                height: height * 0.18,
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  children: [
                                    // News article title
                                    PoppinsText(
                                      text: '${data?.title}',
                                      maxLines: 3,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black54,
                                    ),
                                    const Spacer(),
                                    // Source and date of the news article
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        PoppinsText(
                                          text: '${data?.source?.name}',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black54,
                                        ),
                                        PoppinsText(
                                          text: format.format(dateTime),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
