import 'package:flutter/material.dart';
import 'package:quran_uz/quran_uz.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (final sura in Data.quranUz.suraList)
                  GestureDetector(
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 8.0,
                          bottom: 8.0,
                        ),
                        child: Text(
                          "${sura.id}. ${sura.nameUz} (${sura.nameAr})",
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OpenSurahScreen(
                            name: "${sura.nameUz} (${sura.nameAr})",
                            id: sura.id,
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OpenSurahScreen extends StatelessWidget {
  final String name;
  final int id;
  const OpenSurahScreen({
    super.key,
    required this.name,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final item in Data.verses(id))
                  Column(
                    children: [
                      Text(
                        item.meaning,
                        textAlign: TextAlign.left,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          item.arabic,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      SelectableText(
                        item.audio.medium,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 32.0),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Data {
  static final QuranUz quranUz = QuranUz();

  static List<Verse> verses(int id) {
    List<Verse> verses = quranUz.getVerseListBySuraId(id);
    return verses;
  }
}
