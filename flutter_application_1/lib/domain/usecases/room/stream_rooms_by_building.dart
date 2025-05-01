// import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/data/models/room/room.dart';
import 'package:flutter_application_1/domain/repository/room/room.dart';
import 'package:flutter_application_1/service_locator.dart';

class StreamRoomsByBuildingUseCase {
  Stream<List<Room>> call(String buildingCode) {
    return sl<RoomRepository>().streamRoomsByBuilding(buildingCode);
  }
}