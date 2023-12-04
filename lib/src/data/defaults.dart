import 'dart:convert';

import 'package:friendlyscorer/src/data/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

const answersKey = 'friendlyscorer_answers';

Future<List<Answer>> initialAnswers() async {
  final prefs = await SharedPreferences.getInstance();
  final answersValue = prefs.getString(answersKey);
  if (answersValue == null) return defaultAnswers;

  final answersJson = jsonDecode(answersValue);
  return answersJson.map((aj) => Answer.fromJson(aj)).toList(growable: false);
}

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

const playersKey = 'friendlyscorer_players';

Future<List<Player>> initialPlayers() async {
  final prefs = await SharedPreferences.getInstance();
  final playersValue = prefs.getString(playersKey);
  if (playersValue == null) return defaultPlayers;

  final playersJson = jsonDecode(playersValue);
  return playersJson.map((pj) => Player.fromJson(pj)).toList(growable: false);
}

final defaultAnswerPlayerAssociations = [
  AnswerPlayerAssociation(playerId: chip.id, answerId: steveMartin.id),
  AnswerPlayerAssociation(playerId: chip.id, answerId: taylorSwift.id),
  AnswerPlayerAssociation(playerId: chip.id, answerId: eddieMurphy.id),
  AnswerPlayerAssociation(playerId: chip.id, answerId: chevyChase.id),
  AnswerPlayerAssociation(playerId: brian.id, answerId: robertDowneyJr.id),
  AnswerPlayerAssociation(playerId: brian.id, answerId: linManuelMiranda.id),
  AnswerPlayerAssociation(playerId: brian.id, answerId: paulGiamatti.id),
  AnswerPlayerAssociation(playerId: brian.id, answerId: justinTimberlake.id),
  AnswerPlayerAssociation(playerId: shelley.id, answerId: steveMartin.id),
  AnswerPlayerAssociation(playerId: shelley.id, answerId: tinaFey.id),
  AnswerPlayerAssociation(playerId: shelley.id, answerId: paulSimon.id),
  AnswerPlayerAssociation(playerId: shelley.id, answerId: tomHanks.id),
  AnswerPlayerAssociation(playerId: kathy.id, answerId: taylorSwift.id),
  AnswerPlayerAssociation(playerId: kathy.id, answerId: taylorLautner.id),
  AnswerPlayerAssociation(playerId: kathy.id, answerId: britneySpears.id),
  AnswerPlayerAssociation(playerId: kathy.id, answerId: hughJackman.id),
  AnswerPlayerAssociation(playerId: carlGpt.id, answerId: elonMusk.id),
  AnswerPlayerAssociation(playerId: carlGpt.id, answerId: ruthGordon.id),
  AnswerPlayerAssociation(playerId: carlGpt.id, answerId: charlesBarkley.id),
  AnswerPlayerAssociation(playerId: carlGpt.id, answerId: magnusCarlsen.id),
];

const answerPlayerAssociationKey = 'friendlyscorer_answerstoplayers';

Future<List<AnswerPlayerAssociation>> initialRuleAssociations() async {
  final prefs = await SharedPreferences.getInstance();
  final associationsValue = prefs.getString(answerPlayerAssociationKey);
  if (associationsValue == null) return defaultAnswerPlayerAssociations;

  final associationsJson = jsonDecode(associationsValue);
  return associationsJson
      .map((rj) => AnswerPlayerAssociation.fromJson(rj))
      .toList(growable: false);
}

final alecBaldwinOrSteveMartin =
    ruleFromName('Alec Baldwin or Steve Martin +1');
final athleteRule = ruleFromName('Athlete -2');

final defaultRules = [
  ruleFromName('Buck Henry +2'),
  alecBaldwinOrSteveMartin,
  athleteRule,
];

const rulesKey = 'friendlyscorer_rules';

Future<List<Rule>> initialRules() async {
  final prefs = await SharedPreferences.getInstance();
  final rulesValue = prefs.getString(answerRuleAssociationKey);
  if (rulesValue == null) return defaultRules;

  final rulesJson = jsonDecode(rulesValue);
  return rulesJson.map((rj) => Rule.fromJson(rj)).toList(growable: false);
}

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

const answerRuleAssociationKey = 'friendlyscorer_answerstorules';

Future<List<AnswerRuleAssociation>> initialAnswerRuleAssociations() async {
  final prefs = await SharedPreferences.getInstance();
  final associationsValue = prefs.getString(answerRuleAssociationKey);
  if (associationsValue == null) return defaultAnswerRuleAssociations;

  final associationsJson = jsonDecode(associationsValue);
  return associationsJson
      .map((rj) => AnswerRuleAssociation.fromJson(rj))
      .toList(growable: false);
}
