import 'dart:io';

import 'package:address_book/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class NewContactPage extends StatefulWidget {
  static const String routeName = '/new_contact';

  const NewContactPage({Key? key}) : super(key: key);

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final streetAddressController = TextEditingController();
  final websiteController = TextEditingController();

  String? dob;
  String? imagePath;
  String genderGroupValue = 'Male';
  ImageSource source = ImageSource.camera;

  // @override
  // void didChangeDependencies() {
  //   nameController.text = 'Ibrahim Khan';
  //   super.didChangeDependencies();
  // }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    streetAddressController.dispose();
    websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Contact'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveContact,
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 5.0),
                ),
                filled: true,
                labelText: 'Full Name'
              //hintText: 'Full Name'
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: mobileController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 5.0),
                ),
                filled: true,
                labelText: 'Mobile'
              //hintText: 'Full Name'
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 5.0),
                ),
                filled: true,
                labelText: 'Email'
              //hintText: 'Full Name'
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: streetAddressController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.my_location),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 5.0),
                ),
                filled: true,
                labelText: 'Address'
              //hintText: 'Full Name'
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: websiteController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.web),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 5.0),
                ),
                filled: true,
                labelText: 'Website'
              //hintText: 'Full Name'
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Select Gender'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                          value: 'Male',
                          groupValue: genderGroupValue,
                          onChanged: (value) {
                            setState(() {
                              genderGroupValue = value!;
                            });
                          }
                      ),
                      Text('Male'),
                      Radio(
                          value: 'Female',
                          groupValue: genderGroupValue,
                          onChanged: (value) {
                            setState(() {
                              genderGroupValue = value!;
                            });
                          }
                      ),
                      Text('Female'),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: _showDatePickerDialog,
                  child: Text('Select Date of Birth')),
              Chip(
                label: Text(dob == null ? 'No Date Chossen' : dob!),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                elevation: 5,
                child: imagePath == null
                    ? Image.asset(
                  'images/placeholder.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                )
                    : Image.file(
                  File(imagePath!),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        source = ImageSource.camera;
                        _getImage();
                      },
                      icon: Icon(Icons.camera_alt),
                      label: Text('Capture')),
                  TextButton.icon(
                      onPressed: () {
                        source = ImageSource.gallery;
                        _getImage();
                      },
                      icon: Icon(Icons.photo),
                      label: Text('Gallery'))
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  void _showDatePickerDialog() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1922),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        dob = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  void _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  void _saveContact() {
    final contact = ContactModel(
        name: nameController.text,
        mobile: mobileController.text,
        email: emailController.text,
        streetAddress: streetAddressController.text,
        website: websiteController.text,
        dob: dob,
        image: imagePath,
        gender: genderGroupValue
      );
    contactList.add(contact);
    Navigator.pop(context);
  }
}
