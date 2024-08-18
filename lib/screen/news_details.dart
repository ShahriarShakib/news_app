import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/screen/news_web_vew.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_plus/share_plus.dart';

class NewsDetails extends StatelessWidget {
  Articles articles;

  NewsDetails({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  await Share.share('${articles.url}',subject: "pranto");
                } catch (e) {
                  print("Problem is $e");
                }
              },
              icon: Icon(
                Icons.share,
                size: 33,
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInImage(
                image: NetworkImage(
                  "${articles.urlToImage}",
                ),
                width: double.infinity,
                height: 150,
                placeholder: NetworkImage(
                    "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png"),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.network(
                      "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",
                      fit: BoxFit.fitWidth);
                },
                fit: BoxFit.fitWidth,
              ),
              Text(
                "Title :${articles.title}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(" ${articles.source!.name}"),
                  IconButton(
                      onPressed: () {

                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: NewsWebView( urlLink: articles.url.toString()),
                              inheritTheme: true,
                              ctx: context),
                        );
                      },
                      icon: Icon(
                        Icons.webhook,
                        size: 30,
                      ))
                ],
              ),
              Text(" ${articles.description}"),
              Text(" ${Jiffy.parse('${articles.publishedAt}').fromNow()}"),
            ],
          ),
        ),
      ),
    );
  }
}
