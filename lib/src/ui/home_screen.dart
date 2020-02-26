// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/ui/widgets/card_list_item.dart';
import 'package:news_app/src/ui/widgets/everything_item.dart';
import 'package:news_app/src/utils/app_utilities.dart';
import 'package:news_app/src/utils/assets.dart';
import 'package:news_app/src/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  final SharedPreferences preferences;
  final Dio dio;

  const HomePage(this.preferences, this.dio, {Key key

//    this.testMode = false,
//    this.optionsPage,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreen(preferences, dio),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final SharedPreferences preferences;
  final Dio dio;

  HomeScreen(
    this.preferences,
    this.dio,
  );

  PageController _controller = PageController(viewportFraction: 0.9);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Today's News",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Today, ${getDayMonth(DateTime.now().millisecondsSinceEpoch)}',
                          style: TextStyle(fontSize: 12, color: kBlack87Color),
                        )
                      ],
                    ),
                    CachedNetworkImage(
                      fadeInCurve: Curves.easeIn,
                      fadeInDuration: Duration(milliseconds: 400),
                      placeholder: (context, url) {
                        return Center(
                          child: Image.asset(
                            Assets.demo_avatar,
                            height: 58,
                          ),
                        );
                      },
                      imageUrl: '',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Latest News",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
        CardListItem(preferences, dio),
        EverythingItem(preferences, dio),
      ],
    );
  }
}
