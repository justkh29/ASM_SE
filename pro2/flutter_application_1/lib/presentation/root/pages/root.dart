import 'package:flutter/material.dart';
import 'room_auth_page.dart'; // thêm import mới
import 'choose_room.dart';
import 'booking_history_page.dart';
import 'check_in_out_page.dart';
class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Cài đặt'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Đăng xuất'),
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
        title: const Text('Trang Chủ'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                // mở trang thông tin cá nhân chẳng hạn
              },
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.png'), // ảnh đại diện
                radius: 19,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
  children: [
    // Ảnh nền chiếm nửa màn hình
    Positioned.fill(
      child: Align(
        alignment: Alignment.topCenter, // Căn giữa ảnh nền
        child: Container(
          height: MediaQuery.of(context).size.height / 3,  // Chiếm nửa chiều cao màn hình
          width: MediaQuery.of(context).size.width,  // Chiếm toàn bộ chiều rộng màn hình
          child: Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
    // Nội dung chính
          Center(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
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
                            builder: (context) => const Chooseroom()),
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
                            builder: (context) => const BookingHistoryPage()),
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
                            builder: (context) => const CheckInOutPage()),
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
                            builder: (context) => const RoomAuthPage()),
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
        currentIndex: 0,
        onTap: (index) {
          // xử lý điều hướng tại đây nếu cần
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Thông báo'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Tài khoản'),
        ],
      ),
    );
  }
}
