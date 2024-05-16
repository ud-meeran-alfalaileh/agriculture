// type of crops, price, product location, quantity, and quality

class Crops {
  String title;
  String price;
  String img;
  String type;
  String quantity;
  String location;
  String userId;
  String phone;
  Crops({
    required this.title,
    required this.price,
    required this.img,
    required this.type,
    required this.location,
    required this.quantity,
    required this.userId,
    required this.phone,
  });

  toJason() {
    return {
      "title": title,
      "price": price,
      "img": img,
      "phone": phone,
      "location": location,
      "quantity": quantity,
      "userId": userId,
      "type": type
    };
  }
}
