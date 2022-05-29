
import 'dart:io';

var users = <String, String> {};
var myId = "";
var dataBackup = <String, List<String>> {};
List<String> todos = [];

void main() {
  showLogin();
}

bool registerAndLogin(String id, String password) {
  if(users[id] == null) {
    users[id] = password;
    myId = id;
    return true;
  } else {
    if(users[id] == password) {
      myId = id;
      return true;
    }
  }
  return false;
}

void backup() => dataBackup[myId] = todos;

bool restore() {
  if(dataBackup[myId] != null) {
    todos = dataBackup[myId]!;
    return true;
  }
  return false;
}

void createTodo(String value) => todos.add(value);

void removeTodo(int value) => todos.removeAt(value - 1);

bool validations(String value) => value != "" ? true : false;

// Interface

void showLogin() {

  myId = "";
  todos = [];

  print("=============================================================");
  print("LOGIN OR REGISTER");
  print("=============================================================");

  stdout.write("Id : ");
  String? id = stdin.readLineSync();

  stdout.write("Password : ");
  String? password = stdin.readLineSync();

  var res = registerAndLogin(id!, password!);

  if(res) {
    print("Welcome $myId!");
    restore();
    showHomepage();
  } else {
    print("Failed to login...");
  }

}

void showHomepage() {

  while(true) {
    print("=============================================================");
    print("HOMEPAGE");
    print("=============================================================");

    if(todos.isNotEmpty) {
      for(var i = 0; i < todos.length; i++) {
        print("${i + 1}. ${todos[i]}");
      }
      print("=============================================================");
    }

    print("c. Create Todo");
    print("d. Delete Todo");
    print("x. Sign Out");

    print("=============================================================");

    stdout.write("Option : ");
    String option = stdin.readLineSync()!;

    switch(option) {
      case "c" :
        showCreate();
        break;
      case "d" :
        showRemove();
        break;
      case "x" :
        backup();
        showLogin();
        break;
    }
  }

}

void showCreate() {
  print("=============================================================");
  print("CREATE TODO");
  print("=============================================================");
  stdout.write("Todo : ");
  String todo = stdin.readLineSync()!;
  if(validations(todo)) {
    createTodo(todo);
  }
  showHomepage();
}

void showRemove() {
  print("=============================================================");
  print("REMOVE TODO");
  print("=============================================================");
  stdout.write("ID : ");
  int id = int.parse(stdin.readLineSync()!);
  removeTodo(id);
  showHomepage();
}