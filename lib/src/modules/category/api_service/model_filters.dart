class Filter {
  String id;
  String label;
  String type;
  List<FilterValue> values;

  Filter({
    required this.id,
    required this.label,
    required this.type,
    required this.values,
  });
}

class FilterValue {
  String id;
  String label;
  int count;
  dynamic input;
  // Map<String, dynamic> input;

  FilterValue({
    required this.id,
    required this.label,
    required this.count,
    required this.input,
  });
}