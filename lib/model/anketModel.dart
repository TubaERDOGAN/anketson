import 'anket.dart';

class AnketModel {
  final String Kod;
  final String Tanim;
  final String ImageUrl;
  final String Aciklama;
  final String UnicID;
  final List<Anket> Anketler;
  final int AnketAdedi;

  AnketModel(
      this.Kod,
      this.Tanim,
      this.ImageUrl,
      this.Aciklama,
      this.UnicID,
      this.Anketler,
      this.AnketAdedi
      );

  factory AnketModel.fromJson(Map<String, dynamic> json) {
    return AnketModel(json['Kod'], json['Tanim'], json['ImageUrl'], json['Aciklama'],json['UnicID'],json['Anketler'],json['AnketAdedi']);
  }
}