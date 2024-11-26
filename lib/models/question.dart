class Question {
  final String promptPrefix;
  final String lyric;
  final List<String> options;
  final int correctAnswerIndex;
  final String trivia;

  Question({
    required this.promptPrefix,
    required this.lyric,
    required this.options,
    required this.correctAnswerIndex,
    required this.trivia,
  });
}
