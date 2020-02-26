import 'package:flutter/material.dart';
import 'package:news_app/src/app.dart';

Type _getType<B>() => B;

class AppConfig<B> extends InheritedWidget {
  final B bloc;
  final String replacementUrlA;
  final String replacementUrlB;
  final NewsAppState newsAppState;

  const AppConfig({
    Key key,
    this.bloc,
    this.replacementUrlA,
    this.replacementUrlB,
    this.newsAppState,
    Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(AppConfig<B> oldWidget) {
    return true;
//    return oldWidget.bloc != bloc;
  }

  static B of<B>(BuildContext context) {
    final type = _getType<AppConfig<B>>();
    final AppConfig<B> provider = context.inheritFromWidgetOfExactType(type);

    return provider.bloc;
  }
}

//class AppConfig extends InheritedWidget {
//  final String replacementUrlA;
//  final String replacementUrlB;
//  final TimbalaAppState workwiseAppState;
//
//  AppConfig({
//    this.replacementUrlA,
//    this.replacementUrlB,
//    this.workwiseAppState,
//    Widget child,
//  }) : super(child: child);
//
//  static AppConfig of(BuildContext context) =>
//      context.inheritFromWidgetOfExactType(AppConfig);
//
//  @override
//  bool updateShouldNotify(InheritedWidget oldWidget) => true;
//}
