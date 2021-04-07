part of 'about_bloc.dart';

@immutable
abstract class AboutState {}

class AboutInitial extends AboutState {}

class AboutLoadSuccess extends AboutState {
  final FullProductInfo fullProductInfo;

  AboutLoadSuccess({@required this.fullProductInfo});
}

class AboutNotFound extends AboutState {}

class AboutNextScanNotAllowed extends AboutState {}

class AboutNoIEConnection extends AboutState {}

class AboutLoadFailure extends AboutState {}
