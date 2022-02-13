extension NumExtension on double {
  double map(double inMin, double inMax, double outMin, double outMax) {
    return (this - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
  }
}
