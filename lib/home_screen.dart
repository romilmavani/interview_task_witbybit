// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task/search_screen.dart';
import 'package:interview_task/utils/app_images.dart';
import 'package:interview_task/utils/common_colors.dart';
import 'package:interview_task/utils/common_functions.dart';
import 'package:interview_task/utils/common_text_style.dart';
import 'package:interview_task/utils/common_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

RxInt totalItem = 0.obs;
RxInt totalOrderPrice = 0.obs;

class _HomeScreenState extends State<HomeScreen> {
  List list = ["Recommended", "Combos", "Regular Burgers", "Special Burgers", "Mutton Burgers"];

  RxString foodType = 'Recommended'.obs;
  RxBool bottomBar = false.obs;

  RxInt addItem = 0.obs;

  @override
  void initState() {
    fetchFood(selectedIndex: 0);
    foodData.forEach((element) {
      if (element.qty > 0) {
        totalItem += element.qty;
        totalOrderPrice += element.price ?? 0;
      }
    });
    // foodData.where((element) => element.qty > 0);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: totalItem.stream,
        builder: (context, snapshot) {
          return Scaffold(
            bottomNavigationBar: totalItem > 0
                ? StreamBuilder(
                    stream: totalItem.stream,
                    builder: (context, snapshot) {
                      return StreamBuilder(
                          stream: totalOrderPrice.stream,
                          builder: (context, snapshot) {
                            return Material(
                              elevation: 20,
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    Text('$totalItem item', style: black15w500),
                                    Container(height: 20, width: 1, color: darkGrey).paddingOnly(left: 15, right: 15),
                                    Text('₹ $totalOrderPrice', style: black15w500),
                                    const Spacer(),
                                    Container(
                                      decoration: commonContainerDecoration(
                                        color: green,
                                      ),
                                      child: const Text('View Cart', style: white15w500).paddingSymmetric(horizontal: 15, vertical: 10),
                                    ),
                                  ],
                                ),
                              ).paddingSymmetric(horizontal: 10, vertical: 20),
                            );
                          });
                    })
                : const SizedBox(),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 190,
                      width: getScreenWidth(context),
                      child: Image.asset(AppImages.burger3Image, fit: BoxFit.fill),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: commonContainerDecoration(),
                          child: const Icon(Icons.keyboard_arrow_left),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Get.to(() => const SearchScreen());
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: commonContainerDecoration(),
                            child: const Icon(Icons.search),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Container(
                          height: 35,
                          width: 35,
                          decoration: commonContainerDecoration(),
                          child: const Icon(Icons.share),
                        ),
                      ],
                    ).paddingOnly(top: 55, left: 15, right: 15),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Amerika Foods", style: black20w600).paddingOnly(left: 15),
                    Container(
                      height: 35,
                      width: 35,
                      decoration: commonContainerDecoration(
                        borderColor: lightGrey,
                      ),
                      child: const Icon(Icons.favorite_border, size: 20),
                    ).paddingOnly(right: 15),
                  ],
                ),
                const Text("American, Fast Food, Burgers", style: grey16w400).paddingOnly(left: 15),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber).paddingOnly(right: 5, left: 10),
                    const Text("4.5", style: black15w500),
                    Container(height: 20, width: 1, color: darkGrey).paddingOnly(left: 15, right: 15),
                    const Icon(Icons.comment, color: green),
                    const Text("1K+ reviews", style: black15w500).paddingOnly(left: 5),
                    Container(height: 20, width: 1, color: darkGrey).paddingOnly(left: 15, right: 15),
                    const Icon(Icons.access_time_outlined, color: Colors.blue),
                    const Text("15 mins", style: black15w500).paddingOnly(left: 5, right: 10),
                  ],
                ),
                const SizedBox(height: 15),
                const Divider().paddingSymmetric(horizontal: 10),
                const SizedBox(height: 10),
                StreamBuilder(
                  stream: foodType.stream,
                  builder: (context, snapshot) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          list.length,
                          (index) {
                            return InkWell(
                              onTap: () {
                                foodType.value = list[index];
                                fetchFood(selectedIndex: index);
                                print("foodType===>${foodType.value}");
                              },
                              child: Container(
                                constraints: const BoxConstraints(maxWidth: 140),
                                // color: Colors.lime,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      list[index],
                                      style: foodType.value == list[index] ? green15w400 : grey15w400,
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      color: foodType.value == list[index] ? green : Colors.transparent,
                                      height: 2,
                                      // width: Get.width,
                                    ),
                                  ],
                                ).paddingOnly(right: 20, left: index == 0 ? 15 : 0),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
                const Divider(height: 10),
                const SizedBox(height: 15),
                Expanded(
                  child: SingleChildScrollView(
                      child: StreamBuilder(
                          stream: foodData.stream,
                          builder: (context, snapshot) {
                            return Column(
                              children: [
                                ...List.generate(foodData.length, (index) {
                                  return Column(
                                    children: [
                                      commonNewFoodRow(data: foodData[index]),
                                      // commonFoodRow(
                                      //   price: foodData[index].price,
                                      //   mainText: foodData[index].mainText,
                                      //   qty: foodData[index].qty,
                                      //   minusBorderColor: foodData[index].qty != 0 ? green : darkGrey,
                                      //   minusContainerColor: foodData[index].qty != 0 ? green.withOpacity(0.1) : Colors.transparent,
                                      //   minusOnTap: () {
                                      //     if ((foodData[index].qty ?? 0) > 0) {
                                      //       bottomBar.value = false;
                                      //       foodData[index].qty--;
                                      //
                                      //       totalItem--;
                                      //       totalOrderPrice -= foodData[index].price ?? 0;
                                      //
                                      //       print("foodData[index]['qty']===>${foodData[index].qty}");
                                      //       setState(() {});
                                      //     }
                                      //   },
                                      //   plusOnTap: () {
                                      //     setState(() {
                                      //       bottomBar.value = true;
                                      //       foodData[index].qty++;
                                      //       totalItem++;
                                      //       totalOrderPrice += foodData[index].price ?? 0;
                                      //       print("foodData[index]['qty']===>${foodData[index].qty}");
                                      //     });
                                      //   },
                                      // ),
                                      const Divider(indent: 15, endIndent: 15),
                                      const SizedBox(height: 10),
                                    ],
                                  );
                                }),
                              ],
                            );
                          })),
                ),
              ],
            ),
          );
        });
  }
}
