class Grades {
  String Subject;
  double? test1;
  double? test2;
  double? Assignment;
  double? mid;
  double? Final;
  double? Total;
  Grades(this.Subject, this.test1, this.test2, this.Assignment, this.mid,
      this.Final, this.Total);
  static List<Grades> marks = [
    Grades("math", 2.0, 4, 5, 34, 40, 100),
    Grades("bio", 2.0, 4, 5, 34, 40, 100),
    Grades("english", 2.0, 4, 5, 34, 23, 100)
  ];
}
