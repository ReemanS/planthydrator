import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPlantsDelegate extends SearchDelegate {
  // Styles
  @override
  String get searchFieldLabel => "Search for plants";

  @override
  TextStyle get searchFieldStyle => GoogleFonts.raleway(
        textStyle: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Color(0xff0f1a0f),
        ),
      );

  // end Styles

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back,
          color: Theme.of(context).inputDecorationTheme.iconColor),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.close,
          color: Theme.of(context).inputDecorationTheme.iconColor,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Center(
      child: Text('Search Results'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text('Search Suggestions'),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: theme.appBarTheme,
      inputDecorationTheme: theme.inputDecorationTheme,
    );
  }
}
