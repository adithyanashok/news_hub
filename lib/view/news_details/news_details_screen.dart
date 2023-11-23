// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_hub/view/widgets/text_widgets.dart';

class NewsDetailsScreen extends StatelessWidget {
  String newsImg;
  String newsTitle;
  String newsDesc;
  String date;
  String source;
  String author;
  NewsDetailsScreen({
    Key? key,
    required this.newsImg,
    required this.newsTitle,
    required this.newsDesc,
    required this.date,
    required this.source,
    required this.author,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('MMM dd, yyyy');
    DateTime dateTime = DateTime.parse(date);
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
        appBar: AppBar(
          title: const Text('News'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            SizedBox(
              height: height * 0.45,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(40),
                ),
                child: CachedNetworkImage(
                  imageUrl: newsImg,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
            Container(
              height: height * .6,
              margin: EdgeInsets.only(top: height * .4),
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(40),
                ),
              ),
              child: ListView(
                children: [
                  PoppinsText(
                    text: newsTitle,
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        source,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      PoppinsText(
                        text: format.format(dateTime).toString(),
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  PoppinsText(
                    text: newsDesc,
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
