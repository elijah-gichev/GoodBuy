part of 'about_bloc.dart';

@immutable
abstract class AboutEvent {}

class AboutStarted extends AboutEvent {
  final String qr;

  AboutStarted({@required this.qr});
}

class AboutIENotConnected extends AboutEvent {}

class AboutLoaded extends AboutEvent {}
