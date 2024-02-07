import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/infrastructure/dal/models/vehicles/VehicleModelsResponse.dart';
import 'package:project/infrastructure/widgets/text/title_widget.dart';

class VehicleModelTextEdit extends StatelessWidget {
  const VehicleModelTextEdit({required this.list, this.title, this.onSelected,this.onTextChange});

  final List<ModelsItem> list;
  final String? title;
  final Function? onSelected;
  final Function? onTextChange;

  @override
  Widget build(BuildContext context) {
    String query = "";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(title: title ?? ""),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Colors.grey.withOpacity(0.6), // Set border color
              width: 1, // Set border width
            ),
          ),
          child: Autocomplete<ModelsItem>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              query = textEditingValue.text;
              final Iterable<ModelsItem> options = search(query);
              return options;
            },
            fieldViewBuilder: (BuildContext context,
                TextEditingController controller,
                FocusNode focusNode,
                VoidCallback onFieldSubmitted) {
              return TextField(
                controller: controller,
                focusNode: focusNode,
                onChanged: (value){
                  if(onTextChange!=null){
                    onTextChange!(value);
                  }
                },
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 5)),
              );
            },
            optionsViewBuilder: (context, Function(ModelsItem) onSelected,
                Iterable<ModelsItem> options) {
              return ListView(
                children: options
                    .map<Widget>((ModelsItem option) => Material(
                          child: ListTile(
                            title: Text(
                              option.name!,
                              style: const TextStyle(
                                  color: Colors
                                      .black), // Customize text color here
                            ),
                            onTap: () {
                              onSelected(option);
                            },
                          ),
                        ))
                    .toList(),
              );
            },
            displayStringForOption: (ModelsItem option) => option.name ?? "",
            onSelected: (ModelsItem value) {
              if (onSelected != null) {
                onSelected!(value);
              }
            },
          ),
        ),
      ],
    );
  }

  Iterable<ModelsItem> search(String query) {
    if (query == '') {
      return const Iterable<ModelsItem>.empty();
    }
    return list.where((ModelsItem option) {
      return option.name!.toLowerCase().contains(query.toLowerCase());
    });
  }
}
