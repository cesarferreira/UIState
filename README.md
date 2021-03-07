# UIState

A way of representing UI State in an app


## Usage example

View Model example
```dart
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
```

on your Screen:

```dart
state.when(
    success: (event) => successWidget(event.value),
    failure: (event) => failureWidget(event.errorMessage),
    loading: (event) => CircularProgressIndicator(),
)
```


```dart
@override
  Widget build(BuildContext context) {
    UIState<String> state = Provider.of<ViewModel>(context).state;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: state.when(
            success: (event) => successWidget(event.value),
            failure: (event) => failureWidget(event.errorMessage),
            loading: (event) => CircularProgressIndicator(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.adjust_sharp),
        onPressed: () {
          Provider.of<ViewModel>(context, listen: false).fetchUser();
        },
      ),
    );
  }
```