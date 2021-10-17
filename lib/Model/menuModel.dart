class Menu {
  String foodName;
  String foodDesc;
  String category;
  String price;
  String foodType;
  String availability;
  String foodItems;
  String imageUrl;

  Menu({
    // this.mobileNumber
    this.foodName,
    this.foodDesc,
    this.category,
    this.price,
    this.foodType,
    this.availability,
    this.imageUrl,
  });

  Menu.fromJson(Map<String, dynamic> json) {
    foodName = json['foodName'];
    print(foodName);
    foodDesc = json['foodDesc'];
    category = json['category'];
    price = json['price'];
    foodType = json['foodType'];
    availability = json['availability'];
    imageUrl = json['imageUrl'];
  }
}
class MenuResponse {
  List<Menu> menu;
  MenuResponse({this.menu});
  MenuResponse.fromJson(Map<String, dynamic> json) {
    print(json['result']['foodItems']);
    if (json['result']['foodItems'] != null) {
      menu = new List<Menu>();
      json['result']['foodItems'].forEach((v) {
        menu.add(Menu.fromJson(v));
      });
    }
  }
}
