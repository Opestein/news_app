// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/model/headline_response.dart';
import 'package:news_app/src/utils/app_utilities.dart';

import 'package:news_app/src/utils/assets.dart';
import 'package:news_app/src/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailPage extends StatelessWidget {
  final SharedPreferences preferences;
  final Dio dio;

  final Article article;

  const DetailPage(this.preferences, this.dio, this.article);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DetailScreen(preferences, dio, article),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final SharedPreferences preferences;
  final Dio dio;
  final Article article;

  DetailScreen(
    this.preferences,
    this.dio,
    this.article,
  );

  PageController _controller = PageController(viewportFraction: 0.9);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(
              height: 400,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: CachedNetworkImage(
                      fadeInCurve: Curves.easeIn,
                      fadeInDuration: Duration(milliseconds: 400),
                      placeholder: (context, url) {
                        return Center(
                          child: Image.asset(
                            Assets.demo_avatar,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                      imageUrl: article.urlToImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SafeArea(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          icon: Icon(Icons.keyboard_backspace),
                          onPressed: () => Navigator.pop(context)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    article.title,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Published ' + timeLeft(article.publishedAt),
                      style: TextStyle(fontSize: 12, color: kBlack87Color),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    article.description,
                    softWrap: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
