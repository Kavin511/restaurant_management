class Menu {
  String mobileNumber;
  String foodName;
  String foodDesc;
  String category;
  String price;
  String foodType;
  String availability;

  Menu({
    this.mobileNumber,
    this.foodName,
    this.foodDesc,
    this.category,
    this.price,
    this.foodType,
    this.availability,
  });

  Menu.fromJson(Map<String, dynamic>json){
    mobileNumber = json['mobileNumber'];
    foodName = json['foodName'];
    foodDesc = json['foodDesc'];
    category = json['category'];
    price = json['price'];
    foodType = json['foodType'];
    availability = json['availability'];
  }
}

class MenuResponse {
  List<Menu> results;

}