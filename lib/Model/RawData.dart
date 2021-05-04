import 'package:touchngo/External/AppColors.dart';
import 'package:touchngo/External/constant.dart';
import 'package:touchngo/Model/CardInfo.dart';

class RawData{

  var cardList = <CardInfo>[
    CardInfo(
        index: 0,
        cardNumber: CardNumber.no1,
        cardName:CardName.visa,
        cardImage: AppImages.visa,
        cardHolderName: CardHolderName.name1,
        expDate: ExpDate.no1,
        backColor: AppColors.color1
    ),
    CardInfo(
        index: 1,
        cardNumber: CardNumber.no2,
        cardName:CardName.dinnerClub,
        cardImage: AppImages.dinnerClub,
        cardHolderName:CardHolderName.name2,
        expDate: ExpDate.no2,
        backColor: AppColors.color2
    ),
    CardInfo(
        index: 2,
        cardNumber: CardNumber.no3,
        cardName:CardName.discover,
        cardImage: AppImages.discover,
        cardHolderName:CardHolderName.name3 ,
        expDate:  ExpDate.no3,
        backColor: AppColors.color3
    ),
    CardInfo(
        index: 3,
        cardNumber: CardNumber.no4,
        cardName:CardName.jcb,
        cardImage: AppImages.jcb,
        cardHolderName: CardHolderName.name4,
        expDate: ExpDate.no4,
        backColor: AppColors.color4
    ),
    CardInfo(
        index: 4,
        cardNumber: CardNumber.no5,
        cardName:CardName.master,
        cardImage: AppImages.master,
        cardHolderName:CardHolderName.name5 ,
        expDate:  ExpDate.no5,
        backColor: AppColors.color5
    ),
  ];

}