class AnketSorulari {
  final String Soru;
  final String SoruKodu;
  //final String AnketImageUrl;
  final String Cevap1;
  final String Cevap2;
  final String Cevap3;
  final String Cevap4;
  final String Cevap5;
  final String LineUnicID;
  final String LineNumber;

  AnketSorulari(
      this.Soru,
      this.SoruKodu,
      //this.AnketImageUrl,
      this.Cevap1,
      this.Cevap2,
      this.Cevap3,
      this.Cevap4,
      this.Cevap5,
      this.LineUnicID,
      this.LineNumber,
      );
  factory AnketSorulari.fromMap(Map<String, dynamic> json) {
    return AnketSorulari(json['Soru'],json['SoruKodu'],json['Cevap1'],json['Cevap2'],json['Cevap3'],json['Cevap4'],json['Cevap5'],json['LineUnicID'],json['LineNumber']);
  }
  factory AnketSorulari.fromJson(Map<String, dynamic> json) {
    return AnketSorulari(json['Soru'],json['SoruKodu'],json['Cevap1'],json['Cevap2'],json['Cevap3'],json['Cevap4'], json['Cevap5'],json['LineUnicID'],json['LineNumber']);
  }
}