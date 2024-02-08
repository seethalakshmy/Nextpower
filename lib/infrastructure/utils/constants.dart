class AppConstants {
  List<String> countryCodeList = ["+91", "+353"];

  var kWebWidth = 360.0;
}

enum StationStatus {
  Available,
  Preparing,
  Charging,
  SuspendedEV,
  SuspendedEVSE,
  Finishing,
  Reserved,
  Unavailable,
  Faulted,
}
