import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task/home_screen.dart';
import 'package:interview_task/modules/models/food_model.dart';

import 'common_colors.dart';
import 'common_text_style.dart';
import 'common_widgets.dart';

getScreenWidth(context) {
  return MediaQuery.of(context).size.width;
}

class Searching {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      Duration(milliseconds: milliseconds ?? 2000),
      action,
    );
  }
}

RxList<FoodModel> foodData = <FoodModel>[].obs;

fetchFood({required int selectedIndex}) {
  foodData.clear();
  List recommendedFoodJsonList = [
    {
      'mainText': "Chicken Slab Burger",
      'price': 209,
      "qty": 0,
      'id': 1,
    },
    {
      'mainText': "Chicken Crunch Burger",
      'price': 259,
      "qty": 0,
      'id': 2,
    },
    {
      'mainText': "Donut Header Chicken",
      'price': 199,
      "qty": 0,
      'id': 3,
    },
    {
      'mainText': "Mighty Chicken Patty Burger",
      'price': 209,
      "qty": 0,
      'id': 4,
    },
    {
      'mainText': "Chicken Crunch Burger",
      'price': 209,
      "qty": 0,
      'id': 5,
    },
  ];
  List combosFoodJsonList = [
    {
      'mainText': "Chicken Slab Burger combo",
      'price': 300,
      "qty": 0,
      'id': 1,
    },
    {
      'mainText': "Chicken Crunch Burger combo",
      'price': 320,
      "qty": 0,
      'id': 2,
    },
    {
      'mainText': "Donut Header Chicken combo",
      'price': 320,
      "qty": 0,
      'id': 3,
    },
    {
      'mainText': "Chicken Crunch Burger combo",
      'price': 209,
      "qty": 0,
      'id': 5,
    },
  ];
  List regularFoodJsonList = [
    {
      'mainText': "Regular Chicken Slab Burger",
      'price': 300,
      "qty": 0,
      'id': 1,
    },
    {
      'mainText': "Regular Chicken Crunch Burger",
      'price': 320,
      "qty": 0,
      'id': 2,
    },
    {
      'mainText': "Regular Donut Header Chicken",
      'price': 320,
      "qty": 0,
      'id': 3,
    },
    {
      'mainText': "Regular Chicken Crunch Burger",
      'price': 209,
      "qty": 0,
      'id': 5,
    },
  ];
  List specialFoodJsonList = [
    {
      'mainText': "Special Chicken Slab Burger",
      'price': 300,
      "qty": 0,
      'id': 1,
    },
    {
      'mainText': "Special Chicken Crunch Burger",
      'price': 320,
      "qty": 0,
      'id': 2,
    },
    {
      'mainText': "Special Donut Header Chicken",
      'price': 320,
      "qty": 0,
      'id': 3,
    },
    {
      'mainText': "Special Chicken Crunch Burger",
      'price': 209,
      "qty": 0,
      'id': 5,
    },
  ];
  List muttonFoodJsonList = [
    {
      'mainText': "mutton Chicken Slab Burger combo",
      'price': 300,
      "qty": 0,
      'id': 1,
    },
    {
      'mainText': "mutton Chicken Crunch Burger combo",
      'price': 320,
      "qty": 0,
      'id': 2,
    },
    {
      'mainText': "mutton Donut Header Chicken combo",
      'price': 320,
      "qty": 0,
      'id': 3,
    },
    {
      'mainText': "mutton Chicken Crunch Burger combo",
      'price': 209,
      "qty": 0,
      'id': 5,
    },
  ];
  if (selectedIndex == 0) {
    recommendedFoodJsonList.forEach((element) {
      foodData.add(FoodModel.fromJson(element));
    });
  } else if (selectedIndex == 1) {
    combosFoodJsonList.forEach((element) {
      foodData.add(FoodModel.fromJson(element));
    });
  } else if (selectedIndex == 2) {
    regularFoodJsonList.forEach((element) {
      foodData.add(FoodModel.fromJson(element));
    });
  } else if (selectedIndex == 3) {
    specialFoodJsonList.forEach((element) {
      foodData.add(FoodModel.fromJson(element));
    });
  } else {
    muttonFoodJsonList.forEach((element) {
      foodData.add(FoodModel.fromJson(element));
    });
  }
}

