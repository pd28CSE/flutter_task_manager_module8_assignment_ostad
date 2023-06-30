class Task {
  String title;
  String description;
  int days;

  Task({
    required this.title,
    required this.description,
    required this.days,
  });

  String getTitle() {
    return title;
  }

  void setTitle(String title) {
    this.title = title;
  }

  String getShortDescription() {
    if (description.length <= 25) {
      return description;
    } else {
      return '${description.substring(0, 25)}... Read More.';
    }
  }

  String getDescription() {
    return description;
  }

  void setDescription(String description) {
    this.description = description;
  }

  int getDays() {
    return days;
  }

  void setDays(int days) {
    this.days = days;
  }
}
