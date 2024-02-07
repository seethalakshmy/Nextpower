import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/infrastructure/dal/models/vehicles/VehicleMakersResponse.dart';
import 'package:project/infrastructure/widgets/text/title_widget.dart';

class VehicleMakeTextEdit extends StatelessWidget {
  const VehicleMakeTextEdit(
      {required this.list, this.title, this.onSelected, this.onTextChange});

  final List<MakersItem> list;
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
          child: Autocomplete<MakersItem>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              query = textEditingValue.text;
              final Iterable<MakersItem> options = search(query);
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
            optionsViewBuilder: (context, Function(MakersItem) onSelected,
                Iterable<MakersItem> options) {
              return ListView(
                children: options
                    .map<Widget>((MakersItem option) => Material(
                          child: ListTile(
                            title: Text(
                              option.title!,
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
            displayStringForOption: (MakersItem option) => option.title ?? "",
            onSelected: (MakersItem value) {
              if (onSelected != null) {
                onSelected!(value);
              }
            },
          ),
        ),
      ],
    );
  }

  Iterable<MakersItem> search(String query) {
    if (query == '') {
      return const Iterable<MakersItem>.empty();
    }
    return list.where((MakersItem option) {
      return option.title!.toLowerCase().contains(query.toLowerCase());
    });
  }
}
