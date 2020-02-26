import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/app_config.dart';

String replacementUrlA;
//String replacementUrlB;

//PackageInfo packageInfo;

final RouteObserver<PageRoute> routeObserver = new RouteObserver<PageRoute>();

class NewsApp<B> extends StatefulWidget {
  final void Function(BuildContext context, B bloc) onDispose;
  final B Function(BuildContext context, B bloc) builder;
  final Widget child;
  final String url;

  static NewsAppState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AppConfig) as AppConfig)
        .newsAppState;
  }

  NewsApp({
    Key key,
    @required this.child,
    this.builder,
    this.onDispose,
    this.url,
  }) : super(key: key);
  createState() => NewsAppState<B>();
}

class NewsAppState<B> extends State<NewsApp<B>> {
  Timer timeDilationTimer;
  B bloc;
  Key key = UniqueKey();

  @override
  void initState() {
    super.initState();
    if (widget.builder != null) {
      bloc = widget.builder(context, bloc);
    }
  }

  @override
  void dispose() {
    if (widget.onDispose != null) {
      widget.onDispose(context, bloc);
    }
    timeDilationTimer?.cancel();
    timeDilationTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    var config = AppConfig.of(context);
    replacementUrlA = widget.url;
//    replacementUrlB = config.replacementUrlB;

    return AppConfig(
      bloc: bloc,
      key: key,
      newsAppState: this,
      child: widget.child,
    );
  }
}
