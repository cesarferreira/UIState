import 'package:flutter/material.dart';
import 'package:uistate/uistate.dart';
import 'package:uistate_example/username_repository.dart';

class ViewModel extends ChangeNotifier {
  final UsernameRepository repository;
  ViewModel(this.repository);

  UIState<String> state = Loading();

  fetchUser() async {
    try {
      String username = await repository.getUsername();
      state = Success(username);
    } catch (error) {
      state = Failure(error.toString());
    }

    notifyListeners();
  }
}
