import 'dart:math';

class UsernameRepository {
  getUsername() async {
    await Future.delayed(Duration(milliseconds: 100));
    var value = Random().nextInt(2);

    if (value == 0) {
      throw Exception("A random Error occurred");
    }

    return "cesarferreira";
  }
}
