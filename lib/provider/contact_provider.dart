import 'package:flutter/cupertino.dart';

import '../models/contact_model.dart';

class ContactProvider extends ChangeNotifier{
  List<ContactModel> contactList = [];

  addContact(ContactModel contactModel){
    contactList.add(contactModel);
    notifyListeners();
  }

  getAllContact(){
    this.contactList = contactList;
    notifyListeners();
  }
}