// commonFoodRow({
//   String? mainText,
//   int? price,
//   int? qty,
//   Color? minusContainerColor,
//   Color? minusBorderColor,
//   Function? minusOnTap,
//   Function? plusOnTap,
// }) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.start,
//     children: [
//       const SizedBox(width: 15),
//       SizedBox(
//         height: 110,
//         width: 110,
//         // color: Colors.purple,
//         child: ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Image.network(
//                 'https://media.istockphoto.com/id/1309352410/photo/cheeseburger-with-tomato-and-lettuce-on-wooden-board.jpg?s=612x612&w=0&k=20&c=lfsA0dHDMQdam2M1yvva0_RXfjAyp4gyLtx4YUJmXgg=',
//                 fit: BoxFit.fill)),
//       ),
//       const SizedBox(width: 15),
//       Expanded(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(mainText ?? '', style: black15w500),
//             const SizedBox(height: 5),
//             const Wrap(
//               children: [
//                 Text("It is a long established fact that a reader will be distracted.", style: grey14w400),
//               ],
//             ),
//             const SizedBox(height: 13),
//             Row(
//               children: [
//                 Text('₹ $price'),
//                 const Spacer(),
//                 InkWell(
//                   onTap: () {
//                     if (minusOnTap != null) {
//                       minusOnTap();
//                     }
//                   },
//                   child: Container(
//                     height: 30,
//                     width: 30,
//                     decoration: commonContainerDecoration(
//                         borderColor: minusBorderColor ?? darkGrey, color: minusContainerColor ?? Colors.transparent, borderRadius: 7),
//                     child: Icon(Icons.remove, color: minusBorderColor ?? darkGrey, size: 20),
//                   ).paddingOnly(right: 15),
//                 ),
//                 Text(qty.toString(), style: black15w500),
//                 InkWell(
//                   splashColor: Colors.transparent,
//                   onTap: () {
//                     if (plusOnTap != null) {
//                       plusOnTap();
//                     }
//                   },
//                   child: Container(
//                     height: 30,
//                     width: 30,
//                     decoration: commonContainerDecoration(borderColor: green, borderRadius: 7, color: green.withOpacity(0.1)),
//                     child: const Icon(Icons.add, color: green, size: 20),
//                   ).paddingOnly(left: 15),
//                 ),
//               ],
//             ),
//           ],
//         ).paddingOnly(bottom: 10),
//       ),
//       const SizedBox(width: 15),
//     ],
//   ).paddingOnly(bottom: 15);
// }

commonNewFoodRow({
  required FoodModel data,
}) {
  return StatefulBuilder(builder: (context, setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 15),
        /*SizedBox(
          height: 110,
          width: 110,
          // color: Colors.purple,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                  'https://media.istockphoto.com/id/1309352410/photo/cheeseburger-with-tomato-and-lettuce-on-wooden-board.jpg?s=612x612&w=0&k=20&c=lfsA0dHDMQdam2M1yvva0_RXfjAyp4gyLtx4YUJmXgg=',
                  fit: BoxFit.fill)),
        ),*/
        SizedBox(
          height: 110,
          width: 110,
          // color: Colors.purple,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const Image(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://media.istockphoto.com/id/1309352410/photo/cheeseburger-with-tomato-and-lettuce-on-wooden-board.jpg?s=612x612&w=0&k=20&c=lfsA0dHDMQdam2M1yvva0_RXfjAyp4gyLtx4YUJmXgg='),
              )),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.mainText ?? '', style: black15w500),
              const SizedBox(height: 5),
              const Wrap(
                children: [
                  Text("It is a long established fact that a reader will be distracted.", style: grey14w400),
                ],
              ),
              const SizedBox(height: 13),
              Row(
                children: [
                  Text('₹ ${data.price}'),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      if ((data.qty ?? 0) > 0) {
                        data.qty--;
                        totalItem--;
                        totalOrderPrice -= data.price ?? 0;
                      }
                      setState(() {});
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: commonContainerDecoration(
                          borderColor: data.qty != 0 ? green : darkGrey,
                          color: data.qty != 0 ? green.withOpacity(0.1) : Colors.transparent,
                          borderRadius: 7),
                      child: Icon(Icons.remove, color: data.qty != 0 ? green : darkGrey, size: 20),
                    ).paddingOnly(right: 15),
                  ),
                  Text(data.qty.toString(), style: black15w500),
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      data.qty++;
                      totalItem++;
                      totalOrderPrice += data.price ?? 0;
                      print("data['qty']===>${data.qty}");
                      setState(() {});
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: commonContainerDecoration(borderColor: green, borderRadius: 7, color: green.withOpacity(0.1)),
                      child: const Icon(Icons.add, color: green, size: 20),
                    ).paddingOnly(left: 15),
                  ),
                ],
              ),
            ],
          ).paddingOnly(bottom: 10),
        ),
        const SizedBox(width: 15),
      ],
    ).paddingOnly(bottom: 15);
  });
}
