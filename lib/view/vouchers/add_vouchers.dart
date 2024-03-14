import 'dart:developer';

import 'package:appadmin/controller/provider/dialogues/showdialogue.dart';
import 'package:appadmin/core/colors.dart';
import 'package:appadmin/core/sizedBox.dart';
import 'package:appadmin/view/widgets/textFormFIeld1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/voucher_provider/voucher_provider.dart';

   final _key=GlobalKey<FormState>();
// ignore: must_be_immutable
class AddVouchers extends StatelessWidget {
   AddVouchers({super.key,required this.isEdited,this.index});
 bool isEdited=false;
 int? index;

  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
   final provider=Provider.of<VoucherProvider>(context,listen: false);
   // bool isTouched = false;
    

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
              )),
              
          title:isEdited==false? const Text(
            "Add New Voucher",
            style: TextStyle(color: textwhite),
          ):const Text(
            "Edit Voucher",
            style: TextStyle(color: textwhite),
          )
        ),
        // floatingActionButton: SizedBox(
        //   width:size.width*0.9 ,
        //   child: FloatingActionButton(
        //     backgroundColor: buttonColor,
        //     onPressed: () {

        //      },
        //   child:const Text("Add Coupon",style: TextStyle(color: textwhite),),
        //   ),
        // ),
        body: SingleChildScrollView(
          child: Form(
            key:_key ,
            child: Column(children: [
              TextFormField1(
                  hintText: "Enter Coupon Code",
                  textController: provider.codeController,
                  textIcon: Icons.qr_code),
              sizedH10,
              TextFormField1(
                  hintText: "Enter Coupon Description",
                  textController: provider.descriptionController,
                  textIcon: Icons.description),
              sizedH10,
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: provider.couponExpireController,
                    validator: (value) => value!.isEmpty ? "Field is empty " : null,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 11, color: textwhite),
                    onChanged: (value) {
                      selectedDate(context);
                    },
                    onTap: () async {
                      final selectDate = await selectedDate(context);
                      if (selectDate != null) {
                        String values = selectDate.toString().substring(0,10);
                        provider.couponExpireController.text=values;
                      }
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: textFieldBackground,
                        // contentPadding: new EdgeInsets.symmetric(vertical: 0.0),
                        // icon: Icon(textIcon,color: Colors.white,),
                        prefixIcon: const Icon(
                          Icons.expand_circle_down,
                          color: Colors.white,
                        ),
                        hintText: "Coupon Expire Date",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13))),
                  )),
              const Text(
                "Select An option",
                style: TextStyle(color: textwhite),
              ),
              Consumer<VoucherProvider>(builder: (context, voucher, child) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Radio(
                            value: 'Fixed Amount',
                            groupValue: voucher.selectedoption,
                            onChanged: (value) {
                              voucher.setvalues(value!);
                            }),
                        const Text('Fixed Amount (₹)',
                            style: TextStyle(color: Colors.white, fontSize: 15.5)),
                        Radio(
                            value: 'Percentage',
                            groupValue: voucher.selectedoption,
                            onChanged: (value) {
                              voucher.setvalues(value!);
                            }),
                        const Text('Percentage (%)',
                            style: TextStyle(color: Colors.white, fontSize: 15.5)),
                      ],
                    ),
                    voucher.selectedoption==null? const Center(child: Text('select One Option',style: TextStyle(color: textwhite),),)
:
                    voucher.selectedoption=="Fixed Amount"? 
                   
                    Column(
                      children: [
                        sizedH10,
                        TextFormField1(hintText: "Enter Discount Amount", textController:voucher.discountController, textIcon: Icons.currency_rupee),
                        sizedH10,
                      TextFormField1(hintText: "Enter Minmium Amount to Apply", textController: provider.minimumCouponController, textIcon: Icons.attach_money_sharp),
                   
                      ],
                    ):Column(
                      children: [
                        sizedH10,
                              TextFormField1(hintText: "Enter Discount Percentage", textController:provider.discountPercentageController, textIcon: Icons.percent_rounded),
                              sizedH10,
                      TextFormField1(hintText: "Enter Upto Amount", textController: provider.uptoAmountController, textIcon: Icons.currency_rupee),
                      sizedH10,
                       TextFormField1(hintText: "Enter Minimum Amount To Apply", textController: provider.minimumAmountPercentageController, textIcon: Icons.currency_rupee),
                                  
                                         
                                           ],
                    ),
                
                  ],
                );
               
                  
                  
                          }),
                          sizedH60,
                          
                    InkWell(
                      onTap: () async{
                        if (_key.currentState!.validate()) {
                           if (isEdited==true) {
                  provider.voucherEditing(context,index! );
                  isEdited=false;
                 
                }else if(isEdited==false){

                          log('');
                        provider.voucherData(context);
                          provider.codeController.clear();
                provider.couponExpireController.clear();
                provider.descriptionController.clear();
                provider.discountController.clear();
                provider.discountPercentageController.clear();
                provider.minimumAmountPercentageController.clear();
                provider.minimumCouponController.clear();
                provider.uptoAmountController.clear();
               
                
               
                        }else{
                          getError("Form Not filled", context);
                        }
                      }
                      },
                      child: Container(
                        height: size.height*0.08,
                        width: size.width*0.8,
                       decoration: BoxDecoration(
                         color: buttonColor,
                         borderRadius: BorderRadius.circular(10)
                       ),
                       child:const Center(child:  Text("Add Coupon",style: TextStyle(color: textwhite),)),
                      ),
                    )
            ]),
          ),
        )
        );
  }
}

Future selectedDate(BuildContext context) async {
  final initialDate = DateTime.now();
  final firstDate = initialDate.subtract(const Duration(days: 365 * 100));
  final lastDate = firstDate.add(const Duration(days: 365 * 200));

  final date = showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate);

  return date;
}
