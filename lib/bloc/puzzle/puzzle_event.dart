abstract class PuzzleEvent {}

class TileMoved extends PuzzleEvent {
  final int tileIndex;
  TileMoved({required this.tileIndex});
}

class SettingsUpdated extends PuzzleEvent {
  final int size;
  final String colorScheme;
  final String gameMode;
  final String difficulty;

  SettingsUpdated({
    required this.size,
    required this.colorScheme,
    required this.gameMode,
    required this.difficulty,
  });
}

class AutoSolvePuzzle extends PuzzleEvent {}
