import 'dart:io';

import 'package:address_book/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetailsPage extends StatefulWidget {
  static const String routeName = '/details_page';

  const ContactDetailsPage({Key? key}) : super(key: key);

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  late ContactModel contact;

  @override
  void didChangeDependencies() {
    contact = ModalRoute.of(context)!.settings.arguments as ContactModel;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.name),
      ),
      body: ListView(
        children: [
          contact.image == null
              ? Image.asset(
                  'images/placeholder.jpg',
                  width: double.maxFinite,
                  height: 250,
                  fit: BoxFit.cover,
                )
              : Image.file(
                  File(contact.image!),
                  width: double.maxFinite,
                  height: 250,
                  fit: BoxFit.cover,
                ),
          ListTile(
            title: Text(contact.mobile),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.call),
                  onPressed: _callPerson,
                ),
                IconButton(
                  icon: Icon(Icons.sms),
                  onPressed: _smsContact,
                )
              ],
            ),
          ),
          ListTile(
            title: Text(contact.email ?? 'Unavailable'),
            trailing: IconButton(
              icon: Icon(contact.email == null ? Icons.edit : Icons.email),
              onPressed: _mailContact,
            ),
          ),
          ListTile(
            title: Text(
                contact.streetAddress == null || contact.streetAddress!.isEmpty
                    ? 'Unavailabel'
                    : contact.streetAddress!),
            trailing: IconButton(
              icon: Icon(contact.streetAddress == null ||
                      contact.streetAddress!.isEmpty
                  ? Icons.edit
                  : Icons.my_location),
              onPressed: _showMap,
            ),
          )
        ],
      ),
    );
  }

  void _callPerson() async {
    final uri = Uri.parse('tel:${contact.mobile}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Cannot launch url';
    }
  }

  void _smsContact() async {
    final uri = Uri.parse('sms:${contact.mobile}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Cannot launch url';
    }
  }

  void _mailContact() {}

  void _showMap() async{
    String urlString;
    if(Platform.isAndroid){
      urlString = 'geo:0,0?q=${contact.streetAddress}';
    }else if(Platform.isIOS){
      urlString = 'http/maps,apple.com/?q=${contact.streetAddress}';
    }else{
      urlString = 'geo:0,0?q=${contact.streetAddress}';
    }
    if (await canLaunchUrl(Uri.parse(urlString))) {
    await launchUrl(Uri.parse(urlString));
    } else {
    throw 'Cannot launch url';
    }
  }
}
