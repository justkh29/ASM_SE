// import 'package:flutter/material.dart';
// import 'room_details_page.dart'; // Import the next page

// class BuildingOverviewPage extends StatelessWidget {
//   final String buildingCode;
//   const BuildingOverviewPage({super.key, required this.buildingCode});

//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, dynamic>> floors = [
//       {'floor': 'Tầng 7', 'available': 0, 'total': 0},
//       {'floor': 'Tầng 6', 'available': 1, 'total': 1},
//       {'floor': 'Tầng 5', 'available': 0, 'total': 0},
//       {'floor': 'Tầng 4', 'available': 0, 'total': 0},
//       {'floor': 'Tầng 3', 'available': 1, 'total': 1},
//       {'floor': 'Tầng 2', 'available': 0, 'total': 0},
//       {'floor': 'Tầng 1', 'available': 0, 'total': 0},
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Image.asset(
//           'assets/images/logo.png',
//           height: 40,
//         ),
//         centerTitle: true,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 12.0),
//             child: IconButton(
//               icon: const Icon(Icons.notifications),
//               onPressed: () {},
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             margin: const EdgeInsets.all(16.0),
//             padding: const EdgeInsets.all(16.0),
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     color: Colors.yellow,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     buildingCode,
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(
//                       'Số tầng: ${floors.length}',
//                       style: const TextStyle(fontSize: 16),
//                     ),
//                     Text(
//                       'Số phòng trống: 15/150',
//                       style: const TextStyle(fontSize: 16),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: floors.length,
//               itemBuilder: (context, index) {
//                 final floor = floors[index];
//                 return GestureDetector(
//                   onTap: () {
//                     if (floor['available'] > 0) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => RoomDetailsPage(
//                             roomCode: '$buildingCode X${7 - index}3',
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(
//                         horizontal: 16.0, vertical: 4.0),
//                     padding: const EdgeInsets.all(16.0),
//                     decoration: BoxDecoration(
//                       color: Colors.blue[900],
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           floor['floor'],
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                               'Còn ${floor['available']} phòng trống',
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             Icon(
//                               floor['available'] > 0
//                                   ? Icons.check_circle
//                                   : Icons.cancel,
//                               color: floor['available'] > 0
//                                   ? Colors.green
//                                   : Colors.red,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//   backgroundColor: Colors.blue,
//   selectedItemColor: Colors.white,
//   unselectedItemColor: Colors.white70,
//   // currentIndex: -1, // Trick để không làm nổi bật item nào
//   // onTap: (index) {},
//   items: const [
//     BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: ''),
//     BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: ''),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.home, size:  40), // <-- Tăng kích thước ở đây
//       label: '',
//     ),
//     BottomNavigationBarItem(icon: Icon(Icons.star), label: ''),
//     BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
//   ],
//   type: BottomNavigationBarType.fixed, // Đảm bảo các icon hiển thị đầy đủ
// ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'room_details_page.dart';

class BuildingOverviewPage extends StatelessWidget {
  final String buildingCode;
  final String date;
  final int people;
  final int duration;

  const BuildingOverviewPage({
    super.key,
    required this.buildingCode,
    this.date = '',
    this.people = 0,
    this.duration = 0,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> floors = [
      {'floor': 'Tầng 7', 'available': 0, 'total': 0},
      {'floor': 'Tầng 6', 'available': 1, 'total': 1},
      {'floor': 'Tầng 5', 'available': 0, 'total': 0},
      {'floor': 'Tầng 4', 'available': 0, 'total': 0},
      {'floor': 'Tầng 3', 'available': 1, 'total': 1},
      {'floor': 'Tầng 2', 'available': 0, 'total': 0},
      {'floor': 'Tầng 1', 'available': 0, 'total': 0},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset(
          'assets/images/logo.png',
          height: 40,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    buildingCode,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Số tầng: ${floors.length}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Text(
                      'Số phòng trống: 15/150',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: floors.length,
              itemBuilder: (context, index) {
                final floor = floors[index];
                return GestureDetector(
                  onTap: () {
                    if (floor['available'] > 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoomDetailsPage(
                            roomCode: '$buildingCode X${7 - index}3',
                            date: date,
                            people: people,
                            duration: duration,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          floor['floor'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Còn ${floor['available']} phòng trống',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              floor['available'] > 0
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color: floor['available'] > 0
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 40),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}