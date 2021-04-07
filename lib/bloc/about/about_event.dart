part of 'about_bloc.dart';

@immutable
abstract class AboutEvent {}

class AboutStarted extends AboutEvent {}

class AboutIENotConnected extends AboutEvent {}

class AboutLoaded extends AboutEvent {}
