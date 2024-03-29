import 'package:flutter/cupertino.dart';

class ContinueButtonState extends ChangeNotifier {
  
  String _nameButton = 'CHECK IT';
  bool _disable = true;
  int _clickedNum = 0; // 
  bool _active = true; // can't change the answer after clicking 'check it'
  int _screenCode = 0;
  int _correctAnswerNum = 0;
  String _answer = '';

  bool get getDisable => _disable;
  String get getNameButton => _nameButton;
  int get getClickedNum => _clickedNum;
  bool get getActive => _active;
  int get getScreenCode => _screenCode;
  int get getCorrectAnswerNum => _correctAnswerNum;
  String get getAnswer => _answer;

  setAnswer(String string) {
    _answer = string;
    notifyListeners();
  }

  incrementCorrectAnswerNum() {
    _correctAnswerNum++;
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
