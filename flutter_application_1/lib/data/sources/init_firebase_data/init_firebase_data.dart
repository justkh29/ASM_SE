// // lib/data/sources/init_firebase_data.dart
// import 'package:cloud_firestore/cloud_firestore.dart';

// class InitFirebaseData {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> initializeData() async {
//     await _initBuildings();
//     await _initRooms();
//   }

//   Future<void> _initBuildings() async {
//     // Kiểm tra xem đã có dữ liệu chưa
//     final snapshot = await _firestore.collection('buildings').get();
//     if (snapshot.docs.isNotEmpty) return;

//     // Tạo các tòa nhà H1, H2, H3
//     final buildings = [
//       {
//         'buildingCode': 'H1',
//         'name': 'Tòa H1 - Khu học tập',
//         'floors': 2,
//         'totalRooms': 5,
//       },
//       {
//         'buildingCode': 'H2',
//         'name': 'Tòa H2 - Khu nghiên cứu',
//         'floors': 2,
//         'totalRooms': 5,
//       },
//       {
//         'buildingCode': 'H3',
//         'name': 'Tòa H3 - Khu thực hành',
//         'floors': 2,
//         'totalRooms': 5,
//       },
//       {
//         'buildingCode': 'H6',
//         'name': 'Tòa H6 - Khu học tậptập',
//         'floors': 2,
//         'totalRooms': 5,
//       },
//       {
//         'buildingCode': 'Stadium',
//         'name': 'Stadium - Khu thể dục thể thao',
//         'floors': 2,
//         'totalRooms': 5,
//       },
//     ];

//     // Thêm dữ liệu vào Firestore
//     for (var building in buildings) {
//       await _firestore.collection('buildings').doc(building['buildingCode'].toString()).set(building);
//     }
//   }

//   Future<void> _initRooms() async {
//     // Kiểm tra xem đã có dữ liệu chưa
//     final snapshot = await _firestore.collection('rooms').get();
//     if (snapshot.docs.isNotEmpty) return;

//     final rooms = [
//   // Tòa H1
//   {
//     'roomNumber': 'H1.101',
//     'buildingCode': 'H1',
//     'floor': 1,
//     'capacity': 50,
//     'facilities': ['Máy chiếu', 'Bảng', 'Wifi'],
//     'status': 'available',
//   },
//   {
//     'roomNumber': 'H1.102',
//     'buildingCode': 'H1',
//     'floor': 1,
//     'capacity': 10,
//     'facilities': ['Máy chiếu', 'Bảng', 'Wifi', 'Máy tính'],
//     'status': 'available',
//   },
//   {
//     'roomNumber': 'H1.201',
//     'buildingCode': 'H1',
//     'floor': 2,
//     'capacity': 60,
//     'facilities': ['Máy chiếu', 'Bảng'],
//     'status': 'available',
//   },
//   {
//     'roomNumber': 'H1.202',
//     'buildingCode': 'H1',
//     'floor': 2,
//     'capacity': 40,
//     'facilities': ['Máy chiếu', 'Wifi'],
//     'status': 'available',
//   },
//   {
//     'roomNumber': 'H1.203',
//     'buildingCode': 'H1',
//     'floor': 2,
//     'capacity': 10,
//     'facilities': ['Bảng', 'Wifi'],
//     'status': 'available',
//   },

//   // Tòa H2
//   {
//     'roomNumber': 'H2.101',
//     'buildingCode': 'H2',
//     'floor': 1,
//     'capacity': 40,
//     'facilities': ['Máy chiếu', 'Wifi'],
//     'status': 'available',
//   },
//   {
//     'roomNumber': 'H2.102',
//     'buildingCode': 'H2',
//     'floor': 1,
//     'capacity': 60,
//     'facilities': ['Bảng', 'Wifi', 'Máy tính'],
//     'status': 'available',
//   },
//   {
//     'roomNumber': 'H2.201',
//     'buildingCode': 'H2',
//     'floor': 2,
//     'capacity': 10,
//     'facilities': ['Máy chiếu', 'Bảng'],
//     'status': 'available',
//   },
//   {
//     'roomNumber': 'H2.202',
//     'buildingCode': 'H2',
//     'floor': 2,
//     'capacity': 50,
//     'facilities': ['Máy chiếu', 'Wifi', 'Máy tính'],
//     'status': 'available',
//   },
//   {
//     'roomNumber': 'H2.203',
//     'buildingCode': 'H2',
//     'floor': 2,
//     'capacity': 10,
//     'facilities': ['Wifi'],
//     'status': 'available',
//   },

