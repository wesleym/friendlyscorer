class Answer {
  final String id;

  String text;

  Answer({
    required this.id,
    required this.text,
  });
}

class AnswerPlayerAssociation {
  final String playerId;
  final String answerId;

  AnswerPlayerAssociation({required this.playerId, required this.answerId});
}

class AnswerRuleAssociation {
  final String ruleId;
  final String answerId;

  AnswerRuleAssociation({required this.ruleId, required this.answerId});
}
