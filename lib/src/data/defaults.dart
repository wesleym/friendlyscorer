import 'package:friendlyscorer/src/data/repository.dart';

import '../player/palette.dart';
import 'models.dart';

Answer answerFromName(String name) {
  return Answer(id: name, text: name);
}

final steveMartin = answerFromName('Steve Martin');
final taylorSwift = answerFromName('Taylor Swift');
final eddieMurphy = answerFromName('Eddie Murphy');
final chevyChase = answerFromName('Chevy Chase');

final defaultAnswers = [
  ...[
    'Britney Spears',
    'Charles Barkley',
  ].map(answerFromName),
  chevyChase,
  eddieMurphy,
  ...[
    'Elon Musk',
    'Hugh Jackman',
    'Justin Timberlake',
    'Lin-Manuel Miranda',
    'Magnus Carlsen',
    'Paul Giamatti',
    'Paul Simon',
    'Robert Downey Jr.',
    'Ruth Gordon',
  ].map(answerFromName),
  steveMartin,
  answerFromName('Taylor Lautner'),
  taylorSwift,
  ...[
    'Tina Fey',
    'Tom Hanks',
  ].map(answerFromName),
].toList();

Player fromName(String name) {
  final nextId = PlayerIdVendor().next();
  return Player(
    id: nextId.toString(),
    name: name,
    color: playerColors[nextId],
  );
}

final chip = fromName('Chip');

final defaultPlayers = [
  fromName('Brian'),
  chip,
  ...[
    'Kathy',
    'Lex',
    'Shelley',
    'CarlGPT',
  ].map(fromName),
].toList();

final defaultPlayerAnswerAssociations = [
  PlayerAnswerAssociation(playerId: chip.id, answerId: steveMartin.id),
  PlayerAnswerAssociation(playerId: chip.id, answerId: taylorSwift.id),
  PlayerAnswerAssociation(playerId: chip.id, answerId: eddieMurphy.id),
  PlayerAnswerAssociation(playerId: chip.id, answerId: chevyChase.id),
];

final defaultRules = [
  'Buck Henry',
  'Alec Baldwin or Steve Martin',
  'Athlete',
].map((r) {
  final id = RuleIdVendor().next();
  final color = playerColors[id];
  return Rule(id: id.toString(), text: r, color: color);
}).toList();
