// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/core/configs/theme/app_colors.dart';
// import 'package:flutter_application_1/data/models/booking/booking_request.dart';
// import 'package:flutter_application_1/data/models/room/room.dart';
// import 'package:flutter_application_1/domain/usecases/booking/create_booking.dart';
// import 'package:flutter_application_1/presentation/root/pages/root.dart';
// import 'package:flutter_application_1/service_locator.dart';
// import 'package:intl/intl.dart';

// class RoomDetailPage extends StatefulWidget {
//   final String buildingCode;
//   final String roomNumber;
//   final int floor;
//   final DateTime selectedDate;
//   final TimeOfDay selectedTime;
//   final int numberOfPeople;
//   final int duration;
//   final Room? room;

//   const RoomDetailPage({
//     Key? key,
//     required this.buildingCode,
//     required this.roomNumber,
//     required this.floor,
//     required this.selectedDate,
//     required this.selectedTime,
//     required this.numberOfPeople,
//     required this.duration,
//     this.room,
//   }) : super(key: key);

//   @override
//   State<RoomDetailPage> createState() => _RoomDetailPageState();
// }

// class _RoomDetailPageState extends State<RoomDetailPage> {
//   late int _numberOfPeople;
//   late int _duration;
//   bool _isLoading = false;
//   late Room _room;

