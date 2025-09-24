import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "Nada Ashraf";
  String userPhone = "01221670504";
  String userEmail = "nadaashraf@gmail.com";
  String userBio = "flutter developer";

  File? profileImage;

  bool isEditingName = false;
  bool isEditingPhone = false;
  bool isEditingEmail = false;
  bool isEditingBio = false;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController.text = userName;
    _phoneController.text = userPhone;
    _emailController.text = userEmail;
    _bioController.text = userBio;
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        profileImage = File(image.path);
      });
    }
  }

  void _saveField(String field) {
    setState(() {
      if (field == 'name') {
        userName = _nameController.text.trim();
        isEditingName = false;
      } else if (field == 'phone') {
        userPhone = _phoneController.text.trim();
        isEditingPhone = false;
      } else if (field == 'email') {
        userEmail = _emailController.text.trim();
        isEditingEmail = false;
      } else if (field == 'bio') {
        userBio = _bioController.text.trim();
        isEditingBio = false;
      }
    });
  }

  void _cancelEdit(String field) {
    setState(() {
      if (field == 'name') {
        _nameController.text = userName;
        isEditingName = false;
      } else if (field == 'phone') {
        _phoneController.text = userPhone;
        isEditingPhone = false;
      } else if (field == 'email') {
        _emailController.text = userEmail;
        isEditingEmail = false;
      } else if (field == 'bio') {
        _bioController.text = userBio;
        isEditingBio = false;
      }
    });
  }

  void _startEditing(String field) {
    setState(() {
      if (field == 'name')
        isEditingName = true;
      else if (field == 'phone')
        isEditingPhone = true;
      else if (field == 'email')
        isEditingEmail = true;
      else if (field == 'bio') isEditingBio = true;
    });
  }

  void _deleteAccount() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "Delete Account Confirmation",
          style: TextStyle(color: Colors.redAccent),
        ),
        content: const Text(
          "Are you sure you want to delete your account? This action cannot be undone.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Account deleted")),
              );
              // Add real account deletion code here
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required String value,
    required bool isEditing,
    required TextEditingController controller,
    required VoidCallback onEdit,
    required VoidCallback onSave,
    required VoidCallback onCancel,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        isEditing
            ? Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      keyboardType: keyboardType,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 12),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: onSave,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: onCancel,
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.orange),
                    onPressed: onEdit,
                  ),
                ],
              ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // هنا التعديل لإزالة السهم
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            tooltip: "Delete Account",
            onPressed: _deleteAccount,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: profileImage != null
                        ? FileImage(profileImage!) as ImageProvider
                        : const AssetImage('assets/images/profile_pic.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildEditableField(
              label: "Name",
              value: userName,
              isEditing: isEditingName,
              controller: _nameController,
              onEdit: () => _startEditing('name'),
              onSave: () => _saveField('name'),
              onCancel: () => _cancelEdit('name'),
            ),
            _buildEditableField(
              label: "Phone Number",
              value: userPhone,
              isEditing: isEditingPhone,
              controller: _phoneController,
              onEdit: () => _startEditing('phone'),
              onSave: () => _saveField('phone'),
              onCancel: () => _cancelEdit('phone'),
              keyboardType: TextInputType.phone,
            ),
            _buildEditableField(
              label: "Email",
              value: userEmail,
              isEditing: isEditingEmail,
              controller: _emailController,
              onEdit: () => _startEditing('email'),
              onSave: () => _saveField('email'),
              onCancel: () => _cancelEdit('email'),
              keyboardType: TextInputType.emailAddress,
            ),
            _buildEditableField(
              label: "Bio",
              value: userBio,
              isEditing: isEditingBio,
              controller: _bioController,
              onEdit: () => _startEditing('bio'),
              onSave: () => _saveField('bio'),
              onCancel: () => _cancelEdit('bio'),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
