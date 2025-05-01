// lib/data/sources/building/building_firebase_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/models/building/building.dart';

abstract class BuildingFirebaseService {
  Future<Either<String, List<Building>>> getBuildings();
  Future<Either<String, Building>> getBuildingByCode(String buildingCode);
}

class BuildingFirebaseServiceImpl implements BuildingFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Either<String, List<Building>>> getBuildings() async {
    try {
      final snapshot = await _firestore.collection('buildings').get();
      
      if (snapshot.docs.isEmpty) {
        return Left('Không tìm thấy tòa nhà nào');
      }
      
      final buildings = snapshot.docs
          .map((doc) => Building.fromJson(doc.data()))
          .toList();
      
      return Right(buildings);
    } catch (e) {
      return Left('Lỗi khi lấy danh sách tòa nhà: ${e.toString()}');
    }
  }
  
  @override
  Future<Either<String, Building>> getBuildingByCode(String buildingCode) async {
    try {
      final doc = await _firestore.collection('buildings').doc(buildingCode).get();
      
      if (!doc.exists) {
        return Left('Không tìm thấy tòa nhà với mã: $buildingCode');
      }
      
      return Right(Building.fromJson(doc.data()!));
    } catch (e) {
      return Left('Lỗi khi lấy thông tin tòa nhà: ${e.toString()}');
    }
  }
}