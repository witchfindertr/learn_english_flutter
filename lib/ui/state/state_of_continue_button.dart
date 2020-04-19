import 'package:flutter/cupertino.dart';

class ContinueButtonState extends ChangeNotifier {
  bool _disable = true;
  String _nameButton = 'CHECK IT';
  int _clickedNum = 0;
  bool _active =
      true; //this parameter is used to disable choose other answer after clicking 'check it' button
  int _screenCode = 0;
  int _correctAnswerNum = 0;
  int _heartNum = 5;

  bool get getDisable => _disable;
  String get getNameButton => _nameButton;
  int get getClickedNum => _clickedNum;
  bool get getActive => _active;
  int get getScreenCode => _screenCode;
  int get getCorrectAnswerNum => _correctAnswerNum;
  int get getHeartNum => _heartNum;

  incrementCorrectAnswerNum() {
    _correctAnswerNum++;
    notifyListeners();
  }

  decrementHeart() {
    _heartNum--;
    notifyListeners();
  }

  setHeartNum(int number) {
    _heartNum = number;
    notifyListeners();
  }

  inActive() {
    _active = false;
    notifyListeners();
  }

  setScreenCode(int code) {
    _screenCode = code;
    notifyListeners();
  }

  incrementClickedNum() {
    _clickedNum++;
    notifyListeners();
  }

  setDefaultClickedNum() {
    _clickedNum = 0;
    notifyListeners();
  }

  setNameToContinue() {
    _nameButton = 'CONTINUE';
    notifyListeners();
  }

  fetchState() {
    _nameButton = 'CHECK IT';
    _disable = true;
    _active = true;
    _screenCode = 0;
    notifyListeners();
  }

  setEnable() {
    _disable = false;
    notifyListeners();
  }

  // setDisable() {
  //   _disable = false;
  //   notifyListeners();
  // }
}
