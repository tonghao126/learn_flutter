import 'dart:ffi';
import 'dart:io';

void main(List<String> args) {
  final myFuture1 = Future(() {
    print('In myFuture1: this is ran before sleep');
    sleep(Duration(seconds: 3));
    return "here you go myFuture1"; // the return doesn't do anything here
  });

  // final myFuture2 = Future.delayed(Duration(seconds: 3), () {
  //   print('waitted 3 secs in myFuture2');
  //   return "this return gets fed to and returned through .then";
  // }).then((value) => value).catchError((err) {
  //   print('Caught $err');
  // }).whenComplete(() {
  //   print('done with myFuture2');
  //   // return 'whenComplete return value';
  // });

  // future and
  Future<void> finalAsyncTest() async {
    print('this will be ran very early');
    print(
        'Now this will be ran 3 seconds later where result is ${await myFuture1}');
    print('after await myFuture1');
    // print('Await my future2 result is${await myFuture2}');
  }

  // print(myFuture2);
  finalAsyncTest();
  print('Done with main');
}
