class Anket {
  final String id;
  final String AnketAdi;
  final String imgUrl;

  Anket(
      this.id,
      this.AnketAdi,
      this.imgUrl
      );
  factory Anket.fromMap(Map<String, dynamic> json) {
    return Anket(json['id'], json['AnketAdi'], json['imgUrl']);
  }
  factory Anket.fromJson(Map<String, dynamic> json) {
    return Anket(json['id'], json['AnketAdi'], json['imgUrl']);
  }
}