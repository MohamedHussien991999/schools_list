class SchoolModel {
  final int id ;
  final String name;
  final String profilePhoto;
  final String type;
  final String level;
  final String language;
  final String street;
  final int minAvailableGrade;
  final int maxAvailableGrade;
  final double latitude;
  final double longitude;
  final String phoneNumber;
  final String website;
  bool isFavorite = false;

  SchoolModel({
    required this.id,
    required this.minAvailableGrade,
    required this.maxAvailableGrade,
    required this.name,
    required this.profilePhoto,
    required this.type,
    required this.level,
    required this.language,
    required this.street,
    required this.latitude,
    required this.longitude,
    required this.phoneNumber ,
    required this.website,
  });

  factory SchoolModel.fromJson(Map<String, dynamic> json) {
    return SchoolModel(
      name: json['name'],
      profilePhoto: json['profilePhoto'],
      type: json['type'],
      level: json['level'],
      language: json['language'],
      street: json['street'],
      minAvailableGrade: json['minAvailableGrade'],
      maxAvailableGrade: json['maxAvailableGrade'],
      latitude: json['latitude'],
      longitude: json['longitude'],
       phoneNumber: json['phoneNumber'],
        website: json['website'], 
        id: json['id'],
    );
  }
}
