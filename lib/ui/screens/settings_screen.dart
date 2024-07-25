import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vazifa_4/bloc/puzzle/puzzle_bloc.dart';
import 'package:vazifa_4/bloc/puzzle/puzzle_event.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedSize = 3;
  String _selectedColorScheme = 'default';
  String _selectedGameMode = 'classic';
  String _selectedDifficulty = 'beginner';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade200,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade200,
        centerTitle: true,
        title: Text(
          'Settings',
          style: GoogleFonts.daiBannaSil(
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Puzzle Size:',
              style: GoogleFonts.daiBannaSil(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            DropdownButton<int>(
              value: _selectedSize,
              items: List.generate(3, (index) => index + 3)
                  .map((size) => DropdownMenuItem<int>(
                        value: size,
                        child: Text(
                          '$size x $size',
                          style: GoogleFonts.daiBannaSil(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (size) {
                setState(() {
                  _selectedSize = size!;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Select Color Scheme:',
              style: GoogleFonts.daiBannaSil(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            DropdownButton<String>(
              value: _selectedColorScheme,
              items: ['default', 'fringe']
                  .map((scheme) => DropdownMenuItem<String>(
                        value: scheme,
                        child: Text(
                          scheme,
                          style: GoogleFonts.daiBannaSil(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (scheme) {
                setState(() {
                  _selectedColorScheme = scheme!;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Select Game Mode:',
              style: GoogleFonts.daiBannaSil(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            DropdownButton<String>(
              value: _selectedGameMode,
              items: ['classic', 'snake', 'spiral']
                  .map((mode) => DropdownMenuItem<String>(
                        value: mode,
                        child: Text(
                          mode,
                          style: GoogleFonts.daiBannaSil(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (mode) {
                setState(() {
                  _selectedGameMode = mode!;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Select Difficulty:',
              style: GoogleFonts.daiBannaSil(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            DropdownButton<String>(
              value: _selectedDifficulty,
              items: ['beginner', 'normal', 'hard']
                  .map((difficulty) => DropdownMenuItem<String>(
                        value: difficulty,
                        child: Text(
                          difficulty,
                          style: GoogleFonts.daiBannaSil(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (difficulty) {
                setState(() {
                  _selectedDifficulty = difficulty!;
                });
              },
            ),
            const SizedBox(height: 260),
            InkWell(
              onTap: () {
                context.read<PuzzleBloc>().add(SettingsUpdated(
                      size: _selectedSize,
                      colorScheme: _selectedColorScheme,
                      gameMode: _selectedGameMode,
                      difficulty: _selectedDifficulty,
                    ));
                Navigator.of(context).pop();
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
                    'Save Settings',
                    style: GoogleFonts.fahkwang(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
