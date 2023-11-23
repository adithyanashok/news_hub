import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:news_hub/models/category_news_model/category_news_model.dart';
import 'package:news_hub/view/news_details/news_details_screen.dart';
import 'package:news_hub/view/widgets/text_widgets.dart';
import 'package:news_hub/view_model/news_view_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat('MMM dd, yyyy');

  String category = 'General';

  List<String> categories = [
    "General",
    "Entertainment",
    "Sports",
    "Health",
    "Business",
    "Technology",
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        category = categories[index];
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: category == categories[index]
                                ? Colors.blue
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Center(
                              child: PoppinsText(
                                text: categories[index],
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<CategoryNewsModel>(
                  future: newsViewModel.fetchNewsByCategory(category),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitCircle(
                          size: 50,
                          color: Colors.blue,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data?.articles?.length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data?.articles![index];
                          DateTime dateTime = DateTime.parse(
                            '${data?.publishedAt}',
                          );
                          return Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: InkWell(
                              onTap: () {
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
                                  Expanded(
                                    child: Container(
                                      height: height * 0.18,
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Column(
                                        children: [
                                          PoppinsText(
                                            text: '${data?.title}',
                                            maxLines: 3,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black54,
                                          ),
                                          const Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              PoppinsText(
                                                text: '${data?.source?.name}',
                                                fontSize: 13,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
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
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
