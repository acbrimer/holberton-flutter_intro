import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'character_tile.dart';
import 'models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<List<Character>> fetchBbCharacters() async {
    try {
      // create List<Character> to hold response data
      // need to figure out how to make this work w/ .map(...)
      // appending to a `data` with .forEach(...) to get around type errors
      final List<Character> data = [];
      // wait for response from API
      final response = await http
          .get(Uri.parse('https://breakingbadapi.com/api/characters'));
      // decode response data to list of Maps
      // compiler didn't like types here
      // should be List<Map<String, dynamic>> for `Character` constructor
      final characters = json.decode(response.body);
      // loop over `characters` JSON to create `Character` & add to `data`
      characters
          .forEach((characterJson) => data.add(Character(json: characterJson)));
      return data;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(title: const Text("Breaking Bad Quotes")),
        body: FutureBuilder(
            future: fetchBbCharacters(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // loading state-- waiting on response from API
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data == null) {
                // error state-- no data from API
                // TODO: ensure data is either null or correct by this point
                return const Center(
                  child: Text("Error"),
                );
              }
              // ready state-- data is loaded and correct. build grid
              return GridView.builder(
                // add outer padding
                padding: const EdgeInsets.all(8),
                // set grid layout
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    // add margin between tiles
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int ix) =>
                    CharacterTile(character: snapshot.data[ix]),
              );
            })));
  }
}
