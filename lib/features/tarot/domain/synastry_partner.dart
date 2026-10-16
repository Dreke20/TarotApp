class SynastryPartner {
  final String name;
  final String sunSign;
  final String? moonSign;
  final String? risingSign;
  final String connectionType;

  const SynastryPartner({
    this.name = 'Beloved Seeker',
    this.sunSign = 'Taurus',
    this.moonSign = 'Cancer',
    this.risingSign = 'Scorpio',
    this.connectionType = 'Soulmate Bond',
  });

  SynastryPartner copyWith({
    String? name,
    String? sunSign,
    String? moonSign,
    String? risingSign,
    String? connectionType,
  }) {
    return SynastryPartner(
      name: name ?? this.name,
      sunSign: sunSign ?? this.sunSign,
      moonSign: moonSign ?? this.moonSign,
      risingSign: risingSign ?? this.risingSign,
      connectionType: connectionType ?? this.connectionType,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'sun_sign': sunSign,
        'moon_sign': moonSign,
        'rising_sign': risingSign,
        'connection_type': connectionType,
      };

  factory SynastryPartner.fromJson(Map<String, dynamic> json) =>
      SynastryPartner(
        name: json['name'] as String? ?? 'Beloved Seeker',
        sunSign: json['sun_sign'] as String? ?? 'Taurus',
        moonSign: json['moon_sign'] as String?,
        risingSign: json['rising_sign'] as String?,
        connectionType: json['connection_type'] as String? ?? 'Soulmate Bond',
      );
}
