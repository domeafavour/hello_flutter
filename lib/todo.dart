class Todo {
  final int id;
  String title;
  bool done;

  Todo({
    required this.id,
    required this.title,
    this.done = false,
  });
}

int id = 0;

Todo createNewTodo(String title) {
  return Todo(
    id: id++,
    title: title,
  );
}
