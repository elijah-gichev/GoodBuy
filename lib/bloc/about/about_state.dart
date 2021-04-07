part of 'about_bloc.dart';

@immutable
abstract class AboutState {}

class AboutInitial extends AboutState {}

class AboutLoadSuccess extends AboutState {}

class AboutNotFound extends AboutState {}

class AboutNoIEConnection extends AboutState {}

class AboutLoadFailure extends AboutState {}
