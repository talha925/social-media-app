import 'package:fluttertoast/fluttertoast.dart';

class Message {
  //fluttertoast message show
  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
    );
  }
}
