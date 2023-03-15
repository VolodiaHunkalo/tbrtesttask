class Country {
  final String name;
  final String flagUrl;
  final String dialCode;

  Country({
    required this.name,
    required this.flagUrl,
    required this.dialCode,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'flagUrl': flagUrl,
        'dialCode': dialCode,
      };

  factory Country.fromString(Map<String, dynamic> value) {
    return Country(
      name: value['name'],
      flagUrl: value['flagUrl'],
      dialCode: value['dialCode'],
    );
  }
}
