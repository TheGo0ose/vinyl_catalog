import 'package:flutter/material.dart';

class VinylModel {
  String albumName;
  String artist;
  String genre;
  String image;
  Color colorBox;
  List<String> conditions;
  String description;
  double price;
  final String previewUrl;

  VinylModel({
    required this.albumName,
    required this.artist,
    required this.genre,
    required this.image,
    required this.colorBox,
    required this.conditions,
    required this.description,
    required this.price,
    required this.previewUrl,
  });

  static List<VinylModel> getMainListVinyls() {
    return [
      VinylModel(
        albumName: 'The Eminem Show',
        artist: 'Eminem',
        genre: 'Rap',
        image: 'assets/images/vinyls/cover_eminem_the_eminem_show.jpg',
        previewUrl:'music/eminem.mp3',
        colorBox: const Color(0xff4a4a4a),
        conditions: ['Mint', 'Near Mint'],
        description: 'The fourth studio album by American rapper Eminem.',
        price: 35.0,
      ),
      VinylModel(
        albumName: 'The Dark Side of the Moon',
        artist: 'Pink Floyd',
        genre: 'Rock',
        image: 'assets/images/vinyls/cover_pink_floyd_the_dark_side_of_the_moon.jpg',
        previewUrl:'music/pink_floyd.mp3',
        colorBox: const Color(0xff000000),
        conditions: ['Mint', 'Good'],
        description: 'One of the most critically acclaimed albums in history.',
        price: 45.0,
      ),
      VinylModel(
        albumName: 'Thriller',
        artist: 'Michael Jackson',
        genre: 'Pop',
        image: 'assets/images/vinyls/cover_michael_jackson_thriller.jpg',
        previewUrl:'music/michael.mp3',
        colorBox: const Color(0xff8d1e1e),
        conditions: ['Mint', 'Near Mint', 'Good'],
        description: 'The best-selling album of all time.',
        price: 40.0,
      ),
      VinylModel(
        albumName: 'Rust in Peace',
        artist: 'Megadeth',
        genre: 'Metal',
        image: 'assets/images/vinyls/cover_megadeth_rust_in_peace.jpg',
        previewUrl:'music/megadeth.mp3',
        colorBox: const Color(0xff223e22),
        conditions: ['Near Mint'],
        description: 'A masterpiece of technical thrash metal.',
        price: 38.0,
      ),
      VinylModel(
        albumName: 'Korn',
        artist: 'Korn',
        genre: 'Metal',
        image: 'assets/images/vinyls/cover_korn_korn.jpg',
        previewUrl:'music/korn.mp3',
        colorBox: const Color(0xff223e22),
        conditions: ['Near Mint'],
        description: 'The first album of the best nu-metal band.',
        price: 45.0,
      ),
      VinylModel(
        albumName: 'The Mountain',
        artist: 'Gorillaz',
        genre: 'Pop',
        image: 'assets/images/vinyls/cover_gorillaz_the_mountain.jpg',
        previewUrl:'music/gorillaz.mp3',
        colorBox: const Color(0xff223e22),
        conditions: ['Mint'],
        description: 'The newest album and already loved by the fans.',
        price: 65.0,
      ),
      VinylModel(
        albumName: 'Aerosmith',
        artist: 'Aerosmith',
        genre: 'Rock',
        image: 'assets/images/vinyls/cover_aerosmith_aerosmith.jpg',
        previewUrl:'music/aerosmith.mp3',
        colorBox: const Color(0xff223e22),
        conditions: ['Near mint', 'Good'],
        description: 'The newest album and already loved by the fans.',
        price: 65.0,
      ),
      VinylModel(
        albumName: 'Check',
        artist: 'BBNOS',
        genre: 'Rap',
        image: 'assets/images/vinyls/assets/images/vinyls/cover_bbnos_sheck.jpg.jpg',
        previewUrl:'music/bbnos.mp3',
        colorBox: const Color(0xff223e22),
        conditions: ['Mint', 'Near mint'],
        description: 'Popular release of the "gen-z Eminem"',
        price: 65.0,
      ),
      VinylModel(
        albumName: 'Mutter',
        artist: 'Rammstein',
        genre: 'Metal',
        image: 'assets/images/vinyls/mutter.jpg',
        previewUrl:'music/rammstein.mp3',
        colorBox: const Color(0xff223e22),
        conditions: ['Mint', 'Near mint'],
        description: 'Classic album of industrial metal.',
        price: 45.0,
      ),
      VinylModel(
        albumName: 'Cracker Island',
        artist: 'Gorillaz',
        genre: 'Pop',
        image: 'assets/images/vinyls/island.jpg',
        previewUrl:'music/gorillaz2.mp3',
        colorBox: const Color(0xff223e22),
        conditions: ['Mint', 'Near mint'],
        description: 'Continue of the story.',
        price: 70.0,
      ),
      VinylModel(
        albumName: 'Хрупко',
        artist: 'Дайте танк(!)',
        genre: 'Rock',
        image: 'assets/images/vinyls/tank.jpg',
        previewUrl:'music/tank.mp3',
        colorBox: const Color(0xff223e22),
        conditions: ['Mint'],
        description: 'Новое поколение русского рока.',
        price: 30.0,
      ),
    ];
  }
}