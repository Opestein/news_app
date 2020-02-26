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

class CardListItem extends StatefulWidget {
  final SharedPreferences preferences;
  final Dio dio;

  CardListItem(
    this.preferences,
    this.dio,
  );

  @override
  _CardListItemState createState() => _CardListItemState();
}

class _CardListItemState extends State<CardListItem> {
  PageController _controller = PageController(viewportFraction: 0.9);

  @override
  void initState() {
    super.initState();

    headlineBloc.fetchCurrent(widget.dio);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 300,
            child: StreamBuilder<HeadlineResponse>(
                stream: headlineBloc.behaviorSubject.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.articles.length > 0) {
                      return PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _controller,
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                        widget.preferences,
                                        widget.dio,
                                        snapshot.data.articles
                                            .elementAt(index)))),
                            child: CardPageView(
                                snapshot.data.articles.elementAt(index)),
                          );
                        },
                      );
                    }
                    return Container();
                  } else if (snapshot.hasError) {
                    return Container();
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(blue)));
                  }
                }),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "All News",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class CardPageView extends StatelessWidget {
  final Article article;
  const CardPageView(this.article);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
        ),
        Text(
          article.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          '${getDayMonth(article.publishedAt.millisecondsSinceEpoch)}',
          style: TextStyle(fontSize: 12, color: kBlack87Color),
        )
      ],
    );
  }
}
