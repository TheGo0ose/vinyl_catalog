import 'package:flutter/material.dart';
import 'package:catalog/local_data/models/vinylModel.dart';
import 'package:catalog/local_data/models/genreModel.dart';
import 'details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final List<GenreModel> genreData = GenreModel.getGenres();

  List<VinylModel> itemsToDisplay = [];
  List<VinylModel> allVinyls = [];

  int selectedGenreIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // ИСПРАВЛЕНИЕ: Сначала наполняем общий список данными из модели
    allVinyls = VinylModel.getMainListVinyls();
    _updateListByGenre();

    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
      _performSearch();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _updateListByGenre() {
    String currentGenre = genreData[selectedGenreIndex].name;
    setState(() {
      itemsToDisplay = allVinyls.where((vinyl) => vinyl.genre == currentGenre).toList();
    });
  }

  void _performSearch() {
    if (_searchQuery.isEmpty) {
      _updateListByGenre();
    } else {
      setState(() {
        itemsToDisplay = allVinyls.where((item) {
          return item.artist.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              item.albumName.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [header(), genresList(), vinylList()],
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      height: 250,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1e1e1e), Color(0xff121212)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          const Text("Vinyl Store", style: TextStyle(color: Colors.amber, fontSize: 24, fontWeight: FontWeight.bold)),
          const Text("Find your sound", style: TextStyle(color: Colors.white70, fontSize: 16)),
          const SizedBox(height: 20),
          TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Search artist or album...',
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(Icons.music_note, color: Colors.black),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          )
        ],
      ),
    );
  }

  Widget genresList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text("Genres", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 60,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: genreData.length,
            separatorBuilder: (context, index) => const SizedBox(width: 15),

            // ВОТ ОН, АЙТЕМ БИЛДЕР ДЛЯ ЖАНРОВ!
            itemBuilder: (context, index) {
              bool isSelected = selectedGenreIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedGenreIndex = index;
                    _searchController.clear();
                    _updateListByGenre();
                  });
                },
                child: Chip(
                  avatar: Image.asset(genreData[index].vector), // Иконка из GenreModel
                  label: Text(genreData[index].name),
                  backgroundColor: isSelected ? Colors.amber : Colors.grey[800],
                  labelStyle: TextStyle(color: isSelected ? Colors.black : Colors.white),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget vinylList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      itemCount: itemsToDisplay.length,
      separatorBuilder: (context, index) => const SizedBox(height: 15),

      itemBuilder: (context, index) {
        final vinyl = itemsToDisplay[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailPage(vinylModel: vinyl)),
            );
          },
          child: Container(
            height: 100,
            decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                    image: DecorationImage(image: AssetImage(vinyl.image), fit: BoxFit.cover),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(vinyl.albumName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(vinyl.artist, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                        const Spacer(),
                        Text("\$${vinyl.price}", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}