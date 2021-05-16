import 'package:meta/meta.dart';

class FetchedLink {
  final String id;
  final String name;
  final String link;
  final String createdDate;

  FetchedLink(
      {@required this.id,
      @required this.name,
      @required this.link,
      @required this.createdDate});
}
