// lib/domain/repository/room/room.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/models/room/room.dart';

abstract class RoomRepository {
  Future<Either<String, List<Room>>> getRoomsByBuilding(String buildingCode);
  Future<Either<String, List<Room>>> getRoomsByBuildingAndFloor(String buildingCode, int floor);
  Future<Either<String, Room>> getRoomByNumber(String buildingCode, String roomNumber);
  Future<Either<String, List<Room>>> getAvailableRooms(String buildingCode, int floor, DateTime date, int startHour, int endHour);
  Stream<List<Room>> streamRoomsByBuilding(String buildingCode);
  
  // Thêm phương thức mới để cập nhật trạng thái phòng
  Future<Either<String, bool>> updateRoomStatus(String buildingCode, String roomNumber, String status);
}
