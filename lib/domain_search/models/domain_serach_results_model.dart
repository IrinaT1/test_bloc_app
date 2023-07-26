class DomainSearchResultsModel {
  final List<DomainModel> domains;
  final String error;

  DomainSearchResultsModel({this.domains = const [], this.error = ''});
}

class DomainModel {
  final String domain;
  final bool isDead;

  DomainModel({this.domain = '', this.isDead = false});
}