//   @override
//   void initState() {
//     super.initState();
//     _numberOfPeople = widget.numberOfPeople;
//     _duration = widget.duration;
//     _room = widget.room ??
//         Room(
//           roomNumber: widget.roomNumber,
//           buildingCode: widget.buildingCode,
//           floor: widget.floor,
//           capacity: widget.numberOfPeople,
//           facilities: ['Máy chiếu', 'Bảng', 'Wifi'],
//           status: 'available',
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.primary,
//         title: Text('Chi tiết phòng ${widget.roomNumber}', style: const TextStyle(color: Colors.white)),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Card(
//                     elevation: 4,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.all(12),
//                                 decoration: BoxDecoration(
//                                   color: Colors.amber,
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: Text(
//                                   widget.roomNumber,
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 16),
//                               Container(
//                                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                                 decoration: BoxDecoration(
//                                   color: Colors.green,
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: const Text(
//                                   'Trống',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           _infoRow('Tòa nhà:', widget.buildingCode),
//                           _infoRow('Tầng:', '${widget.floor}'),
//                           _infoRow('Sức chứa:', '${_room.capacity} người'),
//                           const SizedBox(height: 12),
//                           const Text(
//                             'Trang thiết bị:',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Wrap(
//                             spacing: 8,
//                             runSpacing: 8,
//                             children: _room.facilities.map((facility) => Chip(
//                               backgroundColor: AppColors.lightBackground,
//                               side: const BorderSide(color: AppColors.primary),
//                               label: Text(facility),
//                               avatar: _getFacilityIcon(facility),
//                             )).toList(),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Card(
//                     elevation: 4,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Thông tin đặt phòng',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           _infoRow('Ngày đặt:', DateFormat('dd/MM/yyyy').format(widget.selectedDate)),
//                           _infoRow('Thời gian bắt đầu:', widget.selectedTime.format(context)),
//                           const SizedBox(height: 20),
//                           Row(
//                             children: [
//                               const Text(
//                                 'Số người:',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               const Spacer(),
//                               Text(
//                                 '$_numberOfPeople người',
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           Row(
//                             children: [
//                               const Text(
//                                 'Thời gian sử dụng (giờ):',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               const Spacer(),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey),
//                                   borderRadius: BorderRadius.circular(4),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     IconButton(
//                                       icon: const Icon(Icons.remove, size: 20),
//                                       padding: EdgeInsets.zero,
//                                       constraints: const BoxConstraints(),
//                                       onPressed: _duration > 1
//                                           ? () {
//                                               setState(() {
//                                                 _duration--;
//                                               });
//                                             }
//                                           : null,
//                                     ),
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(horizontal: 12),
//                                       child: Text(
//                                         '$_duration',
//                                         style: const TextStyle(fontSize: 16),
//                                       ),
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.add, size: 20),
//                                       padding: EdgeInsets.zero,
//                                       constraints: const BoxConstraints(),
//                                       onPressed: _duration < 8
//                                           ? () {
//                                               setState(() {
//                                                 _duration++;
//                                               });
//                                             }
//                                           : null,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           _infoRow(
//                             'Thời gian kết thúc:',
//                             _calculateEndTime(widget.selectedTime, _duration),
//                             valueColor: AppColors.primary,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: _handleBookingConfirmation,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.amber,
//                         foregroundColor: Colors.black,
//                         padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(Icons.check_circle_outline),
//                           SizedBox(width: 10),
//                           Text(
//                             'Xác nhận đặt phòng',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }

//   Widget _infoRow(String label, String value, {Color? valueColor}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Row(
//         children: [
//           Text(
//             label,
//             style: const TextStyle(
//               fontWeight: FontWeight.w500,
//               fontSize: 16,
//             ),
//           ),
//           const Spacer(),
//           Text(
//             value,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//               color: valueColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget? _getFacilityIcon(String facility) {
//     switch (facility.toLowerCase()) {
//       case 'máy chiếu':
//         return const Icon(Icons.video_label, size: 18);
//       case 'bảng':
//         return const Icon(Icons.dashboard, size: 18);
//       case 'wifi':
//         return const Icon(Icons.wifi, size: 18);
//       case 'máy tính':
//         return const Icon(Icons.computer, size: 18);
//       default:
//         return null;
//     }
//   }

//   String _calculateEndTime(TimeOfDay startTime, int duration) {
//     final int totalMinutes = startTime.hour * 60 + startTime.minute + duration * 60;
//     final int endHour = (totalMinutes ~/ 60) % 24;
//     final int endMinute = totalMinutes % 60;

//     final endTime = TimeOfDay(hour: endHour, minute: endMinute);
//     return endTime.format(context);
//   }

//   Future<void> _createNotification(String userId, String message) async {
//     await FirebaseFirestore.instance.collection('notifications').add({
//       'userId': userId,
//       'message': message,
//       'isRead': false,
//       'createdAt': Timestamp.now(),
//     });
//   }

//   Future<void> _scheduleReminder(String userId, BookingRequest booking) async {
//     final startDateTime = DateTime(
//       booking.bookingDate.year,
//       booking.bookingDate.month,
//       booking.bookingDate.day,
//       booking.startTime.hour,
//       booking.startTime.minute,
//     );
//     final reminderTime = startDateTime.subtract(const Duration(minutes: 60));

//     if (DateTime.now().isBefore(reminderTime)) {
//       await Future.delayed(reminderTime.difference(DateTime.now()));
//       await _createNotification(
//         userId,
//         'Nhắc nhở: Phòng ${booking.roomNumber} tại ${booking.buildingCode} sẽ bắt đầu vào ${booking.startTime.format(context)} ngày ${DateFormat('dd/MM/yyyy').format(booking.bookingDate)}',
//       );
//     }
//   }

//   Future<void> _handleBookingConfirmation() async {
//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Xác nhận đặt phòng'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('Bạn có chắc chắn muốn đặt phòng với thông tin sau:'),
//             const SizedBox(height: 10),
//             Text('- Phòng: ${widget.roomNumber}'),
//             Text('- Tòa: ${widget.buildingCode}'),
//             Text('- Tầng: ${widget.floor}'),
//             Text('- Ngày: ${DateFormat('dd/MM/yyyy').format(widget.selectedDate)}'),
//             Text('- Thời gian bắt đầu: ${widget.selectedTime.format(context)}'),
//             Text('- Thời gian kết thúc: ${_calculateEndTime(widget.selectedTime, _duration)}'),
//             Text('- Thời lượng: $_duration giờ'),
//             Text('- Số người: $_numberOfPeople người'),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: const Text('Hủy'),
//           ),
//           ElevatedButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.amber,
//             ),
//             child: const Text('Xác nhận'),
//           ),
//         ],
//       ),
//     );

//     if (confirmed != true) return;

//     setState(() {
//       _isLoading = true;
//     });

//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       setState(() {
//         _isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Bạn chưa đăng nhập')),
//       );
//       return;
//     }

//     final bookingRequest = BookingRequest(
//       userId: user.uid,
//       userName: user.displayName,
//       userEmail: user.email ?? 'Không có email',
//       buildingCode: widget.buildingCode,
//       roomNumber: widget.roomNumber,
//       floor: widget.floor,
//       bookingDate: widget.selectedDate,
//       startTime: widget.selectedTime,
//       duration: _duration,
//       numberOfPeople: _numberOfPeople,
//     );

//     final result = await sl<CreateBookingUseCase>().call(bookingRequest);

//     setState(() {
//       _isLoading = false;
//     });

//     result.fold(
//       (error) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(error)),
//         );
//       },
//       (bookingId) async {
//         await _createNotification(
//           user.uid,
//           'Bạn đã đặt phòng ${widget.roomNumber} tại ${widget.buildingCode} vào ${DateFormat('dd/MM/yyyy').format(widget.selectedDate)} lúc ${widget.selectedTime.format(context)}',
//         );

//         await _scheduleReminder(user.uid, bookingRequest);

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Đặt phòng thành công!'),
//             backgroundColor: Colors.green,
//           ),
//         );

//         // Add a slight delay to ensure Firestore syncs the notification
//         await Future.delayed(const Duration(seconds: 2));

//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const RootPage(message: 'Đặt phòng thành công!')),
//           (route) => false,
//         );
//       },
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/configs/theme/app_colors.dart';
import 'package:flutter_application_1/data/models/booking/booking_request.dart';
import 'package:flutter_application_1/data/models/room/room.dart';
import 'package:flutter_application_1/domain/usecases/booking/create_booking.dart';
import 'package:flutter_application_1/presentation/root/pages/root.dart';
import 'package:flutter_application_1/service_locator.dart';
import 'package:intl/intl.dart';

class RoomDetailPage extends StatefulWidget {
  final String buildingCode;
  final String roomNumber;
  final int floor;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final int numberOfPeople;
  final int duration;
  final Room? room;

  const RoomDetailPage({
    Key? key,
    required this.buildingCode,
    required this.roomNumber,
    required this.floor,
    required this.selectedDate,
    required this.selectedTime,
    required this.numberOfPeople,
    required this.duration,
    this.room,
  }) : super(key: key);

  @override
  State<RoomDetailPage> createState() => _RoomDetailPageState();
}

class _RoomDetailPageState extends State<RoomDetailPage> {
  late int _numberOfPeople;
  late int _duration;
  bool _isLoading = false;
  late Room _room;

  @override
  void initState() {
    super.initState();
    _numberOfPeople = widget.numberOfPeople;
    _duration = widget.duration;
    _room = widget.room ??
        Room(
          roomNumber: widget.roomNumber,
          buildingCode: widget.buildingCode,
          floor: widget.floor,
          capacity: widget.numberOfPeople,
          facilities: ['Máy chiếu', 'Bảng', 'Wifi'],
          status: 'available',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text('Chi tiết phòng ${widget.roomNumber}', style: const TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  widget.roomNumber,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'Trống',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _infoRow('Tòa nhà:', widget.buildingCode),
                          _infoRow('Tầng:', '${widget.floor}'),
                          _infoRow('Sức chứa:', '${_room.capacity} người'),
                          const SizedBox(height: 12),
                          const Text(
                            'Trang thiết bị:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _room.facilities.map((facility) => Chip(
                              backgroundColor: AppColors.lightBackground,
                              side: const BorderSide(color: AppColors.primary),
                              label: Text(facility),
                              avatar: _getFacilityIcon(facility),
                            )).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Thông tin đặt phòng',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _infoRow('Ngày đặt:', DateFormat('dd/MM/yyyy').format(widget.selectedDate)),
                          _infoRow('Thời gian bắt đầu:', widget.selectedTime.format(context)),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Text(
                                'Số người:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '$_numberOfPeople người',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Text(
                                'Thời gian sử dụng (giờ):',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove, size: 20),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: _duration > 1
                                          ? () {
                                              setState(() {
                                                _duration--;
                                              });
                                            }
                                          : null,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      child: Text(
                                        '$_duration',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add, size: 20),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: _duration < 8
                                          ? () {
                                              setState(() {
                                                _duration++;
                                              });
                                            }
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _infoRow(
                            'Thời gian kết thúc:',
                            _calculateEndTime(widget.selectedTime, _duration),
                            valueColor: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: _handleBookingConfirmation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle_outline),
                          SizedBox(width: 10),
                          Text(
                            'Xác nhận đặt phòng',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _infoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget? _getFacilityIcon(String facility) {
    switch (facility.toLowerCase()) {
      case 'máy chiếu':
        return const Icon(Icons.video_label, size: 18);
      case 'bảng':
        return const Icon(Icons.dashboard, size: 18);
      case 'wifi':
        return const Icon(Icons.wifi, size: 18);
      case 'máy tính':
        return const Icon(Icons.computer, size: 18);
      default:
        return null;
    }
  }

  String _calculateEndTime(TimeOfDay startTime, int duration) {
    final int totalMinutes = startTime.hour * 60 + startTime.minute + duration * 60;
    final int endHour = (totalMinutes ~/ 60) % 24;
    final int endMinute = totalMinutes % 60;

    final endTime = TimeOfDay(hour: endHour, minute: endMinute);
    return endTime.format(context);
  }

  Future<void> _createNotification(String userId, String message) async {
    await FirebaseFirestore.instance.collection('notifications').add({
      'userId': userId,
      'message': message,
      'isRead': false,
      'createdAt': Timestamp.now(),
    });
  }

  Future<void> _scheduleReminder(String userId, BookingRequest booking) async {
    final startDateTime = DateTime(
      booking.bookingDate.year,
      booking.bookingDate.month,
      booking.bookingDate.day,
      booking.startTime.hour,
      booking.startTime.minute,
    );

    final now = DateTime.now();
    final differenceInMinutes = startDateTime.difference(now).inMinutes;
    final reminderTime = startDateTime.subtract(const Duration(minutes: 60));

    // Nếu thời gian bắt đầu còn dưới 60 phút, gửi thông báo ngay lập tức
    if (differenceInMinutes < 60 && differenceInMinutes > 0) {
      await _createNotification(
        userId,
        'Nhắc nhở: Phòng ${booking.roomNumber} tại ${booking.buildingCode} sẽ bắt đầu vào ${booking.startTime.format(context)} ngày ${DateFormat('dd/MM/yyyy').format(booking.bookingDate)}',
      );
    }
    // Nếu thời gian còn trên 60 phút, lập lịch gửi thông báo trước 60 phút
    else if (now.isBefore(reminderTime)) {
      await Future.delayed(reminderTime.difference(now));
      await _createNotification(
        userId,
        'Nhắc nhở: Phòng ${booking.roomNumber} tại ${booking.buildingCode} sẽ bắt đầu vào ${booking.startTime.format(context)} ngày ${DateFormat('dd/MM/yyyy').format(booking.bookingDate)}',
      );
    }
  }

  Future<void> _handleBookingConfirmation() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận đặt phòng'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Bạn có chắc chắn muốn đặt phòng với thông tin sau:'),
            const SizedBox(height: 10),
            Text('- Phòng: ${widget.roomNumber}'),
            Text('- Tòa: ${widget.buildingCode}'),
            Text('- Tầng: ${widget.floor}'),
            Text('- Ngày: ${DateFormat('dd/MM/yyyy').format(widget.selectedDate)}'),
            Text('- Thời gian bắt đầu: ${widget.selectedTime.format(context)}'),
            Text('- Thời gian kết thúc: ${_calculateEndTime(widget.selectedTime, _duration)}'),
            Text('- Thời lượng: $_duration giờ'),
            Text('- Số người: $_numberOfPeople người'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
            ),
            child: const Text('Xác nhận'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() {
      _isLoading = true;
    });

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bạn chưa đăng nhập')),
      );
      return;
    }

    final bookingRequest = BookingRequest(
      userId: user.uid,
      userName: user.displayName,
      userEmail: user.email ?? 'Không có email',
      buildingCode: widget.buildingCode,
      roomNumber: widget.roomNumber,
      floor: widget.floor,
      bookingDate: widget.selectedDate,
      startTime: widget.selectedTime,
      duration: _duration,
      numberOfPeople: _numberOfPeople,
    );

    final result = await sl<CreateBookingUseCase>().call(bookingRequest);

    setState(() {
      _isLoading = false;
    });

    result.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      },
      (bookingId) async {
        await _createNotification(
          user.uid,
          'Bạn đã đặt phòng ${widget.roomNumber} tại ${widget.buildingCode} vào ${DateFormat('dd/MM/yyyy').format(widget.selectedDate)} lúc ${widget.selectedTime.format(context)}',
        );

        await _scheduleReminder(user.uid, bookingRequest);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đặt phòng thành công!'),
            backgroundColor: Colors.green,
          ),
        );

        // Add a slight delay to ensure Firestore syncs the notification
        await Future.delayed(const Duration(seconds: 2));

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const RootPage(message: 'Đặt phòng thành công!')),
          (route) => false,
        );
      },
    );
  }
}