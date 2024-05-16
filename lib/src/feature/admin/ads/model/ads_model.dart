class AdsModel {
  String img;
  String date;
  AdsModel({required this.img, required this.date});

  tojason() {
    return {
      "img": img,
      "Date": date,
    };
  }
}
