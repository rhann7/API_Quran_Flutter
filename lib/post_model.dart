class Surah {
  int nomor;
  String nama;
  String namaLatin;
  String arti;
  int jumlahAyat;

  Surah({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.arti,
    required this.jumlahAyat,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      nomor: json['nomor'] as int,
      nama: json['nama'] as String,
      namaLatin: json['namaLatin'] as String,
      arti: json['arti'] as String,
      jumlahAyat: json['jumlahAyat'] as int,
    );
  }
}

class Ayat {
  int nomorAyat;
  String teksArab;
  String teksLatin;

  Ayat({
    required this.nomorAyat,
    required this.teksArab,
    required this.teksLatin,
  });

  factory Ayat.fromJson(Map<String, dynamic> json) {
    return Ayat(
      nomorAyat: json['nomorAyat'] as int,
      teksArab: json['teksArab'] as String,
      teksLatin: json['teksLatin'] as String,
    );
  }
}
