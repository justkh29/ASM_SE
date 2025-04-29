import 'package:flutter/material.dart';
import 'room_auth_page.dart';
import 'choose_room.dart';
import 'booking_history_page.dart';
import 'check_in_out_page.dart';
import 'package:flutter_application_1/presentation/choose_mode/pages/choose_mode.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Cài đặt'),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Đăng xuất'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {},
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.png'),
                radius: 19,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/background.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.6),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Chooseroom(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add_home),
                    label: const Text('Đặt Phòng'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookingHistoryPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.history),
                    label: const Text('Lịch Sử Đặt'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CheckInOutPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.meeting_room),
                    label: const Text('Nhận Phòng'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RoomAuthPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.manage_accounts),
                    label: const Text('Quản Lý Phòng'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
bottomNavigationBar: BottomNavigationBar(
  backgroundColor: Colors.blue,
  selectedItemColor: Colors.white,
  unselectedItemColor: Colors.white70,
  // currentIndex: -1, // Trick để không làm nổi bật item nào
  // onTap: (index) {},
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: ''),
    BottomNavigationBarItem(
      icon: Icon(Icons.home, size:  40), // <-- Tăng kích thước ở đây
      label: '',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.star), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
  ],
  type: BottomNavigationBarType.fixed, // Đảm bảo các icon hiển thị đầy đủ
),

    );
  }
}