import 'dart:async';
import 'package:connectivity/connectivity.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/repository.dart';
import '../../models/full_product_info.dart';
import '../../cubit/timer/timer_cubit.dart';

part 'about_event.dart';
part 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  final TimerCubit timer;
  AboutBloc(this.timer) : super(AboutInitial());

  Repository rep = Repository();

  @override
  Stream<AboutState> mapEventToState(
    AboutEvent event,
  ) async* {
    bool hasInternet = await checkInternet();

    if (timer.isAllowedNextReceive()) {
      if (event is AboutStarted) {
        if (!hasInternet) {
          yield AboutNoIEConnection();
        } else {
          try {
            timer.reloadTimestamp();
            FullProductInfo fullProductInfo =
                await rep.getAllDataThatMeetsRequirements(event.qr);

            yield AboutLoadSuccess(fullProductInfo: fullProductInfo);
          } on NotFoundException {
            yield AboutNotFound();
          } catch (error) {
            print(error.toString());
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
