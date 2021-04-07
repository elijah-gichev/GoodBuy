import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/repository.dart';

part 'about_event.dart';
part 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc() : super(AboutInitial());

  Repository rep = Repository();

  @override
  Stream<AboutState> mapEventToState(
    AboutEvent event,
  ) async* {
    if (event is AboutStarted) {
      try {
        await rep.getAllDataThatMeetsRequirements();
        yield AboutLoadSuccess();
      } catch (error) {
        print(error);
        yield AboutLoadFailure();
      }
    }
    if (event is AboutIENotConnected) {
      yield AboutNoIEConnection();
    }
  }
}

// Future<List<Post>> _fetchPosts(int startIndex, int limit) async {
//     final response = await httpClient.get(
//         'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit');
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body) as List;
//       return data.map((rawPost) {
//         return Post(
//           id: rawPost['id'],
//           title: rawPost['title'],
//           body: rawPost['body'],
//         );
//       }).toList();
//     } else {
//       throw Exception('error fetching posts');
//     }
//   }

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }
}
