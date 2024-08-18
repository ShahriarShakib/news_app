import 'package:flutter/material.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:provider/provider.dart';

class SearchNews extends StatefulWidget {
    SearchNews({Key? key}) : super(key: key);

  @override
  State<SearchNews> createState() => _SearchNewsState();
}

class _SearchNewsState extends State<SearchNews> {
  TextEditingController searchController=TextEditingController();

  int page=1;
  late ScrollController _scrollController;


  List<String> searchKeyword=[
    "World",
    "Health",
    "Hasina",
    "Sports",
    "Food"
  ];

  @override
  void initState() {
    // TODO: implement initState

    Provider.of<NewsProvider>(context,listen: false).getSearchNewsList.clear();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        page = page + 1;
        print("page noooooo is $page");
        Provider.of<NewsProvider>(context, listen: false)
            .fetchSearchNewsData(searchController.text.toString(), page);
      }
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context, );
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [

              Wrap(
                direction: Axis.horizontal,
                children: [
                  for (var i in searchKeyword)
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: InkWell(
                        onTap: (){
                          Provider.of<NewsProvider>(context,listen: false).getSearchNewsList.clear();
                          searchController.text=i.toString();
                          Provider.of<NewsProvider>(context,listen: false).fetchSearchNewsData(searchController.text.toString(), page);

                        },
                        child: Chip(
                          avatar: CircleAvatar(
                              backgroundColor: Colors.blue.shade900, child: const Text('AH')),
                          label:   Text('${i.toString()}'),
                        ),
                      ),
                    ),
                ],
              ),


              TextField(
                controller: searchController,
                onChanged: (value){
                  Provider.of<NewsProvider>(context,listen: false).getSearchNewsList.clear();
                  Provider.of<NewsProvider>(context,listen: false).fetchSearchNewsData(searchController.text.toString(), page);
                },
              ),

              ListView.builder(
                itemCount: newsProvider.getSearchNewsList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var data = newsProvider.getSearchNewsList[index];
                  return Container(
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
                  );
                },
              ),

              newsProvider.isLoading?Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CircularProgressIndicator(),
              ):SizedBox(height: 12,)


            ],
          ),
        ),
      ),
    );
  }
}
