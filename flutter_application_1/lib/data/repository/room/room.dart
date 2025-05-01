// lib/data/repository/room/room_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/models/room/room.dart';
import 'package:flutter_application_1/data/sources/room/room_firebase_service.dart';
import 'package:flutter_application_1/domain/repository/room/room.dart';
import 'package:flutter_application_1/service_locator.dart';

class RoomRepositoryImpl implements RoomRepository {
  @override
  Future<Either<String, List<Room>>> getRoomsByBuilding(String buildingCode) async {
    return await sl<RoomFirebaseService>().getRoomsByBuilding(buildingCode);
  }
  
  @override
  Future<Either<String, List<Room>>> getRoomsByBuildingAndFloor(String buildingCode, int floor) async {
    return await sl<RoomFirebaseService>().getRoomsByBuildingAndFloor(buildingCode, floor);
  }
  
  @override
  Future<Either<String, Room>> getRoomByNumber(String buildingCode, String roomNumber) async {
    return await sl<RoomFirebaseService>().getRoomByNumber(buildingCode, roomNumber);
  }
  
  @override
  Future<Either<String, List<Room>>> getAvailableRooms(String buildingCode, int floor, DateTime date, int startHour, int endHour) async {
    return await sl<RoomFirebaseService>().getAvailableRooms(buildingCode, floor, date, startHour, endHour);
  }
  
  @override
  Stream<List<Room>> streamRoomsByBuilding(String buildingCode) {
    return sl<RoomFirebaseService>().streamRoomsByBuilding(buildingCode);
  }
  
  @override
  Future<Either<String, bool>> updateRoomStatus(String buildingCode, String roomNumber, String status) async {
    return await sl<RoomFirebaseService>().updateRoomStatus(buildingCode, roomNumber, status);
  }
}