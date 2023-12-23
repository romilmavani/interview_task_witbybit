import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task/modules/models/food_model.dart';
import 'package:interview_task/utils/common_colors.dart';
import 'package:interview_task/utils/common_functions.dart';
import 'package:interview_task/utils/common_text_style.dart';
import 'package:interview_task/utils/common_widgets.dart';

import 'home_screen.dart';
import 'main.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searching = Searching();
  RxList<FoodModel> searchFoodData = <FoodModel>[].obs;
  TextEditingController searchController = TextEditingController();
  RxList<String> searchList = [
    'Burgers',
    'Chickens',
    'Fries',
    'Beverages',
    'Sides',
    'Desserts',
  ].obs;

  @override
  void initState() {
    // TODO: implement initState
    if (getPreference.read("searchList") != null && getPreference.read("searchList").isNotEmpty) {
      List dataList = getPreference.read("searchList") ?? [];
      dataList.forEach((element) {
        searchList.add(element);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: StreamBuilder(
          stream: totalItem.stream,
          builder: (context, snapshot) {
            return totalItem > 0
                ? StreamBuilder(
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
                    })
                : const SizedBox();
          }),
      body: SafeArea(
        child: StreamBuilder(
            stream: searchList.stream,
            builder: (context, snapshot) {
              return StreamBuilder(
                  stream: searchFoodData.stream,
                  builder: (context, snapshot) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const SizedBox(width: 15),
                            InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Icon(
                                  Icons.keyboard_arrow_left,
                                  size: 28,
                                )),
                            const SizedBox(width: 15),
                            Expanded(
                              child: TextField(
                                controller: searchController,
                                onSubmitted: (value) {
                                  searchFoodData.clear();
                                  if (value.isNotEmpty) {
                                    searchList.add(value);
                                    foodData.forEach((element) {
                                      if (element.mainText
                                          .toString()
                                          .removeAllWhitespace
                                          .replaceAll(" ", '')
                                          .toLowerCase()
                                          .contains(value.removeAllWhitespace.replaceAll(" ", '').toLowerCase())) {
                                        searchFoodData.add(element);
                                      }
                                    });
                                    getPreference.write("searchList", searchList);
                                    print("searchList===>$searchList");
                                  }
                                },
                                onChanged: (value) {
                                  print("valueeeee $value");
                                  searching.run(() {
                                    searchFoodData.clear();
                                    if (value.isNotEmpty) {
                                      searchList.add(value);
                                      foodData.forEach((element) {
                                        if (element.mainText
                                            .toString()
                                            .removeAllWhitespace
                                            .replaceAll(" ", '')
                                            .toLowerCase()
                                            .contains(value.removeAllWhitespace.replaceAll(" ", '').toLowerCase())) {
                                          searchFoodData.add(element);
                                        }
                                      });
                                      getPreference.write("searchList", searchList);
                                      print("searchList===>$searchList");
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                                  isDense: true,
                                  hintText: "Search",
                                  hintStyle: grey15w400,
                                  prefixIcon: const Icon(
                                    Icons.search_outlined,
                                    size: 23,
                                  ).paddingOnly(left: 5),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      searchController.clear();
                                    },
                                    child: const Icon(
                                      Icons.clear,
                                      size: 23,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: lightGrey,
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: lightGrey,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: lightGrey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                          ],
                        ),
                        const SizedBox(height: 15),
                        if (searchController.text.isEmpty) ...[
                          const Text("Search recommendations", style: grey14w400).paddingOnly(left: 15),
                          const SizedBox(height: 15),
                          Wrap(
                            children: [
                              ...List.generate(searchList.length, (index) {
                                return InkWell(
                                  onTap: () {
                                    searchController.text = searchList[index];
                                    foodData.forEach((element) {
                                      if (element.mainText
                                          .toString()
                                          .removeAllWhitespace
                                          .replaceAll(" ", '')
                                          .toLowerCase()
                                          .contains(searchController.text.removeAllWhitespace.replaceAll(" ", '').toLowerCase())) {
                                        searchFoodData.add(element);
                                      }
                                    });
                                  },
                                  child: Container(
                                    decoration: commonContainerDecoration(
                                      color: green.withOpacity(0.1),
                                      borderRadius: 5,
                                    ),
                                    child: Text(searchList[index], style: green15w400).paddingSymmetric(horizontal: 10, vertical: 5),
                                  ).paddingOnly(left: 5, right: 5, bottom: 5, top: 5),
                                );
                              }),
                            ],
                          ).paddingOnly(left: 10, right: 10),
                        ],
                        if (searchController.text.isNotEmpty) ...[
                          if (searchFoodData.isNotEmpty) Text("${searchFoodData.length} Search results...", style: black14w400).paddingOnly(left: 15),
                          const SizedBox(height: 15),
                          Expanded(
                            child: SingleChildScrollView(
                                child: Column(
                              children: [
                                ...List.generate(searchFoodData.length, (index) {
                                  return Column(
                                    children: [
                                      commonNewFoodRow(data: searchFoodData[index]),

                                      // commonFoodRow(
                                      //   price: searchFoodData[index].price,
                                      //   mainText: searchFoodData[index].mainText,
                                      //   qty: searchFoodData[index].qty,
                                      //   minusBorderColor: searchFoodData[index].qty != 0 ? green : darkGrey,
                                      //   minusContainerColor: searchFoodData[index].qty != 0 ? green.withOpacity(0.1) : Colors.transparent,
                                      //   minusOnTap: () {
                                      //     if (searchFoodData[index].qty > 0) {
                                      //       searchFoodData[index].qty--;
                                      //       print("foodData[index].qty===>${searchFoodData[index].qty}");
                                      //     }
                                      //   },
                                      //   plusOnTap: () {
                                      //     foodData[index].qty++;
                                      //     print("foodData[index].qty===>${foodData[index].qty}");
                                      //   },
                                      // ),
                                      const Divider(indent: 15, endIndent: 15),
                                      const SizedBox(height: 10),
                                    ],
                                  );
                                }),
                              ],
                            )),
                          ),
                        ],
                      ],
                    );
                  });
            }),
      ),
    );
  }
}
