import 'package:flutter/material.dart';
import 'models.dart';

class CharacterTile extends StatelessWidget {
  final Character character;
  const CharacterTile({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (GridTile(
        child: Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(character.imgUrl))),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(character.name,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            )),
      ),
    )));
  }
}
