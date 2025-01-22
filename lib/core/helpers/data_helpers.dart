class DataHelpers {
  static int getIntVersion(String value) {
    if (value.isEmpty) {
      return 0;
    } else {
      try {
        Iterable<String> versionParts = value.split('-').first.split(".");
        Iterable<int> versionInts = versionParts.map(int.parse).toList();
        int versionInt = versionInts.elementAt(0) * 10000 + versionInts.elementAt(1) * 100 + versionInts.elementAt(2);
        return versionInt;
      } catch (e) {
        return 0;
      }
    }
  }

  static int getMaxFromArrayInt(List<int> value) {
    return value.reduce((a, b) => a > b ? a : b);
  }

  static int getMinFromArrayInt(List<int> value) {
    return value.reduce((a, b) => a < b ? a : b);
  }
}
