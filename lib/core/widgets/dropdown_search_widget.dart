import 'package:flutter/material.dart';
import '../Theme/app_theme.dart';
import '../models/drop_down_class.dart';
import '../models/text_field_model.dart';
import 'list_text_field_widget.dart';

class DropdownSearchWidget extends StatelessWidget {
  const DropdownSearchWidget({
    super.key,
    required this.dropPaginationSearchDownClass,
  });

  final DropPaginationSearchDownClass dropPaginationSearchDownClass;
  @override
  Widget build(BuildContext context) {
    return ListTextFieldWidget(
      inputs: [
        TextFieldModel(
          key: 'search',
          controller: dropPaginationSearchDownClass.searchText,
          prefix: Icon(Icons.search, color: context.colors.primary),
          onChange: dropPaginationSearchDownClass.onChange,
        ),
      ],
    );
  }
}
