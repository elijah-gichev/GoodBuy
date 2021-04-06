part of 'about_bloc.dart';

@immutable
abstract class AboutState {}

class AboutInitial extends AboutState {}

class AboutLoadFailure extends AboutState {}

class AboutLoadSuccess extends AboutState {}
