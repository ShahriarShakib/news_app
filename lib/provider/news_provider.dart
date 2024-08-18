import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/service/news_service_api.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../const/const_values.dart';

class NewsProvider extends ChangeNotifier {
  List<Articles> newsList = [];
  List<Articles> get getNewsList => newsList;


  bool _isLoading=false;
  bool get isLoading=>_isLoading;

  /*   fetchAllNewsData(String sortBy,page)async{
    newsList=  await NewsService.getAllNews(sortBy:sortBy,page: page );
    print("Length wwwwww${newsList.length}");
    notifyListeners();
    return newsList;

  }*/

  Future<List<Articles>> fetchAllNewsData(String? sortBy, page) async {
    var link = Uri.parse(
        "${baseUrl}q=Sports&sortBy=$sortBy&pageSize=10&page=$page&apiKey=${token}");

    try {
      _isLoading=true;
      notifyListeners();
      final response = await http.get(Uri.parse(link.toString()));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> articlesJson = data['articles'];
        newsList.addAll(articlesJson.map((json) => Articles.fromJson(json)).toList());
        _isLoading=false;
        notifyListeners();
      } else {
        _isLoading=false;
        notifyListeners();
        throw Exception('Failed to load articles');

      }
      return newsList;
    } catch (error) {
      _isLoading=false;
      notifyListeners();
      throw Exception('Failed to load articles: $error');
    }
  }


  List<Articles> searchNewsList = [];
  List<Articles> get getSearchNewsList => searchNewsList;
  Future<List<Articles>> fetchSearchNewsData(String? query, page) async {
    var link = Uri.parse(
        "${baseUrl}q=$query&pageSize=10&page=$page&apiKey=${token}");

    try {
      _isLoading=true;
      notifyListeners();
      final response = await http.get(Uri.parse(link.toString()));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> articlesJson = data['articles'];
        searchNewsList.addAll(articlesJson.map((json) => Articles.fromJson(json)).toList());
        _isLoading=false;
        notifyListeners();
      } else {
        _isLoading=false;
        notifyListeners();
        throw Exception('Failed to load articles');

      }
      return searchNewsList;
    } catch (error) {
      _isLoading=false;
      notifyListeners();
      throw Exception('Failed to load articles: $error');
    }
  }
}
