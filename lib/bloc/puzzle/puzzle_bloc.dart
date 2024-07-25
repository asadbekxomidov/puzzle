import 'package:bloc/bloc.dart';
import 'puzzle_event.dart';
import 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc()
      : super(PuzzleState(
          tiles: _generateShuffledTiles(3),
          size: 3,
          colorScheme: 'default',
          gameMode: 'classic',
          difficulty: 'beginner',
        )) {
    on<TileMoved>(_onTileMoved);
    on<SettingsUpdated>(_onSettingsUpdated);
    on<AutoSolvePuzzle>(_onAutoSolvePuzzle);
  }

  static List<int> _generateShuffledTiles(int size) {
    final List<int> tiles = List<int>.generate(size * size, (i) => i);
    tiles.shuffle();
    return tiles;
  }

  void _onTileMoved(TileMoved event, Emitter<PuzzleState> emit) {
    final newTiles = List<int>.from(state.tiles);
    final tileIndex = event.tileIndex;
    final emptyIndex = newTiles.indexOf(0);

    if ((tileIndex - 1 == emptyIndex && tileIndex % state.size != 0) ||
        (tileIndex + 1 == emptyIndex && (tileIndex + 1) % state.size != 0) ||
        (tileIndex - state.size == emptyIndex) ||
        (tileIndex + state.size == emptyIndex)) {
      newTiles[emptyIndex] = newTiles[tileIndex];
      newTiles[tileIndex] = 0;
    }

    bool solved = _isSolved(newTiles);
    emit(PuzzleState(
      tiles: newTiles,
      size: state.size,
      colorScheme: state.colorScheme,
      gameMode: state.gameMode,
      difficulty: state.difficulty,
      isSolved: solved,
    ));
  }

  void _onSettingsUpdated(SettingsUpdated event, Emitter<PuzzleState> emit) {
    emit(PuzzleState(
      tiles: _generateShuffledTiles(event.size),
      size: event.size,
      colorScheme: event.colorScheme,
      gameMode: event.gameMode,
      difficulty: event.difficulty,
    ));
  }

  void _onAutoSolvePuzzle(AutoSolvePuzzle event, Emitter<PuzzleState> emit) {
    final size = state.size;
    final List<int> tiles = List<int>.generate(size * size, (i) => i);

    emit(PuzzleState(
      tiles: tiles,
      size: size,
      colorScheme: state.colorScheme,
      gameMode: state.gameMode,
      difficulty: state.difficulty,
      isSolved: true,
    ));
  }

  bool _isSolved(List<int> tiles) {
    final int size = state.size;
    for (int i = 0; i < tiles.length - 1; i++) {
      if (tiles[i] != i + 1) return false;
    }
    return tiles.last == 0;
  }
}
