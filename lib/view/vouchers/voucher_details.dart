import 'package:appadmin/controller/provider/voucher_provider/voucher_provider.dart';
import 'package:appadmin/core/colors.dart';
import 'package:appadmin/core/sizedBox.dart';
import 'package:appadmin/view/vouchers/add_vouchers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class VoucherDetails extends StatelessWidget {
  VoucherDetails({super.key, required this.index});
  int index;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    //  final provider=Provider.of<VoucherProvider>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: textwhite,
            )),
        title: const Text(
          "Coupon Details",
          style: TextStyle(color: textwhite, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<VoucherProvider>(builder: (context, voucher, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedH30,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'CouponCode: ',
                    style: TextStyle(
                        color: colorTextwhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    voucher.voucherList[index].couponCode,
                    style: const TextStyle(
                        color: colorTextwhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              sizedH60,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Coupon Description: ',
                    maxLines: 2,
                    style: TextStyle(
                        color: colorTextwhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    voucher.voucherList[index].couponDiscription,
                    style: const TextStyle(
                        color: colorTextwhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              sizedH60,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Coupon ExpireDate: ',
                    style: TextStyle(
                        color: colorTextwhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    voucher.voucherList[index].couponExpireData,
                    style: const TextStyle(
                        color: colorTextwhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              sizedH60,
              voucher.voucherList[index].selectedOption == 'Fixed Amount'
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Discount Amount: ',
                              style: TextStyle(
                                  color: colorTextwhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              voucher.voucherList[index].discountAmound,
                              style: const TextStyle(
                                  color: colorTextwhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        sizedH60,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Minimum Amount: ',
                              style: TextStyle(
                                  color: colorTextwhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              voucher.voucherList[index].minimumAmount,
                              style: const TextStyle(
                                  color: colorTextwhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //  sizedH60
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Discount Percentage: ',
                              style: TextStyle(
                                  color: colorTextwhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              voucher
                                  .voucherList[index].discountPercentageAmount
                                  .toString(),
                              style: const TextStyle(
                                  color: colorTextwhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        sizedH60,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Upto Amount: ',
                              style: TextStyle(
                                  color: colorTextwhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              voucher.voucherList[index].uptoAmount.toString(),
                              style: const TextStyle(
                                  color: colorTextwhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        sizedH60,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Minimum Amount: ',
                              style: TextStyle(
                                  color: colorTextwhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              voucher.voucherList[index].percentageMinimumAmount
                                  .toString(),
                              style: const TextStyle(
                                  color: colorTextwhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    ),
              sizedH30,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      voucher.saveTexts(index);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddVouchers(
                              isEdited: true,
                              index: index,
                            ),
                          ));
                    },
                    child: Container(
                      height: size.height * 0.055,
                      width: size.width * 0.4,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text(
                        "Edit",
                        style: TextStyle(
                            color: textwhite, fontWeight: FontWeight.w600),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      voucher.deleteVoucher(index, context);
                    },
                    child: Container(
                      height: size.height * 0.055,
                      width: size.width * 0.4,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text(
                        "Delete",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
