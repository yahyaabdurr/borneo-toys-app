import 'package:borneo_toys/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryController extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  TextEditingController searchQuery = TextEditingController();

  Future<List<Category>>? categoryList;
  List<Category> retrievedCategorysList = [];
  List<Category> tempCategoryList = [];

  List<String> poolSearch = [];

  void initData() async {
    searchQuery.clear();
    retrievedCategorysList = [];
    categoryList = null;
    notifyListeners();
    categoryList = retrieveCategories();
    tempCategoryList = await retrieveCategories();
    // tempCategoryList.insert(
    //     0,
    //     Category(
    //         categoryId: "",
    //         categoryDesc: "Semua",
    //         effectiveDate: "2022-08-22 05:50:09",
    //         active: true));
    addToPoolSearch();
    searchData();
  }

  Future<void> addToPoolSearch() async {
    poolSearch = [];

    for (Category value in tempCategoryList) {
      poolSearch.add(value.categoryDesc);
    }

    notifyListeners();
  }

  void searchData() {
    retrievedCategorysList = [];
    notifyListeners();
    List<Category> categoryAfterSearch = [];
    if (searchQuery.text.isEmpty) {
      retrievedCategorysList = tempCategoryList;
    } else {
      int index = 0;
      for (String value in poolSearch) {
        if (value.toLowerCase().contains(searchQuery.text.toLowerCase())) {
          categoryAfterSearch.add(tempCategoryList.elementAt(index));
        }

        index++;
      }

      retrievedCategorysList = categoryAfterSearch;
      notifyListeners();
    }
  }

  Future<List<Category>> retrieveCategories() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("categories").get();
    return snapshot.docs
        .map((docSnapshot) => Category.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}
