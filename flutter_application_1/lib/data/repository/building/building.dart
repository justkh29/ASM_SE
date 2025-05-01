// lib/data/repository/building/building_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/models/building/building.dart';
import 'package:flutter_application_1/data/sources/building/building_firebase_service.dart';
import 'package:flutter_application_1/domain/repository/building/building.dart';
import 'package:flutter_application_1/service_locator.dart';

class BuildingRepositoryImpl implements BuildingRepository {
  @override
  Future<Either<String, List<Building>>> getBuildings() async {
    return await sl<BuildingFirebaseService>().getBuildings();
  }
  
  @override
  Future<Either<String, Building>> getBuildingByCode(String buildingCode) async {
    return await sl<BuildingFirebaseService>().getBuildingByCode(buildingCode);
  }
}