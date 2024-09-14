/*

  It has properties:
  - id
  - text
  - isComplete

*/

/*

  Methods:
  - toggle completion on & off

 */

class Todo {
  final int id;
  final String text;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.text,
    this.isCompleted = false, // initially to do is incomplete
  });

  Todo toggleCompletion() {
    return Todo(id: id, text: text, isCompleted: isCompleted,);
  }
}
