// lib/data/models/building/building.dart
class Building {
  final String buildingCode;
  final String name;
  final int floors;
  final int totalRooms;
  
  Building({
    required this.buildingCode,
    required this.name,
    required this.floors,
    required this.totalRooms,
  });
  
  factory Building.fromJson(Map<String, dynamic> json) {
    return Building(
      buildingCode: json['buildingCode'] ?? '',
      name: json['name'] ?? '',
      floors: json['floors'] ?? 0,
      totalRooms: json['totalRooms'] ?? 0,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'buildingCode': buildingCode,
      'name': name,
      'floors': floors,
      'totalRooms': totalRooms,
    };
  }
}