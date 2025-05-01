// lib/domain/repository/building/building.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/models/building/building.dart';

abstract class BuildingRepository {
  Future<Either<String, List<Building>>> getBuildings();
  Future<Either<String, Building>> getBuildingByCode(String buildingCode);
}

