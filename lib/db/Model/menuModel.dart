class Menu {
  String foodName;
  String foodDesc;
  String category;
  String price;
  String foodType;
  String availability;

  // String mobileNumber;
  String foodItems;

  Menu({
    // this.mobileNumber
    this.foodName,
    this.foodDesc,
    this.category,
    this.price,
    this.foodType,
    this.availability,
  });

  Menu.fromJson(Map<String, dynamic> json) {
    // mobileNumber=json['mobileNumber'];
    // foodItems=json['foodItems'];
    foodName = json['foodName'];
    print(foodName);
    foodDesc = json['foodDesc'];
    category = json['category'];
    price = json['price'];
    foodType = json['foodType'];
    availability = json['availability'];
  }
}

class MenuResponse {
  List<Menu> menu;
  MenuResponse({this.menu});
  MenuResponse.fromJson(Map<String, dynamic> json) {
    if (json['result'][0]['foodItems'] != null) {
      menu = new List<Menu>();
      json['result'][0]['foodItems'].forEach((v) {
        menu.add(Menu.fromJson(v));
      });
    }
  }
}
