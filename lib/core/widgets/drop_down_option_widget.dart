import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/constants.dart';
import '../models/drop_down_class.dart';

class DropDownOptionWidget extends StatefulWidget {
  final DropDownClass dropDownClass;
  final dynamic data;
  final dynamic selected;
  final void Function() rebuild;

  const DropDownOptionWidget({
    required this.dropDownClass,
    super.key,
    required this.data,
    required this.rebuild,
    this.selected,
  });

  @override
  State<DropDownOptionWidget> createState() => _DropDownOptionWidgetState();
}

class _DropDownOptionWidgetState extends State<DropDownOptionWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.01.sh),
      child: InkWell(
        onTap: () {
          widget.rebuild();
        },
        child: Container(
          width: .90.sw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: colors.surface, // theme-aware
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: Constants.isTablet ? .02.sh : 0.01.sh,
            ),
            child: ListTile(
              leading: Transform.scale(
                scale: Constants.isTablet ? 2 : 1,
                child: RadioGroup<dynamic>(
                  groupValue: widget.selected,
                  onChanged: (val) {
                    widget.rebuild();
                  },
                  child: Radio<dynamic>(
                    value: widget.data,
                    activeColor: colors.primary,
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),
              horizontalTitleGap: .02.sw,
              visualDensity: VisualDensity.compact,
              title: Row(
                children: [
                  widget.dropDownClass.displayedOptionWidget(widget.data) ??
                      const SizedBox(),
                  if (widget.dropDownClass.displayedOptionWidget(widget.data) !=
                      null)
                    SizedBox(width: .02.sw),
                  Expanded(
                    child: Text(
                      widget.dropDownClass.displayedOptionName(widget.data),
                      style: textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
