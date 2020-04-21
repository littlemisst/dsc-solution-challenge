class WaterConversion {
  WaterConversion(this.waterCount);
  final int waterCount;

  int get waterInML {
    int _waterInML = waterCount * 250;
    return _waterInML;
  }
}

