class OrderModal {
  String status;
  String mobileNumber;
  String restaurantMobileNumber;
  String pinCode;
  String district;
  String address;
  String id;
  List<MenuItemModal> menuItem;

  OrderModal(
      {this.status,
      this.mobileNumber,
      this.restaurantMobileNumber,
      this.pinCode,
      this.district,
      this.address,
      this.menuItem,
      this.id});

  OrderModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    mobileNumber = json['mobileNumber'];
    restaurantMobileNumber = json['restaurantMobileNumber'];
    pinCode = json['pincode'];
    district = json['district'];
    address = json['address'];
    id = json['_id'];
    if (json['orderItems'] != null) {
      menuItem = new List<MenuItemModal>();
      json['orderItems'].forEach((v) {
        menuItem.add(new MenuItemModal.fromJson(v));
      });
    }
  }
}

class MenuItemModal {
  String foodName;
  String price;

  MenuItemModal({this.foodName, this.price});

  MenuItemModal.fromJson(Map<String, dynamic> json) {
    foodName = json['foodName'];
    price = json['price'];
  }
}

class OrderResponse {
  List<OrderModal> order;

  OrderResponse.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      order = List<OrderModal>();
      json['result'].forEach((v) {
        order.add(OrderModal.fromJson(v));
      });
    }
  }
}
