import 'package:flutter/material.dart';

class GenreModel {
  final int position;      // Позиция для порядка
  final String name;       // Название жанра (Rock, Pop и т.д.)
  final String vector;     // Путь к иконке
  bool isSelected;         // Состояние выбора

  GenreModel({
    required this.position,
    required this.name,
    required this.vector,
    required this.isSelected,
  });

  static List<GenreModel> getGenres() {
    return [
      GenreModel(
        position: 1,
        name: 'Rock',
        vector: 'assets/images/genres/ic_rock_genre.png',
        isSelected: true,
      ),
      GenreModel(
        position: 2,
        name: 'Pop',
        vector: 'assets/images/genres/ic_pop_genre.png',
        isSelected: false,
      ),
      GenreModel(
        position: 3,
        name: 'Rap',
        vector: 'assets/images/genres/ic_rap_genre.png',
        isSelected: false,
      ),
      GenreModel(
        position: 4,
        name: 'Metal',
        vector: 'assets/images/genres/ic_metal_genre.png',
        isSelected: false,
      ),
    ];
  }
}