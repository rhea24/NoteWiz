class Question {
  final String questionText;
  final List<Answer> answersList;

  Question(this.questionText, this.answersList);
}

class Answer {
  final String answerText;
  bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

//realtime_transcript/ ask ChatGPT for questions based on lecture + extract questions/answers from response
List<Question> getQuestions() {
  List<Question> list = [];

  list.add(Question(
    "What is the nature of superposition in quantum mechanics?",
    [
      Answer("It is similar to superposition in classical physics", false),
      Answer("It is probabilistic and strange", false),
      Answer("It involves interference effects", true),
      Answer("It involves electric fields", false),
    ],
  ));

  list.add(Question(
    "What is the purpose of a Mach-Zehnder interferometer?",
    [
      Answer("To split a beam of light into multiple beams", true),
      Answer("To measure electric fields of light", false),
      Answer("To demonstrate the nature of superposition", false),
      Answer("To interfere with photons", false),
    ],
  ));

  list.add(Question(
    "What happens when a property is measured on a superposition state in quantum mechanics?",
    [
      Answer("The result is always an average or intermediate value", false),
      Answer("The result can be either of the superimposed states, with different probabilities", false),
      Answer("The result is always the sum of the coefficients of the superimposed states", false),
      Answer("The result is a combination of both superimposed states", true),
    ],
  ));

  return list;
}