import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/data/models/building/building.dart';
import 'package:flutter_application_1/domain/repository/building/building.dart';
import 'package:flutter_application_1/service_locator.dart';

class GetBuildingByCodeUseCase implements UseCase<Either<String, Building>, String> {
  @override
  Future<Either<String, Building>> call(String buildingCode) async {
    return await sl<BuildingRepository>().getBuildingByCode(buildingCode);
  }
}