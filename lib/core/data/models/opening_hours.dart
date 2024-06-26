class OpeningHours {
  final String dayOfWeek;
  final String openingHour;
  final String closingHour;

  OpeningHours({
    required this.dayOfWeek,
    required this.openingHour,
    required this.closingHour,
  });

  factory OpeningHours.fromJson(Map<String, dynamic> json) {
    return OpeningHours(
      dayOfWeek: json['dayOfWeek'] as String,
      openingHour: json['openingHour'] as String,
      closingHour: json['closingHour'] as String,
    );
  }

  List<Object?> get props => [
        dayOfWeek,
        openingHour,
        closingHour,
      ];
}
