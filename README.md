# UIState

> A way of representing UI State in an app


Loading             |  Success           |           Failure
:-------------------------:|:-------------------------:|:----|
![](extras/spinner.png)  |  ![](extras/success.png) | ![](extras/failure.png)

## Usage example


## On your Screen:
Copying kotlin's way of doing an inline switch:

```dart
state.when(
    success: (event) => successWidget(event.value),
    failure: (event) => failureWidget(event.errorMessage),
    loading: (event) => loadingSpinner(),
)
```


## Full screen example:

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
            loading: (event) => loadingSpinner(),
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



## View Model example

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


---------------------


Made with ♥ by [Cesar Ferreira](http://cesarferreira.com)
