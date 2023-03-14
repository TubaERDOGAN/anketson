class Anket {
  final String id;
  final String AnketAdi;
  final String ImageUrl;
  final String UnicID;
  final String OnizlemeAciklamasi;

  Anket(
      this.id,
      this.AnketAdi,
      this.ImageUrl,
      this.UnicID,
      this.OnizlemeAciklamasi
      );
  factory Anket.fromMap(Map<String, dynamic> json) {
    return Anket(json['id'], json['AnketAdi'], json['ImageUrl'], json['UnicID'],json['OnizlemeAciklamasi']);
  }
  factory Anket.fromJson(Map<String, dynamic> json) {
    return Anket(json['id'], json['AnketAdi'], json['ImageUrl'], json['UnicID'],json['OnizlemeAciklamasi']);
  }
}