// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/src/app.dart';
import 'package:news_app/src/ui/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsHome extends StatefulWidget {
  final SharedPreferences preferences;
  final Dio dio;

  const NewsHome(this.preferences, this.dio, {Key key}) : super(key: key);

  @override
  _NewsHomeState createState() => _NewsHomeState();
}

class _NewsHomeState extends State<NewsHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    final provider = NewsApp.of(context);

    return MaterialApp(
        theme: ThemeData(fontFamily: 'CircularStd'),
        title: 'News App',
        debugShowCheckedModeBanner: false,
        navigatorObservers: [],
        home: HomePage(
          widget.preferences,
          widget.dio,
        )
//          ,navigatorObservers: [routeObserver],
//      ),
        );
  }
}
