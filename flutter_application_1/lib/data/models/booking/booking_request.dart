import 'package:flutter/material.dart';

class BookingRequest {
  final String userId;
  final String? userName; // Thêm trường userName
  final String userEmail; // Thêm trường userEmail
  final String buildingCode;
  final String roomNumber;
  final int floor;
  final DateTime bookingDate;
  final TimeOfDay startTime;
  final int duration; // Thời gian sử dụng tính bằng giờ
  final int numberOfPeople;
  final String? status; // 'pending', 'confirmed', 'checked_in', 'completed', 'cancelled'
  final DateTime? createdAt;
  final String? checkInCode; // Thêm trường checkInCode

  BookingRequest({
    required this.userId,
    this.userName, // Thêm vào constructor
    required this.userEmail, // Thêm vào constructor
    required this.buildingCode,
    required this.roomNumber,
    required this.floor,
    required this.bookingDate,
    required this.startTime,
    required this.duration,
    required this.numberOfPeople,
    this.status,
    this.createdAt,
    this.checkInCode, // Thêm vào constructor
  });

  TimeOfDay get endTime {
    final int totalMinutes = startTime.hour * 60 + startTime.minute + duration * 60;
    final int endHour = (totalMinutes ~/ 60) % 24;
    final int endMinute = totalMinutes % 60;
    return TimeOfDay(hour: endHour, minute: endMinute);
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName, // Lưu userName vào Firestore
      'userEmail': userEmail, // Lưu userEmail vào Firestore
      'buildingCode': buildingCode,
      'roomNumber': roomNumber,
      'floor': floor,
      'bookingDate': bookingDate.toIso8601String(),
      'startTime': {
        'hour': startTime.hour,
        'minute': startTime.minute,
      },
      'endTime': {
        'hour': endTime.hour,
        'minute': endTime.minute,
      },
      'duration': duration,
      'numberOfPeople': numberOfPeople,
      'status': status,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (checkInCode != null) 'checkInCode': checkInCode, // Lưu checkInCode vào Firestore
    };
  }

  factory BookingRequest.fromJson(Map<String, dynamic> json) {
    final startTimeMap = json['startTime'] as Map<String, dynamic>;
    
    return BookingRequest(
      userId: json['userId'] ?? '',
      userName: json['userName'], // Parse userName từ Firestore
      userEmail: json['userEmail'] ?? '', // Parse userEmail từ Firestore
      buildingCode: json['buildingCode'] ?? '',
      roomNumber: json['roomNumber'] ?? '',
      floor: json['floor'] ?? 0,
      bookingDate: DateTime.parse(json['bookingDate']),
      startTime: TimeOfDay(
        hour: startTimeMap['hour'] ?? 0,
        minute: startTimeMap['minute'] ?? 0,
      ),
      duration: json['duration'] ?? 1,
      numberOfPeople: json['numberOfPeople'] ?? 1,
      status: json['status'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      checkInCode: json['checkInCode'], // Parse checkInCode từ Firestore
    );
  }
}