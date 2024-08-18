import 'package:flutter/material.dart';
import 'package:news_app/const/const_values.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/screen/news_details.dart';
import 'package:news_app/screen/search_news.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String sortBy = SortByEnum.publishedAt.name;

  late ScrollController _scrollController;

  getNewsData() {
    Provider.of<NewsProvider>(context, listen: false)
        .fetchAllNewsData(sortBy, page);
  }

  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    getNewsData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        page = page + 1;
        print("page noooooo is $page");
        Provider.of<NewsProvider>(context, listen: false)
            .fetchAllNewsData(sortBy, page);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context, );
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: SearchNews(),
                inheritTheme: true,
                ctx: context),
          );
        }, icon: Icon(Icons.search))],
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: DropdownButton(
                    items: [
                      DropdownMenuItem(
                        child: Text("${SortByEnum.relevancy.name}"),
                        value: SortByEnum.relevancy.name,
                      ),
                      DropdownMenuItem(
                        child: Text("${SortByEnum.publishedAt.name}"),
                        value: SortByEnum.publishedAt.name,
                      ),
                      DropdownMenuItem(
                        child: Text("${SortByEnum.popularity.name}"),
                        value: SortByEnum.popularity.name,
                      )
                    ],
                    value: sortBy,
                    onChanged: (value) {
                      sortBy = value!;
                      Provider.of<NewsProvider>(context,listen: false).newsList.clear();
                      Provider.of<NewsProvider>(context,listen: false).fetchAllNewsData(sortBy, page);
                      setState(() {});
                    }),
              ),
               ListView.builder(
                      itemCount: newsProvider.getNewsList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var data = newsProvider.getNewsList[index];
                        return InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: NewsDetails(articles: data),
                                  inheritTheme: true,
                                  ctx: context),
                            );
                          },
                          child: Container(
                            height: 150,
                            margin: EdgeInsets.only(bottom: 12),
                            width: double.infinity,
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 5,
                                    child: FadeInImage(
                                      image: NetworkImage("${data.urlToImage}"),
                                      placeholder: NetworkImage(
                                          "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png"),
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.network(
                                            "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",
                                            fit: BoxFit.fitWidth);
                                      },
                                      fit: BoxFit.fitWidth,
                                    )),
                                Expanded(
                                    flex: 15,
                                    child: Column(
                                      children: [
                                        Text(
                                          "${data.title}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        );
                      },
                    ),


              newsProvider.isLoading?CircularProgressIndicator():SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
