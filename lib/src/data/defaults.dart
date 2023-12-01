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

final robertDowneyJr = answerFromName('Robert Downey Jr.');
final linManuelMiranda = answerFromName('Lin-Manuel Miranda');
final paulGiamatti = answerFromName('Paul Giamatti');
final justinTimberlake = answerFromName('Justin Timberlake');

final tinaFey = answerFromName('Tina Fey');
final paulSimon = answerFromName('Paul Simon');
final tomHanks = answerFromName('Tom Hanks');

final taylorLautner = answerFromName('Taylor Lautner');
final britneySpears = answerFromName('Britney Spears');
final hughJackman = answerFromName('Hugh Jackman');

final elonMusk = answerFromName('Elon Musk');
final ruthGordon = answerFromName('Ruth Gordon');
final charlesBarkley = answerFromName('Charles Barkley');
final magnusCarlsen = answerFromName('Magnus Carlsen');

final defaultAnswers = [
  steveMartin,
  taylorSwift,
  eddieMurphy,
  chevyChase,
  robertDowneyJr,
  linManuelMiranda,
  paulGiamatti,
  justinTimberlake,
  tinaFey,
  paulSimon,
  tomHanks,
  taylorLautner,
  britneySpears,
  hughJackman,
  elonMusk,
  ruthGordon,
  charlesBarkley,
  magnusCarlsen,
].toList();

Player fromName(String name) {
  final nextId = PlayerIdVendor().next();
  return Player(
    id: nextId.toString(),
    name: name,
  );
}

final chip = fromName('Chip');
final brian = fromName('Brian');
final shelley = fromName('Shelley');
final kathy = fromName('Kathy');
final carlGpt = fromName('CarlGPT');

final defaultPlayers = [
  brian,
  chip,
  kathy,
  shelley,
  carlGpt,
].toList();

final defaultPlayerAnswerAssociations = [
  PlayerAnswerAssociation(playerId: chip.id, answerId: steveMartin.id),
  PlayerAnswerAssociation(playerId: chip.id, answerId: taylorSwift.id),
  PlayerAnswerAssociation(playerId: chip.id, answerId: eddieMurphy.id),
  PlayerAnswerAssociation(playerId: chip.id, answerId: chevyChase.id),
  PlayerAnswerAssociation(playerId: brian.id, answerId: robertDowneyJr.id),
  PlayerAnswerAssociation(playerId: brian.id, answerId: linManuelMiranda.id),
  PlayerAnswerAssociation(playerId: brian.id, answerId: paulGiamatti.id),
  PlayerAnswerAssociation(playerId: brian.id, answerId: justinTimberlake.id),
  PlayerAnswerAssociation(playerId: shelley.id, answerId: steveMartin.id),
  PlayerAnswerAssociation(playerId: shelley.id, answerId: tinaFey.id),
  PlayerAnswerAssociation(playerId: shelley.id, answerId: paulSimon.id),
  PlayerAnswerAssociation(playerId: shelley.id, answerId: tomHanks.id),
  PlayerAnswerAssociation(playerId: kathy.id, answerId: taylorSwift.id),
  PlayerAnswerAssociation(playerId: kathy.id, answerId: taylorLautner.id),
  PlayerAnswerAssociation(playerId: kathy.id, answerId: britneySpears.id),
  PlayerAnswerAssociation(playerId: kathy.id, answerId: hughJackman.id),
  PlayerAnswerAssociation(playerId: carlGpt.id, answerId: elonMusk.id),
  PlayerAnswerAssociation(playerId: carlGpt.id, answerId: ruthGordon.id),
  PlayerAnswerAssociation(playerId: carlGpt.id, answerId: charlesBarkley.id),
  PlayerAnswerAssociation(playerId: carlGpt.id, answerId: magnusCarlsen.id),
];

final alecBaldwinOrSteveMartin =
    ruleFromName('Alec Baldwin or Steve Martin +1');
final athleteRule = ruleFromName('Athlete -2');

final defaultRules = [
  ruleFromName('Buck Henry +2'),
  alecBaldwinOrSteveMartin,
  athleteRule,
];

Rule ruleFromName(String r) {
  final id = RuleIdVendor().next();
  return Rule(
    id: id.toString(),
    text: r,
  );
}

final defaultAnswerRuleAssociations = [
  AnswerRuleAssociation(
    ruleId: alecBaldwinOrSteveMartin.id,
    answerId: steveMartin.id,
  ),
  AnswerRuleAssociation(
    ruleId: athleteRule.id,
    answerId: charlesBarkley.id,
  ),
];
