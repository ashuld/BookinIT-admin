import 'package:appadmin/core/colors.dart';
import 'package:appadmin/view/vouchers/add_vouchers.dart';
import 'package:appadmin/view/vouchers/voucher_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/voucher_provider/voucher_provider.dart';

class VouchersHomepage extends StatelessWidget {
  const VouchersHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VoucherProvider>(context, listen: false);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: textwhite,
          ),
        ),
        title: const Text(
          "Manage Vouchers",
          style: TextStyle(
              color: textwhite, fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: SizedBox(
          width: size.width * 0.9,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddVouchers(
                      isEdited: false,
                    ),
                  ));
            },
            backgroundColor: buttonColor,
            child: const Text(
              "AddVoucher",
              style: TextStyle(color: textwhite),
            ),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('VoucherCollection')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none) {
                  return const Text("No Vouchers Added");
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  provider.valueAdding(snapshot);

                  return Consumer<VoucherProvider>(
                      builder: (context, datas, child) {
                    return Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox();
                        },
                        itemCount: datas.voucherList.length,
                        itemBuilder: (context, index) {
                          return VouchersData(
                            subTittle: datas.voucherList[index].couponCode,
                            tittle: datas.voucherList[index].couponDiscription,
                            index: index,
                          );
                        },
                      ),
                    );
                  });
                }
              })
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class VouchersData extends StatelessWidget {
  VouchersData(
      {super.key,
      required this.tittle,
      required this.subTittle,
      required this.index});
  String tittle;
  String subTittle;
  int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // log(index.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VoucherDetails(index: index),
            ));
      },
      child: ListTile(
        title: Text(
          tittle,
          style: const TextStyle(color: textwhite),
        ),
        subtitle: Text(
          subTittle,
          style: const TextStyle(color: textwhite),
        ),
      ),
    );
  }
}
