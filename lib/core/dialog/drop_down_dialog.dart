import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../Theme/app_theme.dart';
import '../constants/app_lotties.dart';
import '../constants/constants.dart';
import '../helper_function/navigation.dart';
import '../models/drop_down_class.dart';
import '../widgets/button_widget.dart';
import '../widgets/drop_down_option_widget.dart';
import '../widgets/dropdown_search_widget.dart';
import '../widgets/empty_animation_widget.dart';
import '../widgets/loading_animation_widget.dart';
import '../widgets/loading_widget.dart';

Future showDropDownDialog<T extends DropDownClass>(T dropDownClass) async {
  bool haveSearch = false, havePagination = false;

  DropPaginationSearchDownClass? paginationDropdown =
      dropDownClass is DropPaginationSearchDownClass ? dropDownClass : null;
  if (paginationDropdown != null) {
    haveSearch = paginationDropdown.haveSearch;
    havePagination = paginationDropdown.havePagination;
    paginationDropdown.pagination();
  }

  dynamic selected = dropDownClass.selected();
  final context = Constants.globalContext();

  await showModalBottomSheet(
    context: context,
    backgroundColor: context.colors.surfaceContainerHighest.withValues(
      alpha: 0.9,
    ),
    isDismissible: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return ChangeNotifierProvider<T>.value(
        value: dropDownClass,
        child: Builder(
          builder: (context) {
            // final provider = context.watch<T>();
            paginationDropdown = dropDownClass is DropPaginationSearchDownClass
                ? dropDownClass
                : null;
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: InkWell(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  width: 1.sw,
                  constraints: BoxConstraints(
                    maxHeight: 0.65.sh,
                    minHeight: 0.65.sh,
                  ),
                  decoration: BoxDecoration(
                    color: context.colors.surfaceContainerHighest.withValues(
                      alpha: 0.9,
                    ),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.r),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 0.02.sh),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0.05.sw,
                        left: 0.05.sw,
                        child: SizedBox(
                          height: .55.sh,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (haveSearch && paginationDropdown != null) ...[
                                SizedBox(height: 0.01.sh),
                                DropdownSearchWidget(
                                  dropPaginationSearchDownClass:
                                      paginationDropdown!,
                                ),
                              ],
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 0.05.sh),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,

                                    children: [
                                      SizedBox(height: 0.01.sh),
                                      Expanded(
                                        child: Builder(
                                          builder: (context) {
                                            if (dropDownClass.list() == null) {
                                              return LoadingAnimationWidget(
                                                gif: AppLottie.loading,
                                              );
                                            } else if (dropDownClass
                                                .list()!
                                                .isEmpty) {
                                              return const EmptyAnimationWidget(
                                                gif: AppLottie.empty,
                                                title: 'no_data',
                                              );
                                            } else {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: StatefulBuilder(
                                                      builder: (context, setState) {
                                                        return SingleChildScrollView(
                                                          controller:
                                                              havePagination
                                                              ? paginationDropdown!
                                                                    .scrollController
                                                              : null,
                                                          child: Column(
                                                            children: List.generate(
                                                              dropDownClass
                                                                  .list()!
                                                                  .length,
                                                              (index) {
                                                                dynamic
                                                                data = dropDownClass
                                                                    .list()![index];
                                                                return DropDownOptionWidget(
                                                                  dropDownClass:
                                                                      dropDownClass,
                                                                  data: data,
                                                                  selected:
                                                                      selected,
                                                                  rebuild: () {
                                                                    selected =
                                                                        (selected ==
                                                                            data)
                                                                        ? null
                                                                        : data;
                                                                    setState(
                                                                      () {},
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  if (paginationDropdown
                                                          ?.paginationStarted ??
                                                      false) ...[
                                                    SizedBox(height: .01.sh),
                                                    LoadingWidget(),
                                                  ],
                                                ],
                                              );
                                            }
                                          },
                                        ),
                                      ),

                                      // SizedBox(height: .04.sh),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0.02.sh,
                        left: 0.05.sw,
                        right: 0.05.sw,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonWidget(
                              onTap: () async {
                                navPop();
                                await dropDownClass.onTap(selected);
                              },
                              text: 'save',
                              // optional: add dynamic button color from theme
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
