import 'package:flutter/material.dart';
import 'package:hello_flutter/empty_widget.dart';
import 'package:hello_flutter/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Todo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textEditingController = TextEditingController();
  bool _textFieldVisible = false;

  // Define an todo object list
  final List<Todo> _todos = [];

  void _handleAddClick() {
    setState(() {
      _textFieldVisible = true;
    });
  }

  void _hideTextField() {
    setState(() {
      _textFieldVisible = false;
    });
  }

  void _handleEditingComplete() {
    _todos.add(createNewTodo(textEditingController.text));
    textEditingController.clear();
    _hideTextField();
  }

  void _toggleDone(int id) {
    final todo = _todos.firstWhere((element) => element.id == id);
    setState(() {
      todo.done = !todo.done;
    });
  }

  void _removeTodo(int id) {
    setState(() {
      _todos.removeWhere((element) => element.id == id);
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var emptyWidgetVisible = _todos.isEmpty && !_textFieldVisible;
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: _textFieldVisible
                  ? TextField(
                      autofocus: true,
                      controller: textEditingController,
                      onEditingComplete: _handleEditingComplete,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your todo',
                      ),
                    )
                  : null,
            ),
            (emptyWidgetVisible)
                ? EmptyWidget(onAddClick: _handleAddClick)
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _todos.length,
                    itemBuilder: (context, index) {
                      final todo = _todos[index];
                      final controller =
                          TextEditingController(text: todo.title);
                      final focusNode = FocusNode();
                      return ListTile(
                        key: ValueKey(todo.id),
                        title: TextField(
                            controller: controller,
                            focusNode: focusNode,
                            onEditingComplete: () {
                              setState(() {
                                todo.title = controller.text;
                              });
                              focusNode.unfocus();
                              controller.clear();
                            },
                            style: TextStyle(
                              color: todo.done ? Colors.grey : null,
                              decoration:
                                  todo.done ? TextDecoration.lineThrough : null,
                            )),
                        leading: Checkbox(
                          value: todo.done,
                          onChanged: (value) => _toggleDone(todo.id),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _removeTodo(todo.id),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleAddClick,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
