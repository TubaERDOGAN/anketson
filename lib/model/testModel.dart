import 'test.dart';

class TestModel {
  final String Kod;
  final String Tanim;
  final String ImageUrl;
  final String Aciklama;
  final String UnicID;
  final List<Test> Testler;
  final int TestAdedi;

  TestModel(
      this.Kod,
      this.Tanim,
      this.ImageUrl,
      this.Aciklama,
      this.UnicID,
      this.Testler,
      this.TestAdedi
      );

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(json['Kod'], json['Tanim'], json['ImageUrl'], json['Aciklama'],json['UnicID'],json['Testler'],json['TestAdedi']);
  }
}