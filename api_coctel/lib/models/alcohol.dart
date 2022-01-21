class AlcoholResponse {
  AlcoholResponse({
    required this.drinks,
  });
  late final List<DrinksAlcohol> drinks;

  AlcoholResponse.fromJson(Map<String, dynamic> json) {
    drinks = List.from(json['drinks'])
        .map((e) => DrinksAlcohol.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['drinks'] = drinks.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DrinksAlcohol {
  DrinksAlcohol({
    required this.strDrink,
    required this.strDrinkThumb,
    required this.idDrink,
  });
  late final String strDrink;
  late final String strDrinkThumb;
  late final String idDrink;

  DrinksAlcohol.fromJson(Map<String, dynamic> json) {
    strDrink = json['strDrink'];
    strDrinkThumb = json['strDrinkThumb'];
    idDrink = json['idDrink'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['strDrink'] = strDrink;
    _data['strDrinkThumb'] = strDrinkThumb;
    _data['idDrink'] = idDrink;
    return _data;
  }
}
