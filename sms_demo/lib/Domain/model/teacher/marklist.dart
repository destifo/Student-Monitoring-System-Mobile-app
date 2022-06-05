class Marklist {
  late int testOne;
  late int testTwo;
  late int assesment;
  late int midTerm;
  late int finalExam;
  String? studentId;
  String? markid;
  String? subjectName;
  Marklist({
    required this.finalExam,
    required this.testOne,
    required this.testTwo,
    required this.midTerm,
    required this.assesment,
    this.studentId,
    this.markid,
    this.subjectName
  });
  factory Marklist.fromJsonSubjectLevel(Map json) {
    return Marklist(
      testOne: json['test1'],
      testTwo: json['test2'],
      finalExam: json['final'],
      assesment: json['assesment'],
      midTerm: json['mid'],
      subjectName: json['subjectName']
    );
  }
  factory Marklist.fromJson(List json, String subjectName) {
    if (json.isEmpty) {
      return Marklist(
        testOne: 0,
        testTwo: 0,
        finalExam: 0,
        assesment: 0,
        midTerm: 0,
      );
    }
    for (int i = 0; i <= json.length; i++) {
      if (json[i]["subjectName"] == subjectName) {
        return Marklist(
          testOne: json[i]['test1'],
          testTwo: json[i]['test2'],
          finalExam: json[i]['final'],
          assesment: json[i]['assesment'],
          midTerm: json[i]['mid'],
        );
      }
    }
    return Marklist(
        finalExam: 0, testOne: 0, testTwo: 0, midTerm: 0, assesment: 0);
  }
}
