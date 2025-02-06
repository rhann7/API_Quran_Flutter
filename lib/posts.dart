import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'http_service.dart';
import 'post_model.dart';
import 'post_detail.dart';

class PostPage extends StatefulWidget {
  final HttpService httpService = HttpService();

  PostPage({super.key});

  @override
  PostPageState createState() => PostPageState();
}

class PostPageState extends State<PostPage> {
  List<Surah> allSurah = [];
  List<Surah> filteredSurah = [];
  String searchQuery = "";
  Future<List<Surah>>? _futureSurah;

  @override
  void initState() {
    super.initState();
    _futureSurah = fetchSurah();
  }

  Future<List<Surah>> fetchSurah() async {
    final surahList = await widget.httpService.getSurah();
    setState(() {
      allSurah = surahList;
      filteredSurah = surahList;
    });
    return surahList;
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredSurah = allSurah
          .where((surah) =>
              surah.nama.toLowerCase().contains(query.toLowerCase()) ||
              surah.namaLatin.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0084FF),
        title: Text(
          'Al-Quran Nur Karim',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: updateSearchQuery,
              decoration: const InputDecoration(
                labelText: "Search Surah",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Surah>>(
              future: _futureSurah,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error: ${snapshot.error}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Tidak ada data tersedia"));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: filteredSurah.length,
                  itemBuilder: (context, index) {
                    final surah = filteredSurah[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(surahNumber: surah.nomor),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 25,
                          child: Text(
                            "${surah.nomor}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          surah.nama,
                          style: GoogleFonts.amiri(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          '${surah.namaLatin} - ${surah.arti} \n${surah.jumlahAyat} Ayat',
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}