//   // Tòa H3
//   {
//     'roomNumber': 'H3.101',
//     'buildingCode': 'H3',
//     'floor': 1,
//     'capacity': 60,
//     'facilities': ['Bảng', 'Máy tính'],
//     'status': 'available',
//   },
//   {
//     'roomNumber': 'H3.102',
//     'buildingCode': 'H3',
//     'floor': 1,
//     'capacity': 50,
//     'facilities': ['Máy chiếu', 'Bảng', 'Wifi'],
//     'status': 'available',
//   },
//   {
//     'roomNumber': 'H3.201',
//     'buildingCode': 'H3',
//     'floor': 2,
//     'capacity': 10,
//     'facilities': ['Wifi', 'Máy tính'],
//     'status': 'available',
//   },
//   {
//     'roomNumber': 'H3.202',
//     'buildingCode': 'H3',
//     'floor': 2,
//     'capacity': 40,
//     'facilities': ['Máy chiếu', 'Bảng'],
//     'status': 'available',
//   },
//   {
//     'roomNumber': 'H3.203',
//     'buildingCode': 'H3',
//     'floor': 2,
//     'capacity': 10,
//     'facilities': ['Bảng'],
//     'status': 'available',
//   },

//   // Tòa H6
//   {
//     'roomNumber': 'H6.101',
//     'buildingCode': 'H6',
//     'floor': 1,
//     'capacity': 10,
//     'facilities': ['Máy chiếu', 'Bảng', 'Wifi'],
//     'status': 'available',
//   },
//   {
//     'roomNumber': 'H6.102',
//     'buildingCode': 'H6',
//     'floor': 1,
//     'capacity': 60,
//     'facilities': ['Máy tính', 'Wifi'],
//     'status': 'available',
//   },
//   {
//     'roomNumber': 'H6.201',
//     'buildingCode': 'H6',
//     'floor': 2,
//     'capacity': 40,
//     'facilities': ['Máy chiếu'],
//     'status': 'available',
//   },
//   {
//     'roomNumber': 'H6.202',
//     'buildingCode': 'H6',
//     'floor': 2,
//     'capacity': 50,
//     'facilities': ['Bảng', 'Wifi'],
//     'status': 'available',
//   },
//   {
//     'roomNumber': 'H6.203',
//     'buildingCode': 'H6',
//     'floor': 2,
//     'capacity': 10,
//     'facilities': ['Máy tính', 'Bảng'],
//     'status': 'available',
//   },

//   // Tòa Stadium
//   {
//     'roomNumber': 'Stadium.101',
//     'buildingCode': 'Stadium',
//     'floor': 1,
//     'capacity': 50,
//     'facilities': ['Máy chiếu', 'Bảng'],
//     'status': 'available',
//   },
//   {
//     'roomNumber': 'Stadium.102',
//     'buildingCode': 'Stadium',
//     'floor': 1,
//     'capacity': 10,
//     'facilities': ['Wifi'],
//     'status': 'available',
//   },
//   {
//     'roomNumber': 'Stadium.201',
//     'buildingCode': 'Stadium',
//     'floor': 2,
//     'capacity': 60,
//     'facilities': ['Máy chiếu', 'Bảng', 'Máy tính'],
//     'status': 'available',
//   },
//   {
//     'roomNumber': 'Stadium.202',
//     'buildingCode': 'Stadium',
//     'floor': 2,
//     'capacity': 40,
//     'facilities': ['Bảng', 'Wifi'],
//     'status': 'available',
//   },
//   {
//     'roomNumber': 'Stadium.203',
//     'buildingCode': 'Stadium',
//     'floor': 2,
//     'capacity': 10,
//     'facilities': ['Máy chiếu'],
//     'status': 'available',
//   },
// ];

