import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/configs/theme/app_colors.dart';
import 'package:flutter_application_1/presentation/root/pages/root.dart';
import 'notifications_page.dart';
import 'settings_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? currentUser;
  bool _isEditing = false;
  late TextEditingController _nameController;
  late TextEditingController _studentIdController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    currentUser = _auth.currentUser;
    _nameController = TextEditingController(text: currentUser?.displayName ?? 'Chưa đặt tên');
    _studentIdController = TextEditingController();
    _phoneController = TextEditingController(text: currentUser?.phoneNumber ?? 'Chưa cung cấp');
    _addressController = TextEditingController();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (currentUser != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .get();
      if (doc.exists) {
        setState(() {
          userData = doc.data();
          _studentIdController.text = userData!['studentId'] ?? 'Chưa cung cấp';
          _addressController.text = userData!['address'] ?? 'Chưa cung cấp';
          if (userData!['phoneNumber'] != null) {
            _phoneController.text = userData!['phoneNumber'];
          }
        });
      }
    }
  }

  Future<void> _saveChanges() async {
    if (currentUser == null) return;

    try {
      // Update Firebase Authentication profile
      await currentUser!.updateDisplayName(_nameController.text);
      if (_phoneController.text.isNotEmpty) {
        // Note: Firebase Auth phone number updates require re-authentication and SMS verification
        // For simplicity, we'll store it in Firestore instead
      }

      // Update Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .set({
        'name': _nameController.text,
        'studentId': _studentIdController.text,
        'phoneNumber': _phoneController.text,
        'address': _addressController.text,
        'updatedAt': Timestamp.now(),
      }, SetOptions(merge: true));

      // Refresh the user data
      await currentUser!.reload();
      currentUser = _auth.currentUser;

      setState(() {
        _isEditing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cập nhật thông tin thành công!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi khi cập nhật: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _studentIdController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Tài Khoản',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsPage()),
              );
            },
          ),
          CircleAvatar(
            radius: 16,
            backgroundImage: currentUser?.photoURL != null
                ? NetworkImage(currentUser!.photoURL!)
                : const AssetImage('assets/images/profile_placeholder.png') as ImageProvider,
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: currentUser == null
          ? const Center(child: Text('Vui lòng đăng nhập để xem thông tin tài khoản.'))
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Profile Header
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: currentUser?.photoURL != null
                              ? NetworkImage(currentUser!.photoURL!)
                              : const AssetImage('assets/images/profile_placeholder.png') as ImageProvider,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          currentUser!.displayName ?? 'Người Dùng',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          currentUser!.email ?? 'Không có email',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // User Details
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Thông Tin Cá Nhân',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildDetailRow(
                              label: 'Tên',
                              value: _nameController.text,
                              isEditing: _isEditing,
                              controller: _nameController,
                            ),
                            const Divider(),
                            _buildDetailRow(
                              label: 'Mã số sinh viên',
                              value: _studentIdController.text,
                              isEditing: _isEditing,
                              controller: _studentIdController,
                            ),
                            const Divider(),
                            _buildDetailRow(
                              label: 'Số điện thoại',
                              value: _phoneController.text,
                              isEditing: _isEditing,
                              controller: _phoneController,
                            ),
                            const Divider(),
                            _buildDetailRow(
                              label: 'Địa chỉ',
                              value: _addressController.text,
                              isEditing: _isEditing,
                              controller: _addressController,
                            ),
                            const Divider(),
                            Text(
                              'Email: ${currentUser!.email ?? 'Không có email'}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            if (userData != null) ...[
                              const Divider(),
                              Text(
                                'Vai trò: ${userData!['role'] ?? 'Người dùng'}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                            const SizedBox(height: 20),
                            Center(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  if (_isEditing) {
                                    _saveChanges();
                                  } else {
                                    setState(() {
                                      _isEditing = true;
                                    });
                                  }
                                },
                                icon: Icon(_isEditing ? Icons.save : Icons.edit),
                                label: Text(_isEditing ? 'Lưu' : 'Chỉnh sửa'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const RootPage()),
                (route) => false,
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsPage()),
              );
              break;
            case 2:
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Tin nhắn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Cài đặt',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required String label,
    required String value,
    required bool isEditing,
    required TextEditingController controller,
  }) {
    return isEditing
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$label:',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
  }
}