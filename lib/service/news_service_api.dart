import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:news_app/const/const_values.dart';
import 'package:news_app/model/news_model.dart';
import 'package:provider/provider.dart';
/*

class NewsService{


 static Future<List<Articles>> getAllNews({String ?sortBy,page})async{
      try{
         List<Articles> newsList=[];

         var link=Uri.parse("${baseUrl}q=Sports&sortBy=$sortBy&pageSize=10&page=$page&apiKey=${token}");
         var responce=await http.get(link);
         var data=jsonDecode(responce.body);
         print("All data are$data");
         Articles articles;
        // newsList.addAll(data["articles"].map<Articles>((json)=>Articles.fromJson(json)).toList());
         for(var i in data["articles"]){
            articles=Articles.fromJson(i);
            newsList.add(articles);
         }
         print("News length are:${newsList.length}");
         return newsList;
      }catch(e){
         print("Something wring");
          throw e.toString();
      }

   }
}*/
