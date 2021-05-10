import 'dart:async';
import 'package:connectivity/connectivity.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/repository.dart';
import '../../models/full_product_info.dart';
import '../../main.dart';

part 'about_event.dart';
part 'about_state.dart';

bool isNextScanAllowed([int duration = 15]) {
  int curTimeStamp = getTimestamp();

  if (numberLaunches == 0) {
    numberLaunches += 1;
    startTimestamp = curTimeStamp;
    return true;
  }

  if ((curTimeStamp - startTimestamp) > duration) {
    startTimestamp = curTimeStamp;
    return true;
  } else {
    return false;
  }
}

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc() : super(AboutInitial());

  Repository rep = Repository();

  @override
  Stream<AboutState> mapEventToState(
    AboutEvent event,
  ) async* {
    bool hasInternet = await checkInternet();

    if (isNextScanAllowed(20)) {
      if (event is AboutStarted) {
        if (!hasInternet) {
          yield AboutNoIEConnection();
        } else {
          try {
            FullProductInfo fullProductInfo =
                await rep.getAllDataThatMeetsRequirements(event.qr);
            startTimestamp -= 20;
            yield AboutLoadSuccess(fullProductInfo: fullProductInfo);
          } on NotFoundException {
            startTimestamp -= 20;
            yield AboutNotFound();
          } catch (error) {
            print(error);
            yield AboutLoadFailure();
          }
        }
      }
    } else {
      yield AboutNextScanNotAllowed();
    }
  }
}

Future<bool> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }
}
