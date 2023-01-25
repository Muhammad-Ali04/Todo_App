import 'package:objectbox/objectbox.dart';

@Entity()
class TodoModel {
  @Id(assignable: false)
  int? id;
  late final String title;
  late final String description;
  late final String date;

  TodoModel(
      {required this.title, required this.description, required this.date});

  TodoModel.autoId(
      {required this.title, required this.description, required this.date});
}
