import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  static const int DURATION = 15;
  int _currentTimestamp;
  TimerCubit() : super(TimerInitial());

  // void getCurrentState() {
  //   if (state is TimerInitial) {
  //     _reloadTimestamp();
  //     emit(TimerReceivePermission());
  //   }else{
  //     if(_currentTimestamp + DURATION < _getTimestamp();){
  //       emit(TimerReceivePermission());
  //     }
  //   }
  // }

  bool isAllowedNextReceive() {
    if (state is TimerInitial) {
      emit(TimerChecking());
      return true;
    }
    if (state is TimerChecking) {
      return _currentTimestamp + DURATION < _getTimestamp();
    }
  }

  static int _getTimestamp() {
    return (DateTime.now().millisecondsSinceEpoch / 1000).truncate();
  }

  void reloadTimestamp() {
    _currentTimestamp = _getTimestamp();
    print("timestamp reloaded");
  }
}
