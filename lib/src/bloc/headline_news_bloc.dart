import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/src/data/headline/headline_repo.dart';
import 'package:news_app/src/model/headline_response.dart';
import 'package:news_app/src/utils/operation.dart';
import 'package:rxdart/rxdart.dart';

class HeadlineBloc {
  CancelableOperation _cancelableOperation;
  final BehaviorSubject<HeadlineResponse> _behaviorSubject =
      BehaviorSubject<HeadlineResponse>();

  BehaviorSubject<HeadlineResponse> get behaviorSubject => _behaviorSubject;

  HeadlineBloc();

  fetchCurrent(Dio dio) async {
    _cancelableOperation = CancelableOperation.fromFuture(headlineRepo
        .getHeadline(
      dio,
    )
        .then((response) async {
      Operation operation = response;
      if (operation.code == 200) {
        HeadlineResponse headlineResponse = operation.result;
        _behaviorSubject.add(headlineResponse);
      } else {
        _behaviorSubject.addError(operation.result);
      }
    }));
  }

  cancelOperation() async {
    if (_cancelableOperation != null) await _cancelableOperation.cancel();
  }

  dispose() {
    _behaviorSubject.close();
  }
}

final headlineBloc = HeadlineBloc();
