import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_shop/models/Product.dart';
import 'package:my_shop/models/customer.dart';
import 'package:my_shop/models/user.dart';

class Vendor extends User {
  Vendor.fromFirestore(id, email, document)
      : super.fromFirestore(id, email, document);

  Vendor.fromCustomer(Customer customer) : super.fromUser(customer);

  Future<void> init() async {
    final queryData = await FirebaseFirestore.instance
        .collection('products')
        .where('vendorId', isEqualTo: userId)
        .get();
    if (queryData.docs.length > 0) {
      products = queryData.docs
          .map((document) => Product.fromDocument(document))
          .toList();
    } else {
      products = [];
    }
  }

  List<Product> products;

  Future<List<String>> uploadImages(List<File> images) async {
    //reference
    List<Reference> refs = [];
    images.forEach((image) {
      refs.add(FirebaseStorage.instance
          .ref('products/$userId/${image.path.split('/').last}'));
    });
    //upload
    int index = 0;
    await Future.wait(refs.map((ref) => ref.putFile(images[index++])));
    //ged url
    return await Future.wait(refs.map((ref) => ref.getDownloadURL()));
  }

  Future<bool> addProduct(
      title, description, forWho, category, vendorID, price, photos) async {
    try {
      List<String> photosUrls = await uploadImages(photos);
      final date = DateFormat('yyyyMMdd').format(DateTime.now());
      final doc = await FirebaseFirestore.instance.collection('products').add({
        'title': title,
        'description': description,
        'forWho': forWho,
        'category': category,
        'date': date,
        'vendorID': userId,
        'price': price,
        'photos': photosUrls,
        'available': true,
      });

      products.add(Product(title, description, forWho, category, doc.id, date,
          userId, price, true, photosUrls));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> editProduct(id, title, description, forWho, category, vendorID,
      price, photos, available, date) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('products')
          .doc(id)
          .update({
        'title': title,
        'description': description,
        'forWho': forWho,
        'category': category,
        'price': price,
//        'photos': photosUrls,
        'available': available,
      });
      int index = products.indexWhere((element) => element.id == id);
      products.removeAt(index);
      products.insert(
          index,
          Product(title, description, forWho, category, id, date, userId, price,
              available, []));
      return true;
    } catch (e) {
      return false;
    }
  }
}
