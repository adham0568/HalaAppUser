
class Item{
  String Name,/*IdCollection,*/IdMainCollection,ImageUrl,PrudactsDetals,IdMarket;
  int Discount,Prise,IdPrudact,TybePrudact;
  List Opitions,OpitionSelected;
  Item(
      {required this.IdMarket,
      required this.Name,
     // required this.IdCollection,
      required this.IdMainCollection,
      required this.IdPrudact,
      required this.ImageUrl,
      required this.PrudactsDetals,
      required this.Prise,
      required this.Discount,
      required this.Opitions,
      required this.TybePrudact,
      required this.OpitionSelected});

  Map<String, dynamic> Convert2Map(){
    return {
      'Name':Name,
      'ImageUrl':ImageUrl,
      'IdPrudact':IdPrudact,
      'PrudactsDetals':PrudactsDetals,
      'Prise':Prise,
      'Discount':Discount,
      'IdMainCollection':IdMainCollection,
      //'IdCollection':IdCollection,
      'IdMarket':IdMarket,
      'Opitions':Opitions,
      'TybePrudact':TybePrudact,
    };
  }


}


