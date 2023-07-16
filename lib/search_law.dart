import 'package:flutter/material.dart';

class LawyerSearch extends SearchDelegate<String> {
  final List<String> lawyers;

  LawyerSearch(this.lawyers);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Colors.white,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      primaryColorBrightness: Brightness.light,
      primaryTextTheme: theme.textTheme,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<String> filteredLawyers = lawyers
        .where((lawyer) => lawyer.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredLawyers.length,
      itemBuilder: (context, index) {
        final String lawyer = filteredLawyers[index];
        return ListTile(
          title: Text(lawyer),
          onTap: () {
            close(context, lawyer);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> filteredLawyers = lawyers
        .where((lawyer) => lawyer.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredLawyers.length,
      itemBuilder: (context, index) {
        final String lawyer = filteredLawyers[index];
        return ListTile(
          title: Text(lawyer),
          onTap: () {
            query = lawyer;
            close(context, lawyer);
          },
        );
      },
    );
  }
}
