import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/data/models/room/room.dart';
import 'package:flutter_application_1/domain/repository/room/room.dart';
import 'package:flutter_application_1/service_locator.dart';

class GetRoomsByBuildingUseCase implements UseCase<Either<String, List<Room>>, String> {
  @override
  Future<Either<String, List<Room>>> call(String buildingCode) async {
    return await sl<RoomRepository>().getRoomsByBuilding(buildingCode);
  }
}
