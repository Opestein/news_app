import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/app.dart';
import 'package:news_app/src/app_config.dart';
import 'package:news_app/src/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var preferences = await SharedPreferences.getInstance();
  var dio = Dio();

  var configuredApp = AppConfig(
    child: NewsApp(
      child: NewsHome(preferences, dio),
      url: 'http://newsapi.org/v2/url&apiKey=5a8ea2df1bb942ab905c1a54d8747cf9',
    ),
  );

  runApp(configuredApp);
}
