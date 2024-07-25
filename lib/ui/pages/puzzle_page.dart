import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vazifa_4/bloc/puzzle/puzzle_bloc.dart';
import 'package:vazifa_4/bloc/puzzle/puzzle_event.dart';
import 'package:vazifa_4/bloc/puzzle/puzzle_state.dart';
import 'package:vazifa_4/ui/screens/settings_screen.dart';
import 'package:vazifa_4/ui/widgets/puzzle_tile_widget.dart';

class PuzzlePage extends StatefulWidget {
  const PuzzlePage({super.key});

  @override
  _PuzzlePageState createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade200,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade200,
        centerTitle: true,
        title: Text(
          'Puzzle Game',
          style: GoogleFonts.daiBannaSil(
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<PuzzleBloc, PuzzleState>(
        listener: (context, state) {
          if (state.isSolved) {
            _showWinDialog(context);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${state.gameMode}'.toUpperCase(),
                              style: GoogleFonts.daiBannaSil(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${state.difficulty}'.toUpperCase(),
                              style: GoogleFonts.daiBannaSil(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: state.size,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: state.tiles.length,
                    itemBuilder: (context, index) {
                      return TileWidget(
                        tileValue: state.tiles[index],
                        onTap: () {
                          context
                              .read<PuzzleBloc>()
                              .add(TileMoved(tileIndex: index));
                        },
                        colorScheme: state.colorScheme,
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    context.read<PuzzleBloc>().add(AutoSolvePuzzle());
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.green.shade500,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Solve Puzzle',
                        style: GoogleFonts.fahkwang(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showWinDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Congratulations!',
            style: GoogleFonts.fahkwang(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/image.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'You have solved the puzzle!',
                style: GoogleFonts.fahkwang(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: GoogleFonts.fahkwang(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
