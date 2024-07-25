import 'package:equatable/equatable.dart';

class PuzzleState extends Equatable {
  final List<int> tiles;
  final int size;
  final String colorScheme;
  final String gameMode;
  final String difficulty;
  final bool isSolved;

  const PuzzleState({
    required this.tiles,
    required this.size,
    required this.colorScheme,
    required this.gameMode,
    required this.difficulty,
    this.isSolved = false,
  });

  @override
  List<Object?> get props =>
      [tiles, size, colorScheme, gameMode, difficulty, isSolved];
}
