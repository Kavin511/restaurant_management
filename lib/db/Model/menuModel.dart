class Menu {
  String foodName;
  String foodDesc;
  String category;
  String price;
  String foodType;
  String availability;
  Menu({
    this.foodName,
    this.foodDesc,
    this.category,
    this.price,
    this.foodType,
    this.availability,
  });

  Menu.fromJson(Map<String, dynamic> json) {
    foodName = json['foodName'];
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
    if (json['result'] != null) {
      menu = new List<Menu>();
      json['result']['foodItems'].forEach((v) {
        menu.add(new Menu.fromJson(v));
      });
    }
  }
}
