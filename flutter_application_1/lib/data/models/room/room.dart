// class Room {
//   final String roomNumber;
//   final String buildingCode;
//   final int floor;
//   final int capacity;
//   final List<String> facilities;
//   final String status;

//   Room({
//     required this.roomNumber,
//     required this.buildingCode,
//     required this.floor,
//     this.capacity = 1,
//     required this.facilities,
//     required this.status,
//   });

//   factory Room.fromJson(Map<String, dynamic> json) {
//     return Room(
//       roomNumber: json['roomNumber'] ?? '',
//       buildingCode: json['buildingCode'] ?? '',
//       floor: json['floor'] ?? 0,
//       capacity: 1,
//       facilities: List<String>.from(json['facilities'] ?? []),
//       status: json['status'] ?? 'available',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'roomNumber': roomNumber,
//       'buildingCode': buildingCode,
//       'floor': floor,
//       'capacity': 1,
//       'facilities': facilities,
//       'status': status,
//     };
//   }

//   Room copyWith({String? status}) {
//     return Room(
//       roomNumber: this.roomNumber,
//       buildingCode: this.buildingCode,
//       floor: this.floor,
//       capacity: 1,
//       facilities: this.facilities,
//       status: status ?? this.status,
//     );
//   }
// }

class Room {
  final String roomNumber;
  final String buildingCode;
  final int floor;
  final int capacity;
  final List<String> facilities;
  final String status;

  Room({
    required this.roomNumber,
    required this.buildingCode,
    required this.floor,
    this.capacity = 1, // Mặc định capacity là 1 nếu không có dữ liệu
    required this.facilities,
    required this.status,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      roomNumber: json['roomNumber'] ?? '',
      buildingCode: json['buildingCode'] ?? '',
      floor: json['floor'] ?? 0,
      capacity: json['capacity'] ?? 1, // Parse capacity từ Firestore
      facilities: List<String>.from(json['facilities'] ?? []),
      status: json['status'] ?? 'available',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomNumber': roomNumber,
      'buildingCode': buildingCode,
      'floor': floor,
      'capacity': capacity, // Lưu capacity thực tế
      'facilities': facilities,
      'status': status,
    };
  }

  Room copyWith({String? status}) {
    return Room(
      roomNumber: this.roomNumber,
      buildingCode: this.buildingCode,
      floor: this.floor,
      capacity: this.capacity, // Sử dụng capacity thực tế
      facilities: this.facilities,
      status: status ?? this.status,
    );
  }
}