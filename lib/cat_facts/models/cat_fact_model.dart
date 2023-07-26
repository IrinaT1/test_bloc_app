class CatFactModel {
  final List<String> facts;
  final String error;

  CatFactModel({required this.facts, this.error = ''});

  factory CatFactModel.fromJson(List<String> data) {
    return CatFactModel(facts: data);
  }
}
