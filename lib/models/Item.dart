
class Item{
  String Name;
  String IdCollection;
  String IdMainCollection;
  int IdPrudact;
  String ImageUrl;
  String PrudactsDetals;
  int Prise;
  int Discount;
  String IdMarket;
  List Opitions;
  int TybePrudact;

  Item(
      {required this.IdMarket,
      required this.Name,
      required this.IdCollection,
      required this.IdMainCollection,
      required this.IdPrudact,
      required this.ImageUrl,
      required this.PrudactsDetals,
      required this.Prise,
      required this.Discount,
      required this.Opitions,
      required this.TybePrudact});

  Map<String, dynamic> Convert2Map(){
    return {
      'Name':Name,
      'ImageUrl':ImageUrl,
      'IdPrudact':IdPrudact,
      'PrudactsDetals':PrudactsDetals,
      'Prise':Prise,
      'Discount':Discount,
      'IdMainCollection':IdMainCollection,
      'IdCollection':IdCollection,
      'IdMarket':IdMarket,
      'Opitions':Opitions,
      'TybePrudact':TybePrudact,
    };
  }


}


