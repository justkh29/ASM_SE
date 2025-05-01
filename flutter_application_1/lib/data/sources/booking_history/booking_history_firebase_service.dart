// // lib/data/sources/booking_history/booking_history_firebase_service.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_application_1/data/models/booking_history/booking_history_model.dart';

// abstract class BookingHistoryFirebaseService {
//   Future<List<BookingHistoryModel>> fetchBookingHistory();
//   Future<bool> cancelBooking(String bookingId);
//   Future<List<BookingHistoryModel>> fetchBookingsByStatus(String status);
// }

// class BookingHistoryFirebaseServiceImpl implements BookingHistoryFirebaseService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   Future<List<BookingHistoryModel>> fetchBookingHistory() async {
//     try {
//       final userId = _auth.currentUser?.uid;
//       if (userId == null) {
//         throw Exception('User not logged in');
//       }

//       final querySnapshot = await _firestore
//           .collection('bookings')
//           .where('userId', isEqualTo: userId)
//           .orderBy('createdAt', descending: true)
//           .get();

//       return querySnapshot.docs.map((doc) {
//         return BookingHistoryModel.fromFirestore(doc.data(), doc.id);
//       }).toList();
//     } catch (e) {
//       print('Error fetching booking history: $e');
//       throw Exception('Failed to fetch booking history: $e');
//     }
//   }

//   @override
//   Future<bool> cancelBooking(String bookingId) async {
//     try {
//       final userId = _auth.currentUser?.uid;
//       if (userId == null) {
//         throw Exception('User not logged in');
//       }

//       // Verify this booking belongs to the current user
//       final bookingDoc = await _firestore.collection('bookings').doc(bookingId).get();
      
//       if (!bookingDoc.exists) {
//         throw Exception('Booking not found');
//       }
      
//       final data = bookingDoc.data();
//       if (data == null || data['userId'] != userId) {
//         throw Exception('Unauthorized to cancel this booking');
//       }

//       // Update booking status
//       await _firestore.collection('bookings').doc(bookingId).update({
//         'status': 'cancelled',
//         'cancelledAt': DateTime.now().toIso8601String(),
//       });

//       return true;
//     } catch (e) {
//       print('Error cancelling booking: $e');
//       throw Exception('Failed to cancel booking: $e');
//     }
//   }

//   @override
//   Future<List<BookingHistoryModel>> fetchBookingsByStatus(String status) async {
//     try {
//       final userId = _auth.currentUser?.uid;
//       if (userId == null) {
//         throw Exception('User not logged in');
//       }

//       final querySnapshot = await _firestore
//           .collection('bookings')
//           .where('userId', isEqualTo: userId)
//           .where('status', isEqualTo: status)
//           .orderBy('createdAt', descending: true)
//           .get();

//       return querySnapshot.docs.map((doc) {
//         return BookingHistoryModel.fromFirestore(doc.data(), doc.id);
//       }).toList();
//     } catch (e) {
//       print('Error fetching bookings by status: $e');
//       throw Exception('Failed to fetch bookings by status: $e');
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/data/models/booking_history/booking_history_model.dart';

abstract class BookingHistoryFirebaseService {
  Future<List<BookingHistoryModel>> fetchBookingHistory();
  Future<bool> cancelBooking(String bookingId);
  Future<List<BookingHistoryModel>> fetchBookingsByStatus(String status);
}

class BookingHistoryFirebaseServiceImpl implements BookingHistoryFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<List<BookingHistoryModel>> fetchBookingHistory() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        throw Exception('User not logged in');
      }

      final querySnapshot = await _firestore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .get(); // Bỏ orderBy để tránh lỗi index

      return querySnapshot.docs.map((doc) {
        return BookingHistoryModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching booking history: $e');
      throw Exception('Failed to fetch booking history: $e');
    }
  }

  @override
  Future<bool> cancelBooking(String bookingId) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        throw Exception('User not logged in');
      }

      final bookingDoc = await _firestore.collection('bookings').doc(bookingId).get();
      
      if (!bookingDoc.exists) {
        throw Exception('Booking not found');
      }
      
      final data = bookingDoc.data();
      if (data == null || data['userId'] != userId) {
        throw Exception('Unauthorized to cancel this booking');
      }

      await _firestore.collection('bookings').doc(bookingId).update({
        'status': 'cancelled',
        'cancelledAt': DateTime.now().toIso8601String(),
      });

      return true;
    } catch (e) {
      print('Error cancelling booking: $e');
      throw Exception('Failed to cancel booking: $e');
    }
  }

  @override
  Future<List<BookingHistoryModel>> fetchBookingsByStatus(String status) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        throw Exception('User not logged in');
      }

      final querySnapshot = await _firestore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: status)
          .get(); // Bỏ orderBy để tránh lỗi index

      return querySnapshot.docs.map((doc) {
        return BookingHistoryModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching bookings by status: $e');
      throw Exception('Failed to fetch bookings by status: $e');
    }
  }
}