//     // Thêm dữ liệu vào Firestore
//     for (var room in rooms) {
//       final docId = '${room['buildingCode']}_${room['roomNumber']}';
//       await _firestore.collection('rooms').doc(docId).set(room);
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class InitFirebaseData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> initializeData() async {
    // Xóa dữ liệu cũ (tùy chọn, chỉ dùng trong môi trường phát triển)
    await _clearCollections();

    // Khởi tạo dữ liệu mới
    await _initBuildings();
    await _initRooms();
  }

  Future<void> _clearCollections() async {
    try {
      // Xóa collection 'buildings'
      var buildingsSnapshot = await _firestore.collection('buildings').get();
      for (var doc in buildingsSnapshot.docs) {
        await doc.reference.delete();
      }

      // Xóa collection 'rooms'
      var roomsSnapshot = await _firestore.collection('rooms').get();
      for (var doc in roomsSnapshot.docs) {
        await doc.reference.delete();
      }

      print('Đã xóa dữ liệu cũ thành công');
    } catch (e) {
      print('Lỗi khi xóa dữ liệu cũ: $e');
    }
  }

  Future<void> _initBuildings() async {
    try {
      // Kiểm tra xem đã có dữ liệu chưa
      final snapshot = await _firestore.collection('buildings').get();
      if (snapshot.docs.isNotEmpty) {
        print('Dữ liệu tòa nhà đã tồn tại, bỏ qua khởi tạo.');
        return;
      }

      // Tạo các tòa nhà H1, H2, H3, H6, Stadium
      final buildings = [
        {
          'buildingCode': 'H1',
          'name': 'Tòa H1 - Khu học tập',
          'floors': 2,
          'totalRooms': 5,
        },
        {
          'buildingCode': 'H2',
          'name': 'Tòa H2 - Khu nghiên cứu',
          'floors': 2,
          'totalRooms': 5,
        },
        {
          'buildingCode': 'H3',
          'name': 'Tòa H3 - Khu thực hành',
          'floors': 2,
          'totalRooms': 5,
        },
        {
          'buildingCode': 'H6',
          'name': 'Tòa H6 - Khu học tập',
          'floors': 2,
          'totalRooms': 5,
        },
        {
          'buildingCode': 'Stadium',
          'name': 'Stadium - Khu thể dục thể thao',
          'floors': 2,
          'totalRooms': 5,
        },
      ];

      // Thêm dữ liệu vào Firestore
      for (var building in buildings) {
        await _firestore.collection('buildings').doc(building['buildingCode'].toString()).set(building);
        print('Đã thêm tòa nhà ${building['buildingCode']}');
      }
    } catch (e) {
      print('Lỗi khi khởi tạo tòa nhà: $e');
    }
  }

  Future<void> _initRooms() async {
    try {
      // Kiểm tra xem đã có dữ liệu chưa
      final snapshot = await _firestore.collection('rooms').get();
      if (snapshot.docs.isNotEmpty) {
        print('Dữ liệu phòng đã tồn tại, bỏ qua khởi tạo.');
        return;
      }

      final rooms = [
        // Tòa H1
        {
          'roomNumber': 'H1.101',
          'buildingCode': 'H1',
          'floor': 1,
          'capacity': 50,
          'facilities': ['Máy chiếu', 'Bảng', 'Wifi'],
          'status': 'available',
        },
        {
          'roomNumber': 'H1.102',
          'buildingCode': 'H1',
          'floor': 1,
          'capacity': 10,
          'facilities': ['Máy chiếu', 'Bảng', 'Wifi', 'Máy tính'],
          'status': 'available',
        },
        {
          'roomNumber': 'H1.201',
          'buildingCode': 'H1',
          'floor': 2,
          'capacity': 60,
          'facilities': ['Máy chiếu', 'Bảng'],
          'status': 'available',
        },
        {
          'roomNumber': 'H1.202',
          'buildingCode': 'H1',
          'floor': 2,
          'capacity': 40,
          'facilities': ['Máy chiếu', 'Wifi'],
          'status': 'available',
        },
        {
          'roomNumber': 'H1.203',
          'buildingCode': 'H1',
          'floor': 2,
          'capacity': 10,
          'facilities': ['Bảng', 'Wifi'],
          'status': 'available',
        },

        // Tòa H2
        {
          'roomNumber': 'H2.101',
          'buildingCode': 'H2',
          'floor': 1,
          'capacity': 40,
          'facilities': ['Máy chiếu', 'Wifi'],
          'status': 'available',
        },
        {
          'roomNumber': 'H2.102',
          'buildingCode': 'H2',
          'floor': 1,
          'capacity': 60,
          'facilities': ['Bảng', 'Wifi', 'Máy tính'],
          'status': 'available',
        },
        {
          'roomNumber': 'H2.201',
          'buildingCode': 'H2',
          'floor': 2,
          'capacity': 10,
          'facilities': ['Máy chiếu', 'Bảng'],
          'status': 'available',
        },
        {
          'roomNumber': 'H2.202',
          'buildingCode': 'H2',
          'floor': 2,
          'capacity': 50,
          'facilities': ['Máy chiếu', 'Wifi', 'Máy tính'],
          'status': 'available',
        },
        {
          'roomNumber': 'H2.203',
          'buildingCode': 'H2',
          'floor': 2,
          'capacity': 10,
          'facilities': ['Wifi'],
          'status': 'available',
        },

        // Tòa H3
        {
          'roomNumber': 'H3.101',
          'buildingCode': 'H3',
          'floor': 1,
          'capacity': 60,
          'facilities': ['Bảng', 'Máy tính'],
          'status': 'available',
        },
        {
          'roomNumber': 'H3.102',
          'buildingCode': 'H3',
          'floor': 1,
          'capacity': 50,
          'facilities': ['Máy chiếu', 'Bảng', 'Wifi'],
          'status': 'available',
        },
        {
          'roomNumber': 'H3.201',
          'buildingCode': 'H3',
          'floor': 2,
          'capacity': 10,
          'facilities': ['Wifi', 'Máy tính'],
          'status': 'available',
        },
        {
          'roomNumber': 'H3.202',
          'buildingCode': 'H3',
          'floor': 2,
          'capacity': 40,
          'facilities': ['Máy chiếu', 'Bảng'],
          'status': 'available',
        },
        {
          'roomNumber': 'H3.203',
          'buildingCode': 'H3',
          'floor': 2,
          'capacity': 10,
          'facilities': ['Bảng'],
          'status': 'available',
        },

        // Tòa H6
        {
          'roomNumber': 'H6.101',
          'buildingCode': 'H6',
          'floor': 1,
          'capacity': 10,
          'facilities': ['Máy chiếu', 'Bảng', 'Wifi'],
          'status': 'available',
        },
        {
          'roomNumber': 'H6.102',
          'buildingCode': 'H6',
          'floor': 1,
          'capacity': 60,
          'facilities': ['Máy tính', 'Wifi'],
          'status': 'available',
        },
        {
          'roomNumber': 'H6.201',
          'buildingCode': 'H6',
          'floor': 2,
          'capacity': 40,
          'facilities': ['Máy chiếu'],
          'status': 'available',
        },
        {
          'roomNumber': 'H6.202',
          'buildingCode': 'H6',
          'floor': 2,
          'capacity': 50,
          'facilities': ['Bảng', 'Wifi'],
          'status': 'available',
        },
        {
          'roomNumber': 'H6.203',
          'buildingCode': 'H6',
          'floor': 2,
          'capacity': 10,
          'facilities': ['Máy tính', 'Bảng'],
          'status': 'available',
        },

        // Tòa Stadium
        {
          'roomNumber': 'Stadium.101',
          'buildingCode': 'Stadium',
          'floor': 1,
          'capacity': 60,
          'facilities': ['Máy chiếu', 'Bảng'],
          'status': 'available',
        },
        {
          'roomNumber': 'Stadium.102',
          'buildingCode': 'Stadium',
          'floor': 1,
          'capacity': 60,
          'facilities': ['Wifi'],
          'status': 'available',
        },
        {
          'roomNumber': 'Stadium.201',
          'buildingCode': 'Stadium',
          'floor': 2,
          'capacity': 60,
          'facilities': ['Máy chiếu', 'Bảng', 'Máy tính'],
          'status': 'available',
        },


      ];

      // Thêm dữ liệu vào Firestore
      for (var room in rooms) {
        final roomNumber = room['roomNumber'] as String?;
        if (roomNumber == null) {
          print('Lỗi: roomNumber không được null cho phòng: $room');
          continue;
        }
        final docId = '${room['buildingCode']}_${roomNumber.replaceAll('.', '_')}';
        await _firestore.collection('rooms').doc(docId).set(room);
        print('Đã thêm phòng $docId');
      }
    } catch (e) {
      print('Lỗi khi khởi tạo phòng: $e');
    }
  }
}