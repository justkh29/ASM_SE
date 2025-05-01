// // lib/data/sources/room/room_firebase_service.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_application_1/data/models/room/room.dart';

// abstract class RoomFirebaseService {
//   Future<Either<String, List<Room>>> getRoomsByBuilding(String buildingCode);
//   Future<Either<String, List<Room>>> getRoomsByBuildingAndFloor(String buildingCode, int floor);
//   Future<Either<String, Room>> getRoomByNumber(String buildingCode, String roomNumber);
//   Future<Either<String, List<Room>>> getAvailableRooms(String buildingCode, int floor, DateTime date, int startHour, int endHour);
//   Stream<List<Room>> streamRoomsByBuilding(String buildingCode);
  
//   // Thêm phương thức mới để cập nhật trạng thái phòng
//   Future<Either<String, bool>> updateRoomStatus(String buildingCode, String roomNumber, String status);
// }

// class RoomFirebaseServiceImpl implements RoomFirebaseService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   @override
//   Future<Either<String, List<Room>>> getRoomsByBuilding(String buildingCode) async {
//     try {
//       final snapshot = await _firestore.collection('rooms')
//           .where('buildingCode', isEqualTo: buildingCode)
//           .get();
      
//       if (snapshot.docs.isEmpty) {
//         return Left('Không tìm thấy phòng nào trong tòa $buildingCode');
//       }
      
//       final rooms = snapshot.docs
//           .map((doc) => Room.fromJson(doc.data()))
//           .toList();
      
//       return Right(rooms);
//     } catch (e) {
//       return Left('Lỗi khi lấy danh sách phòng: ${e.toString()}');
//     }
//   }
  
//   @override
//   Future<Either<String, List<Room>>> getRoomsByBuildingAndFloor(String buildingCode, int floor) async {
//     try {
//       final snapshot = await _firestore.collection('rooms')
//           .where('buildingCode', isEqualTo: buildingCode)
//           .where('floor', isEqualTo: floor)
//           .get();
      
//       if (snapshot.docs.isEmpty) {
//         return Left('Không tìm thấy phòng nào trong tòa $buildingCode tầng $floor');
//       }
      
//       final rooms = snapshot.docs
//           .map((doc) => Room.fromJson(doc.data()))
//           .toList();
      
//       return Right(rooms);
//     } catch (e) {
//       return Left('Lỗi khi lấy danh sách phòng: ${e.toString()}');
//     }
//   }
  
//   @override
//   Future<Either<String, Room>> getRoomByNumber(String buildingCode, String roomNumber) async {
//     try {
//       final docId = '${buildingCode}_${roomNumber}';
//       final doc = await _firestore.collection('rooms').doc(docId).get();
      
//       if (!doc.exists) {
//         return Left('Không tìm thấy phòng $roomNumber');
//       }
      
//       return Right(Room.fromJson(doc.data()!));
//     } catch (e) {
//       return Left('Lỗi khi lấy thông tin phòng: ${e.toString()}');
//     }
//   }
  
//   @override
//   Future<Either<String, List<Room>>> getAvailableRooms(
//       String buildingCode, int floor, DateTime date, int startHour, int endHour) async {
//     try {
//       // Lấy tất cả các phòng trong tòa nhà và tầng
//       final allRoomsSnapshot = await _firestore.collection('rooms')
//           .where('buildingCode', isEqualTo: buildingCode)
//           .where('floor', isEqualTo: floor)
//           .where('status', isEqualTo: 'available') // Chỉ lấy các phòng có trạng thái available
//           .get();
      
//       if (allRoomsSnapshot.docs.isEmpty) {
//         return Left('Không tìm thấy phòng trống nào trong tòa $buildingCode tầng $floor');
//       }
      
//       // Chuyển đổi thành Room objects
//       final availableRooms = allRoomsSnapshot.docs
//           .map((doc) => Room.fromJson(doc.data()))
//           .toList();
      
//       return Right(availableRooms);
//     } catch (e) {
//       return Left('Lỗi khi lấy danh sách phòng trống: ${e.toString()}');
//     }
//   }
  
//   @override
//   Stream<List<Room>> streamRoomsByBuilding(String buildingCode) {
//     print('Streaming rooms for building: $buildingCode');
//     return _firestore.collection('rooms')
//         .where('buildingCode', isEqualTo: buildingCode)
//         .snapshots()
//         .map((snapshot) {
//           print('Room snapshot received: ${snapshot.docs.length} rooms');
//           return snapshot.docs.map((doc) {
//             print('Room data: ${doc.data()}');
//             return Room.fromJson(doc.data());
//           }).toList();
//         });
//   }
  
//   @override
//   Future<Either<String, bool>> updateRoomStatus(String buildingCode, String roomNumber, String status) async {
//     try {
//       // Tạo document ID theo format buildingCode_roomNumber
//       final docId = '${buildingCode}_${roomNumber}';
      
//       // Cập nhật trạng thái phòng
//       await _firestore.collection('rooms').doc(docId).update({
//         'status': status
//       });
      
