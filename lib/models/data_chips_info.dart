class DataChipInfo {
  final String label;
  final String? value;
  final String? units;
  final double? lowerLimit;
  final double? upperLimit;
  final String? placeholder;

  const DataChipInfo({
    required this.label,
    required this.value,
    this.units,
    this.lowerLimit,
    this.upperLimit,
    this.placeholder,
  });
}