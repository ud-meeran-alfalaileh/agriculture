// type of crops, price, product location, quantity, and quality

class Crops {
  String title;
  String price;
  String img;
  String type;
  String quantity;
  String location;
  String userId;
  Crops({
    required this.title,
    required this.price,
    required this.img,
    required this.type,
    required this.location,
    required this.quantity,
    required this.userId,
  });

  toJason() {
    return {
      "title": title,
      "price": price,
      "img": img,
      "location": location,
      "quantity": quantity,
      "userId": userId,
      "type": type
    };
  }
}
