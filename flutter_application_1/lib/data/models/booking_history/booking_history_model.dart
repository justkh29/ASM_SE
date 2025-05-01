// // lib/data/models/booking_history/booking_history_model.dart
// import 'package:flutter/material.dart';

// class BookingHistoryModel {
//   final String id;
//   final String userId;
//   final String buildingCode;
//   final int floor;
//   final String roomId;
//   final DateTime bookingDate;
//   final TimeOfDay startTime;
//   final int duration;
//   final int numberOfPeople;
//   final String status;
//   final DateTime createdAt;
//   final DateTime? cancelledAt;

//   BookingHistoryModel({
//     required this.id,
//     required this.userId,
//     required this.buildingCode,
//     required this.floor,
//     required this.roomId,
//     required this.bookingDate,
//     required this.startTime,
//     required this.duration,
//     required this.numberOfPeople,
//     required this.status,
//     required this.createdAt,
//     this.cancelledAt,
//   });

//   // Factory constructor to create BookingHistoryModel from Firestore document
//   factory BookingHistoryModel.fromFirestore(Map<String, dynamic> doc, String docId) {
//     // Parse the booking date
//     final bookingDate = DateTime.parse(doc['bookingDate']);
    
//     // Parse the start time
//     final startTimeMap = doc['startTime'];
//     final startTime = TimeOfDay(
//       hour: startTimeMap['hour'],
//       minute: startTimeMap['minute'],
//     );
    
//     // Parse created at timestamp
//     final createdAt = DateTime.parse(doc['createdAt']);
    
//     // Parse cancelled at timestamp if available
//     DateTime? cancelledAt;
//     if (doc['cancelledAt'] != null) {
//       cancelledAt = DateTime.parse(doc['cancelledAt']);
//     }

//     return BookingHistoryModel(
//       id: docId,
//       userId: doc['userId'] ?? '',
//       buildingCode: doc['buildingCode'] ?? '',
//       floor: doc['floor'] ?? 0,
//       roomId: doc['roomId'] ?? '',
//       bookingDate: bookingDate,
//       startTime: startTime,
//       duration: doc['duration'] ?? 1,
//       numberOfPeople: doc['numberOfPeople'] ?? 1,
//       status: doc['status'] ?? 'pending',
//       createdAt: createdAt,
//       cancelledAt: cancelledAt,
//     );
//   }

//   // Convert BookingHistoryModel to Map for use with Firestore
//   Map<String, dynamic> toFirestore() {
//     return {
//       'userId': userId,
//       'buildingCode': buildingCode,
//       'floor': floor,
//       'roomId': roomId,
//       'bookingDate': bookingDate.toIso8601String(),
//       'startTime': {
//         'hour': startTime.hour,
//         'minute': startTime.minute,
//       },
//       'duration': duration,
//       'numberOfPeople': numberOfPeople,
//       'status': status,
//       'createdAt': createdAt.toIso8601String(),
//       if (cancelledAt != null) 'cancelledAt': cancelledAt!.toIso8601String(),
//     };
//   }

//   // Calculate end time based on start time and duration
//   TimeOfDay get endTime {
//     final endHour = (startTime.hour + duration) % 24;
//     return TimeOfDay(hour: endHour, minute: startTime.minute);
//   }

//   // Get status text
//   String get statusText {
//     switch (status) {
//       case 'confirmed':
//         return 'Đã xác nhận';
//       case 'completed':
//         return 'Đã hoàn thành';
//       case 'cancelled':
//         return 'Đã hủy';
//       case 'pending':
//       default:
//         return 'Đang chờ';
//     }
//   }

//   // Get color based on status
//   Color get statusColor {
//     switch (status) {
//       case 'confirmed':
//         return Colors.green;
//       case 'completed':
//         return Colors.blue;
//       case 'cancelled':
//         return Colors.red;
//       case 'pending':
//       default:
//         return Colors.orange;
//     }
//   }
// }

import 'package:flutter/material.dart';

class BookingHistoryModel {
  final String id;
  final String userId;
  final String buildingCode;
  final int floor;
  final String roomId;
  final DateTime bookingDate;
  final TimeOfDay startTime;
  final int duration;
  final int numberOfPeople;
  final String status;
  final DateTime createdAt;
  final DateTime? cancelledAt;

  BookingHistoryModel({
    required this.id,
    required this.userId,
    required this.buildingCode,
    required this.floor,
    required this.roomId,
    required this.bookingDate,
    required this.startTime,
    required this.duration,
    required this.numberOfPeople,
    required this.status,
    required this.createdAt,
    this.cancelledAt,
  });

  factory BookingHistoryModel.fromFirestore(Map<String, dynamic> doc, String docId) {
    final bookingDate = DateTime.parse(doc['bookingDate'] ?? DateTime.now().toIso8601String());
    
    final startTimeMap = doc['startTime'] ?? {'hour': 0, 'minute': 0};
    final startTime = TimeOfDay(
      hour: startTimeMap['hour'] ?? 0,
      minute: startTimeMap['minute'] ?? 0,
    );
    
    final createdAt = DateTime.parse(doc['createdAt'] ?? DateTime.now().toIso8601String());
    
    DateTime? cancelledAt;
    if (doc['cancelledAt'] != null) {
      cancelledAt = DateTime.parse(doc['cancelledAt']);
    }

    return BookingHistoryModel(
      id: docId,
      userId: doc['userId'] ?? '',
      buildingCode: doc['buildingCode'] ?? '',
      floor: doc['floor'] ?? 0,
      roomId: doc['roomNumber'] ?? doc['roomId'] ?? '', // Thêm roomNumber để tương thích với BookingRequest
      bookingDate: bookingDate,
      startTime: startTime,
      duration: doc['duration'] ?? 1,
      numberOfPeople: doc['numberOfPeople'] ?? 1,
      status: doc['status'] ?? 'pending',
      createdAt: createdAt,
      cancelledAt: cancelledAt,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'buildingCode': buildingCode,
      'floor': floor,
      'roomId': roomId,
      'bookingDate': bookingDate.toIso8601String(),
      'startTime': {
        'hour': startTime.hour,
        'minute': startTime.minute,
      },
      'duration': duration,
      'numberOfPeople': numberOfPeople,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      if (cancelledAt != null) 'cancelledAt': cancelledAt!.toIso8601String(),
    };
  }

  TimeOfDay get endTime {
    final totalMinutes = startTime.hour * 60 + startTime.minute + duration * 60;
    final endHour = (totalMinutes ~/ 60) % 24;
    final endMinute = totalMinutes % 60;
    return TimeOfDay(hour: endHour, minute: endMinute);
  }

  String get statusText {
    switch (status) {
      case 'confirmed':
        return 'Đã xác nhận';
      case 'completed':
        return 'Đã hoàn thành';
      case 'cancelled':
        return 'Đã hủy';
      case 'pending':
      default:
        return 'Đang chờ';
    }
  }

  Color get statusColor {
    switch (status) {
      case 'confirmed':
        return Colors.green;
      case 'completed':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      case 'pending':
      default:
        return Colors.orange;
    }
  }
}