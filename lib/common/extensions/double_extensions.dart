extension DoubleX on double {
  bool get isRound {
    return this % 1 == 0;
  }

  String get getKmOrM {
    if (this < 1) {
      return '${(this * 1000).toInt()} m';
    } else {
      if (isRound) {
        return '${toInt()} km';
      } else {
        return '${toStringAsFixed(1)} km';
      }
    }
  }
}
