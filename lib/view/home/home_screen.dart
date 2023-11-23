// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import 'package:news_hub/models/news_channel_headline_model/news_channel_headlines_model.dart';
import 'package:news_hub/view/home/general_news/general_news.dart';
import 'package:news_hub/view/news_details/news_details_screen.dart';
import 'package:news_hub/view/widgets/news_article_card.dart';
import 'package:news_hub/view/widgets/news_article_image.dart';
import 'package:news_hub/view/widgets/text_widgets.dart';
import 'package:news_hub/view_model/news_view_model.dart';

// Enum to represent the filter options for news sources
enum FilterList { bbcNews, axios, abcNews, bbcSport }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variable to store the selected news source
  FilterList? selectedMenu;

  // Default news source name
  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    // Instance of the NewsViewModel for fetching news data
    NewsViewModel newsViewModel = NewsViewModel();

    // Date format for displaying news article dates
    final format = DateFormat('MMM dd, yyyy');

    // Dimensions of the device screen
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      appBar: AppBar(
        // Navigation to the category screen
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, 'category-screen');
          },
          icon: Image.asset(
            'assets/images/category_icon.png',
            width: 23,
            height: 23,
          ),
        ),
        title: const PoppinsText(
          text: "News",
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: true,
        actions: [
          // Popup menu for selecting news sources
          PopupMenuButton(
            initialValue: selectedMenu,
            onSelected: (value) {
              // Set the news source based on the selected menu item
              if (FilterList.bbcNews == value) {
                name = 'bbc-news';
              }
              if (FilterList.abcNews == value) {
                name = 'abc-news';
              }
              if (FilterList.axios == value) {
                name = 'axios';
              }
              if (FilterList.bbcSport == value) {
                name = 'bbc-sport';
              }

              // Update the selected menu item
              setState(() {
                selectedMenu = value;
              });
            },
            itemBuilder: (context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: FilterList.bbcNews,
                child: Text("BBC"),
              ),
              const PopupMenuItem(
                value: FilterList.axios,
                child: Text("Axios"),
              ),
              const PopupMenuItem(
                value: FilterList.abcNews,
                child: Text("ABC News"),
              ),
              const PopupMenuItem(
                value: FilterList.bbcSport,
                child: Text("BBC Sports"),
              ),
            ],
          )
        ],
      ),
      body: ListView(
        children: [
          // Section for displaying top news headlines
          SizedBox(
            height: height * 0.55,
            width: width,
            child: FutureBuilder<NewsChannelHeadlinesModel>(
              future: newsViewModel.fetchNewsHeadlines(name),
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
                  // Displaying a horizontal list of news articles
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data?.articles?.length,
                    itemBuilder: (context, index) {
                      // Get the datas
                      final data = snapshot.data?.articles![index];
                      // Parsing the date
                      DateTime dateTime = DateTime.parse(
                        '${data?.publishedAt}',
                      );
                      return SizedBox(
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
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Container for displaying news article image
                              NewsArticleImage(
                                width: width,
                                height: height,
                                image: '${data?.urlToImage}',
                              ),
                              // Positioned card with news article details
                              NewsArticleCard(
                                height: height,
                                width: width,
                                source: '${data?.source?.name}',
                                title: '${data?.title}',
                                format: format,
                                dateTime: dateTime,
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
          // Section for displaying news articles by category
          GeneralNewsSection(
            newsViewModel: newsViewModel,
            height: height,
            width: width,
            format: format,
          ),
        ],
      ),
    );
  }
}
