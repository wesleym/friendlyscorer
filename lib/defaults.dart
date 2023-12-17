/// Data to prepopulate the scoreboard at launch.
///
/// This data represents round 2 of Game Show episode 214: Pity Points. See
/// <https://www.theincomparable.com/gameshow/214/>.
library;

import 'package:friendlyscorer/models.dart';
import 'package:friendlyscorer/src/scoreboard/player/id.dart';
import 'package:friendlyscorer/src/scoreboard/rule/id.dart';

Answer _answerFromName(String name) => Answer(id: name, text: name);

final _steveMartin = _answerFromName('Steve Martin');
final _taylorSwift = _answerFromName('Taylor Swift');
final _eddieMurphy = _answerFromName('Eddie Murphy');
final _chevyChase = _answerFromName('Chevy Chase');

final _robertDowneyJr = _answerFromName('Robert Downey Jr.');
final _linManuelMiranda = _answerFromName('Lin-Manuel Miranda');
final _paulGiamatti = _answerFromName('Paul Giamatti');
final _justinTimberlake = _answerFromName('Justin Timberlake');

final _tinaFey = _answerFromName('Tina Fey');
final _paulSimon = _answerFromName('Paul Simon');
final _tomHanks = _answerFromName('Tom Hanks');

final _taylorLautner = _answerFromName('Taylor Lautner');
final _britneySpears = _answerFromName('Britney Spears');
final _hughJackman = _answerFromName('Hugh Jackman');

final _elonMusk = _answerFromName('Elon Musk');
final _ruthGordon = _answerFromName('Ruth Gordon');
final _charlesBarkley = _answerFromName('Charles Barkley');
final _magnusCarlsen = _answerFromName('Magnus Carlsen');

final defaultAnswers = [
  _steveMartin,
  _taylorSwift,
  _eddieMurphy,
  _chevyChase,
  _robertDowneyJr,
  _linManuelMiranda,
  _paulGiamatti,
  _justinTimberlake,
  _tinaFey,
  _paulSimon,
  _tomHanks,
  _taylorLautner,
  _britneySpears,
  _hughJackman,
  _elonMusk,
  _ruthGordon,
  _charlesBarkley,
  _magnusCarlsen,
].toList();

Player _playerFromName(String name) {
  final nextId = PlayerIdVendor().next();
  return Player(
    id: nextId.toString(),
    name: name,
  );
}

final _chip = _playerFromName('Chip');
final _brian = _playerFromName('Brian');
final _shelley = _playerFromName('Shelley');
final _kathy = _playerFromName('Kathy');
final _carlGpt = _playerFromName('CarlGPT');

final defaultPlayers = [
  _brian,
  _chip,
  _kathy,
  _shelley,
  _carlGpt,
].toList();

final defaultAnswerPlayerAssociations = [
  AnswerPlayerAssociation(playerId: _chip.id, answerId: _steveMartin.id),
  AnswerPlayerAssociation(playerId: _chip.id, answerId: _taylorSwift.id),
  AnswerPlayerAssociation(playerId: _chip.id, answerId: _eddieMurphy.id),
  AnswerPlayerAssociation(playerId: _chip.id, answerId: _chevyChase.id),
  AnswerPlayerAssociation(playerId: _brian.id, answerId: _robertDowneyJr.id),
  AnswerPlayerAssociation(playerId: _brian.id, answerId: _linManuelMiranda.id),
  AnswerPlayerAssociation(playerId: _brian.id, answerId: _paulGiamatti.id),
  AnswerPlayerAssociation(playerId: _brian.id, answerId: _justinTimberlake.id),
  AnswerPlayerAssociation(playerId: _shelley.id, answerId: _steveMartin.id),
  AnswerPlayerAssociation(playerId: _shelley.id, answerId: _tinaFey.id),
  AnswerPlayerAssociation(playerId: _shelley.id, answerId: _paulSimon.id),
  AnswerPlayerAssociation(playerId: _shelley.id, answerId: _tomHanks.id),
  AnswerPlayerAssociation(playerId: _kathy.id, answerId: _taylorSwift.id),
  AnswerPlayerAssociation(playerId: _kathy.id, answerId: _taylorLautner.id),
  AnswerPlayerAssociation(playerId: _kathy.id, answerId: _britneySpears.id),
  AnswerPlayerAssociation(playerId: _kathy.id, answerId: _hughJackman.id),
  AnswerPlayerAssociation(playerId: _carlGpt.id, answerId: _elonMusk.id),
  AnswerPlayerAssociation(playerId: _carlGpt.id, answerId: _ruthGordon.id),
  AnswerPlayerAssociation(playerId: _carlGpt.id, answerId: _charlesBarkley.id),
  AnswerPlayerAssociation(playerId: _carlGpt.id, answerId: _magnusCarlsen.id),
];

final _alecBaldwinOrSteveMartin =
    _ruleFromName('Alec Baldwin or Steve Martin +1');
final _athleteRule = _ruleFromName('Athlete -2');

final defaultRules = [
  _ruleFromName('Buck Henry +2'),
  _alecBaldwinOrSteveMartin,
  _athleteRule,
];

Rule _ruleFromName(String r) {
  final id = RuleIdVendor().next();
  return Rule(
    id: id.toString(),
    text: r,
  );
}

final defaultAnswerRuleAssociations = [
  AnswerRuleAssociation(
    ruleId: _alecBaldwinOrSteveMartin.id,
    answerId: _steveMartin.id,
  ),
  AnswerRuleAssociation(
    ruleId: _athleteRule.id,
    answerId: _charlesBarkley.id,
  ),
];
