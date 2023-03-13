class Anket {
  final String id;
  final String AnketAdi;
  final String ImageUrl;
  final String UnicID;

  Anket(
      this.id,
      this.AnketAdi,
      this.ImageUrl,
      this.UnicID
      );
  factory Anket.fromMap(Map<String, dynamic> json) {
    return Anket(json['id'], json['AnketAdi'], json['ImageUrl'], json['UnicID']);
  }
  factory Anket.fromJson(Map<String, dynamic> json) {
    return Anket(json['id'], json['AnketAdi'], json['ImageUrl'], json['UnicID']);
  }
}