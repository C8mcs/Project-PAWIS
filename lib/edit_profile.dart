import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class User extends StatelessWidget {
  const User({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edit Profile',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: EditProfile(
        username: '', //temp
        fullname: ' ', //temp
        address: ' ', //temp
        mobileNumber: 1234567890, //temp
        imagePath: 'assets/images/Logo_withBG.jpg', //temp
      ),
    );
  }
}

class EditProfile extends StatefulWidget {
  final String fullname;
  final String username;
  final String address;
  final int? mobileNumber;
  final String? imagePath;

  EditProfile({
    required this.username,
    required this.fullname,
    required this.address,
    required this.mobileNumber,
    this.imagePath,
  });

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String _editedUsername = '';
  String _editedFullname = '';
  String _editedAddress = '';
  String _editedMobileNumber = '';
  String? _newImagePath;

  void _saveChanges() {
    setState(() {
      _editedUsername = _editedUsername;
      _editedFullname = _editedFullname;
      _editedAddress = _editedAddress;
      _editedMobileNumber = _editedMobileNumber;
      _newImagePath = _newImagePath;
    });

    print('Changes saved');

    Navigator.pop(context);
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _newImagePath = pickedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(204, 233, 206, 1.0),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 70),
              Text(
                'Edit Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Container(
                height: 650,
                width: 350,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(68, 122, 43, 1),
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: _pickImage,
                        child: ClipOval(
                          child: Image.asset(
                            _newImagePath ?? 'assets/images/Logo_withBG.jpg',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Username'),
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                _editedUsername = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Username',
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Full name'),
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                _editedFullname = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Fullname',
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Address'),
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                _editedAddress = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Address',
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mobile Number'),
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                _editedMobileNumber = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Mobile Number',
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Button
                      ElevatedButton(
                        onPressed: _saveChanges,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(76, 52, 14, 1),
                        ),
                        child: Text('Confirm Changes',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
