import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'timermodel.dart';

class CountDownTimer {
  double _radius = 1;
  bool _isActive = true;
  late Timer timer;
  late Duration time;
  late Duration _fullTime;

  int? work = 30;
  int? shortBreak = 5;
  int? longBreak = 20;

  String returnTime(Duration t) {
    String minutes = (t.inMinutes < 10)
        ? '0' + t.inMinutes.toString()
        : t.inMinutes.toString();

    int numSeconds = t.inSeconds - (t.inMinutes * 60);

    String seconds =
        (numSeconds < 10) ? '0' + numSeconds.toString() : numSeconds.toString();
    String formattedTime = minutes + ":" + seconds;

    return formattedTime;
  }

  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (int a) {
      String stringTime;
      if (_isActive) {
        time = time - const Duration(seconds: 1);
        _radius = time.inSeconds / _fullTime.inSeconds;
        if (time.inSeconds <= 0) {
          _isActive = false;
        }
      }
      stringTime = returnTime(time);
      return TimerModel(stringTime, _radius);
    });
  }

  Future readSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    work = prefs.getInt('workTime') ?? 30;
    shortBreak = prefs.getInt('shortBreak') ?? 30;
    longBreak = prefs.getInt('longBreak') ?? 30;
  }

  void startWork() async {
    await readSettings();
    _radius = 1;
    time = Duration(minutes: work!, seconds: 0);
    _fullTime = time;
  }

  void stopTimer() {
    _isActive = false;
  }

  void startTimer() {
    if (time.inSeconds > 0) {
      _isActive = true;
    }
  }

  void startBreak(bool isShort) {
    _radius = 1;
    time = Duration(minutes: (isShort) ? shortBreak! : longBreak!, seconds: 0);
    _fullTime = time;
  }
}
