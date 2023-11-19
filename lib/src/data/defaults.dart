import '../player/palette.dart';
import 'models.dart';

final defaultAnswers = [
  'Britney Spears',
  'Charles Barkley',
  'Chevy Chase',
  'Eddie Murphy',
  'Elon Musk',
  'Hugh Jackman',
  'Justin Timberlake',
  'Lin-Manuel Miranda',
  'Magnus Carlsen',
  'Paul Giamatti',
  'Paul Simon',
  'Robert Downey Jr.',
  'Ruth Gordon',
  'Steve Martin',
  'Taylor Lautner',
  'Taylor Swift',
  'Tina Fey',
  'Tom Hanks',
].map((s) => Answer(id: s, text: s)).toList();

final defaultPlayers = [
  'Brian',
  'Chip',
  'Kathy',
  'Lex',
  'Shelley',
  'CarlGPT',
].map((n) {
  final nextId = PlayerIdVendor().next();
  return Player(
    id: nextId.toString(),
    name: n,
    color: playerColors[nextId],
  );
}).toList();

final defaultRules = [
  'Buck Henry',
  'Alec Baldwin or Steve Martin',
  'Athlete',
].map((r) {
  final id = RuleIdVendor().next();
  final color = playerColors[id];
  return Rule(id: id.toString(), text: r, color: color);
}).toList();
