


class FireBaseModel{

  String couponCode;
 String couponDiscription;
 String couponExpireData;
 String discountAmound;
 String discountPercentageAmount;
 String minimumAmount;
 String uptoAmount;
 String percentageMinimumAmount;
 String? selectedOption;

  FireBaseModel({
 required this.couponCode,
  required this.couponDiscription,
  required this.couponExpireData,
  required this.discountAmound,
  required this.minimumAmount,
  required this.discountPercentageAmount,
  required this.uptoAmount,
  required this.percentageMinimumAmount,
  this.selectedOption
  });
}