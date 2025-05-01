import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/booking/booking_request.dart';

abstract class BookingRepository {
  Future<Either<String, String>> createBooking(BookingRequest bookingRequest);
  Future<Either<String, bool>> checkRoomAvailability(
      String buildingCode, String roomNumber, DateTime date, TimeOfDay startTime, int duration, int numberOfPeople);
  Stream<List<BookingRequest>> streamUserBookings(String userId);
  Stream<List<BookingRequest>> streamRoomBookings(String buildingCode, String roomNumber);
  Future<Either<String, List<BookingRequest>>> getBookings();
  Future<Either<String, void>> updateBooking(BookingRequest booking);
  Future<Either<String, void>> deleteBooking(BookingRequest booking);
}