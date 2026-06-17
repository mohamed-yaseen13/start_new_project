import 'package:flutter/material.dart';


abstract class DropDownClass<T> extends ChangeNotifier{
  String displayedName();
  String? titleName();
  bool require();
  Widget? displayedWidget();
  String displayedOptionName(T type);
  Widget? displayedOptionWidget(T type);
  Future onTap(T? data);
  List<T>? list();
  T? selected();
  dynamic value();
}


abstract class DropPaginationSearchDownClass<T>
    extends DropDownClass<T> {

  ScrollController  scrollController = ScrollController();
  TextEditingController searchText = TextEditingController();

  bool haveSearch = false;
  bool havePagination = false;

  int pageIndex = 1;
  bool paginationStarted = false;
  bool paginationFinished = false;



  void pagination();

  void onChange(String p1);
}

// class CityProvider extends DropDownClass<int>{
//
// }

// class UserProvider extends DropPaginationSearchDownClass<int>{
//   UserProvider(){
//     haveSearch = true;
//     havePagination = true;
//   }
//
// }





