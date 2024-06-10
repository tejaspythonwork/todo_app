class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  Task({
    required this.id,
    required this.title,
    required this.note,
    required this.isCompleted,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.remind,
    required this.repeat,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'note': note,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'color': color,
      'remind': remind,
      'repeat': repeat,
    };
  }

  Task.fromMap(Map<String, dynamic> myJson) {
    id = myJson['id'];
    title = myJson['title'];
    note = myJson['note'];
    isCompleted = myJson['isCompleted'];
    date = myJson['date'];
    startTime = myJson['startTime'];
    endTime = myJson['endTime'];
    color = myJson['color'];
    remind = myJson['remind'];
    repeat = myJson['repeat'];
  }
}
