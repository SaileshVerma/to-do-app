class SubTaskModel {
  final String id;
  String title;
  bool iscompleted;

  SubTaskModel(
      {required this.id, required this.title, this.iscompleted = false});
}
