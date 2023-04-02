class Test {
  final String id;
  final String TestAdi;
  final String ImageUrl;
  final String UnicID;
  final String OnizlemeAciklamasi;

  Test(
      this.id,
      this.TestAdi,
      this.ImageUrl,
      this.UnicID,
      this.OnizlemeAciklamasi
      );

  factory Test.fromMap(Map<String, dynamic> json) {
    return Test(json['id'], json['TestAdi'], json['ImageUrl'], json['UnicID'],json['OnizlemeAciklamasi']);
  }

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(json['id'], json['TestAdi'], json['ImageUrl'], json['UnicID'],json['OnizlemeAciklamasi']);
  }
}