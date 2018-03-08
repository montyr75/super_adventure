String toSnakeCase(String str) => str.split(" ").map((String word) => word.toLowerCase()).join("_");

String imgFromName(String name) => "${toSnakeCase(name)}.jpg";

int percent(int fraction, int whole) => (fraction / whole * 100).round();