import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/objectbox.g.dart';

class ObjectBox {
  late final Store store;
  late final Admin _admin;
  late final Box<TodoModel> _todoModelBox;

  ObjectBox._init(this.store) {
    if (Admin.isAvailable()) {
      _admin = Admin(store);
    }
    _todoModelBox = Box<TodoModel>(store);
  }

  static Future<ObjectBox> init() async {
    final store = await openStore();
    return ObjectBox._init(store);
  }

  insertTodoModel(TodoModel detail) {
    _todoModelBox.put(detail);
  }

  Future<bool> editPlan(TodoModel data, int id) async {
    var query = _todoModelBox.query(TodoModel_.id.equals(id)).build();
    var details = await query.findFirst();
    details = TodoModel(
        id: id,
        description: data.description,
        title: data.title,
        date: data.date);
    _todoModelBox.put(details);
    print(details);
    return true;
  }

  insertAllTodoModel(List<TodoModel> todoList) {
    _todoModelBox.putMany(todoList);
  }

  Stream<List<TodoModel>> getAllTodoModel() {
    return _todoModelBox
        .query()
        .watch(triggerImmediately: true)
        .map((event) => event.find());
  }

  int getTodoModelCount() => _todoModelBox.count();

  bool deletePostById(int todoId) {
    return _todoModelBox.remove(todoId);
  }

  List<TodoModel> getAllTaskOfUser(int todoIds) {
    final query = _todoModelBox.query(TodoModel_.id.equals(todoIds)).build();
    List<TodoModel> list = query.find();
    return list;
  }
}