//       print('Updated room status: $docId to $status');
      
//       return const Right(true);
//     } catch (e) {
//       print('Error updating room status: ${e.toString()}');
//       return Left('Lỗi khi cập nhật trạng thái phòng: ${e.toString()}');
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/models/room/room.dart';

abstract class RoomFirebaseService {
  Future<Either<String, List<Room>>> getRoomsByBuilding(String buildingCode);
  Future<Either<String, List<Room>>> getRoomsByBuildingAndFloor(String buildingCode, int floor);
  Future<Either<String, Room>> getRoomByNumber(String buildingCode, String roomNumber);
  Future<Either<String, List<Room>>> getAvailableRooms(String buildingCode, int floor, DateTime date, int startHour, int endHour);
  Stream<List<Room>> streamRoomsByBuilding(String buildingCode);
  Future<Either<String, bool>> updateRoomStatus(String buildingCode, String roomNumber, String status);
}

class RoomFirebaseServiceImpl implements RoomFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Either<String, List<Room>>> getRoomsByBuilding(String buildingCode) async {
    try {
      final snapshot = await _firestore.collection('rooms')
          .where('buildingCode', isEqualTo: buildingCode)
          .get();
      
      if (snapshot.docs.isEmpty) {
        return Left('Không tìm thấy phòng nào trong tòa $buildingCode');
      }
      
      final rooms = snapshot.docs
          .map((doc) => Room.fromJson(doc.data()))
          .toList();
      
      return Right(rooms);
    } catch (e) {
      return Left('Lỗi khi lấy danh sách phòng: ${e.toString()}');
    }
  }
  
  @override
  Future<Either<String, List<Room>>> getRoomsByBuildingAndFloor(String buildingCode, int floor) async {
    try {
      final snapshot = await _firestore.collection('rooms')
          .where('buildingCode', isEqualTo: buildingCode)
          .where('floor', isEqualTo: floor)
          .get();
      
      if (snapshot.docs.isEmpty) {
        return Left('Không tìm thấy phòng nào trong tòa $buildingCode tầng $floor');
      }
      
      final rooms = snapshot.docs
          .map((doc) => Room.fromJson(doc.data()))
          .toList();
      
      return Right(rooms);
    } catch (e) {
      return Left('Lỗi khi lấy danh sách phòng: ${e.toString()}');
    }
  }
  
  @override
  Future<Either<String, Room>> getRoomByNumber(String buildingCode, String roomNumber) async {
    try {
      final docId = '${buildingCode}_${roomNumber.replaceAll('.', '_')}';
      final doc = await _firestore.collection('rooms').doc(docId).get();
      
      if (!doc.exists) {
        return Left('Không tìm thấy phòng $roomNumber');
      }
      
      return Right(Room.fromJson(doc.data()!));
    } catch (e) {
      return Left('Lỗi khi lấy thông tin phòng: ${e.toString()}');
    }
  }
  
  @override
  Future<Either<String, List<Room>>> getAvailableRooms(
      String buildingCode, int floor, DateTime date, int startHour, int endHour) async {
    try {
      final allRoomsSnapshot = await _firestore.collection('rooms')
          .where('buildingCode', isEqualTo: buildingCode)
          .where('floor', isEqualTo: floor)
          .where('status', isEqualTo: 'available')
          .get();
      
      if (allRoomsSnapshot.docs.isEmpty) {
        return Left('Không tìm thấy phòng trống nào trong tòa $buildingCode tầng $floor');
      }
      
      final availableRooms = allRoomsSnapshot.docs
          .map((doc) => Room.fromJson(doc.data()))
          .toList();
      
      return Right(availableRooms);
    } catch (e) {
      return Left('Lỗi khi lấy danh sách phòng trống: ${e.toString()}');
    }
  }
  
  @override
  Stream<List<Room>> streamRoomsByBuilding(String buildingCode) {
    print('Streaming rooms for building: $buildingCode');
    return _firestore.collection('rooms')
        .where('buildingCode', isEqualTo: buildingCode)
        .snapshots()
        .map((snapshot) {
          print('Room snapshot received: ${snapshot.docs.length} rooms');
          return snapshot.docs.map((doc) {
            print('Room data: ${doc.data()}');
            return Room.fromJson(doc.data());
          }).toList();
        });
  }
  
  @override
  Future<Either<String, bool>> updateRoomStatus(String buildingCode, String roomNumber, String status) async {
    try {
      final docId = '${buildingCode}_${roomNumber.replaceAll('.', '_')}';
      
      final roomRef = _firestore.collection('rooms').doc(docId);
      final docSnapshot = await roomRef.get();

      if (!docSnapshot.exists) {
        return Left('Phòng $roomNumber trong tòa $buildingCode không tồn tại');
      }

      await roomRef.update({
        'status': status
      });
      
      print('Updated room status: $docId to $status');
      
      return const Right(true);
    } catch (e) {
      print('Error updating room status: ${e.toString()}');
      return Left('Lỗi khi cập nhật trạng thái phòng: ${e.toString()}');
    }
  }
}