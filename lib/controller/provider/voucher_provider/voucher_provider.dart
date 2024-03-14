// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:appadmin/controller/provider/dialogues/showdialogue.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../model/fire_base_model/fire_base_modal_class.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class VoucherProvider extends ChangeNotifier {
  TextEditingController discountController = TextEditingController();
  TextEditingController minimumCouponController = TextEditingController();
  TextEditingController discountPercentageController = TextEditingController();
  TextEditingController uptoAmountController = TextEditingController();
  TextEditingController minimumAmountPercentageController =
      TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController couponExpireController = TextEditingController();
  List<QueryDocumentSnapshot<Object?>>? snapshotList = [];
  List<FireBaseModel> voucherList = [];

  String? selectedoption;

  setvalues(String value) {
    selectedoption = value;

    selectedoption = value;

    notifyListeners();
  }

  Future voucherData(BuildContext context) async {
    await _firestore.collection('VoucherCollection').add({
      'CouponCode': codeController.text,
      'CouponDescrtion': descriptionController.text,
      'CouponExpire': couponExpireController.text,
      'DiscountAmount': discountController.text,
      'selectedOption': selectedoption,
      'MinimumAmount': minimumCouponController.text,
      'DiscountPersentage': discountPercentageController.text,
      'UptoAmount': uptoAmountController.text,
      'PercentageMinimumAmount': minimumAmountPercentageController.text,
    });

    getError("Voucher Added", context);
    Navigator.pop(context);
  }

  valueAdding(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) async {
    List<QueryDocumentSnapshot<Object?>>? list = snapshot.data!.docs.toList();
    snapshotList = list;

    voucherList.clear();
    for (var data in list) {
      final voucher = FireBaseModel(
          couponCode: data['CouponCode'],
          couponDiscription: data['CouponDescrtion'],
          couponExpireData: data['CouponExpire'],
          discountAmound: data['DiscountAmount'],
          minimumAmount: data['MinimumAmount'],
          discountPercentageAmount: data['DiscountPersentage'],
          uptoAmount: data['UptoAmount'],
          percentageMinimumAmount: data['PercentageMinimumAmount'],
          selectedOption: data['selectedOption']);
      log('ok');
      // log(' ${voucherList[0].selectedOption}');

      voucherList.add(voucher);

      notifyListeners();
    }
  }

  saveTexts(int index) {
    discountController.text = voucherList[index].discountAmound.toString();
    codeController.text = voucherList[index].couponCode.toString();
    descriptionController.text =
        voucherList[index].couponDiscription.toString();
    minimumCouponController.text = voucherList[index].minimumAmount.toString();
    discountPercentageController.text =
        voucherList[index].discountPercentageAmount.toString();
    uptoAmountController.text = voucherList[index].uptoAmount.toString();
    minimumAmountPercentageController.text =
        voucherList[index].percentageMinimumAmount.toString();
  }

  voucherEditing(BuildContext context, int index) async {
    try {
      final voucheId = snapshotList![index].id;
      //voucherList.removeAt(index);

      await FirebaseFirestore.instance
          .collection('VoucherCollection')
          .doc(voucheId)
          .update({
        'CouponCode': codeController.text,
        'CouponDescrtion': descriptionController.text,
        'CouponExpire': couponExpireController.text,
        'DiscountAmount': discountController.text,
        'DiscountPersentage': discountPercentageController.text,
        'MinimumAmount': minimumCouponController.text,
        'PercentageMinimumAmount': minimumAmountPercentageController.text,
        'UptoAmount': uptoAmountController.text,
        'selectedOption': selectedoption
      });
      Navigator.pop(context);
      getError("success", context);
    } catch (e) {
      log(e.toString());
    }

    notifyListeners();
  }

  Future<void> deleteVoucher(int index, BuildContext context) async {
    final id = snapshotList![index].id;

    try {
      await FirebaseFirestore.instance
          .collection('VoucherCollection')
          .doc(id)
          .delete();
      notifyListeners();
      getError("succes fully Deleteed", context);
      Navigator.pop(context);
    } catch (e) {
      log(e.toString());
    }
  }
}
