class ContactModel {
  int? id;
  String name;
  String mobile;
  String? email;
  String? streetAddress;
  String? dob;
  String? image;
  String? gender;
  String? website;

  ContactModel(
      {this.id,
      required this.name,
      required this.mobile,
      this.email,
      this.streetAddress,
      this.dob,
      this.image,
      this.gender,
      this.website});
}

final contactList = <ContactModel>[
  ContactModel(
      id: 1,
      name: 'Ibrahim',
      mobile: '01751800957',
      email: 'aitvetibrahim@gmail.com',
      gender: 'Male',
      streetAddress: 'Mirpure Dhaka',
      website: 'www.flutter.dev',
      dob: '06/03/1998',),
  ContactModel(
    id: 2,
    name: 'Hasan',
    mobile: '01892406060',
    email: 'hasan@gmail.com',
    gender: 'Male',
    streetAddress: 'Mirpure Dhaka',
    website: 'www.flutter.dev',
    dob: '06/03/1997',)
];
