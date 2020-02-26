import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:news_app/src/app.dart';
import 'package:news_app/src/bloc/everything_news_bloc.dart';
import 'package:news_app/src/bloc/headline_news_bloc.dart';
import 'package:news_app/src/model/headline_response.dart';
import 'package:news_app/src/ui/detail_screen.dart';
import 'package:news_app/src/utils/app_utilities.dart';
import 'package:news_app/src/utils/assets.dart';
import 'package:news_app/src/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EverythingItem extends StatefulWidget {
  final SharedPreferences preferences;
  final Dio dio;

  EverythingItem(
    this.preferences,
    this.dio,
  );

  @override
  _EverythingItemState createState() => _EverythingItemState();
}

class _EverythingItemState extends State<EverythingItem> {
  PageController _controller = PageController(viewportFraction: 0.9);

  @override
  void initState() {
    super.initState();

    everythingNewsBloc.fetchCurrent(widget.dio);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<HeadlineResponse>(
        stream: everythingNewsBloc.behaviorSubject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.articles.length > 0) {
              return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                return ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPage(
                              widget.preferences,
                              widget.dio,
                              snapshot.data.articles.elementAt(index)))),
                  leading: Container(
                    width: 70,
                    height: 70,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
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
                          imageUrl: snapshot.data.articles
                              .elementAt(index)
                              .urlToImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    snapshot.data.articles.elementAt(index).title ?? '',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    timeLeft(
                        snapshot.data.articles.elementAt(index).publishedAt),
                    style: TextStyle(fontSize: 12, color: kBlack87Color),
                  ),
                );
              }, childCount: snapshot.data.articles.length ?? 0));
            } else {
              return SliverToBoxAdapter(child: Container());
            }
          } else if (snapshot.hasError) {
            return SliverToBoxAdapter(child: Container());
          } else {
            return SliverToBoxAdapter(
              child: Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(blue))),
            );
          }
        });
  }
}
