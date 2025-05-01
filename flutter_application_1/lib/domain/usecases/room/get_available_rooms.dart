import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/data/models/room/room.dart';
import 'package:flutter_application_1/domain/repository/room/room.dart';
import 'package:flutter_application_1/service_locator.dart';

class GetAvailableRoomsParams {
  final String buildingCode;
  final int floor;
  final DateTime date;
  final int startHour;
  final int endHour;
  
  GetAvailableRoomsParams({
    required this.buildingCode,
    required this.floor,
    required this.date,
    required this.startHour,
    required this.endHour,
  });
}

class GetAvailableRoomsUseCase implements UseCase<Either<String, List<Room>>, GetAvailableRoomsParams> {
  @override
  Future<Either<String, List<Room>>> call(GetAvailableRoomsParams params) async {
    return await sl<RoomRepository>().getAvailableRooms(
      params.buildingCode,
      params.floor,
      params.date,
      params.startHour,
      params.endHour,
    );
  }
}
