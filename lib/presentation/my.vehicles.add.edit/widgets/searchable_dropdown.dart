import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:project/infrastructure/dal/models/vehicles/VehicleMakersResponse.dart';

import '../../../infrastructure/dal/models/vehicles/VehicleModelsResponse.dart';
import '../../../infrastructure/widgets/text/title_widget.dart';
import '../../my.vehicles.add.edit/controllers/my_vehicles_add_edit.controller.dart';

class SearchableDropdown extends StatelessWidget {
  const SearchableDropdown(
      {super.key,
      required this.title,
      required this.controller,
      this.onSelected,
      required this.fromMakers,
      this.onSelectedModel});

  final MyVehiclesAddEditController controller;
  final String title;
  final Function(MakersItem item)? onSelected;
  final Function(ModelsItem item)? onSelectedModel;
  final bool fromMakers;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWidget(title: title ?? ""),
          const SizedBox(height: 10),
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: Colors.grey.withOpacity(0.6), // Set border color
                width: 1, // Set border width
              ),
            ),
            child: Obx(() {
              return DropdownButtonHideUnderline(
                child: fromMakers
                    ? DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Select Item',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: controller.makersNameList
                            .map((item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item ?? "",
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: controller.selectedMaker?.value != ""
                            ? controller.selectedMaker?.value
                            : null,
                        onChanged: (value) {
                          if (value != null && onSelected != null) {
                            controller.selectedMaker?.value = value;
                            MakersItem? selectedMakerItem;
                            for (var maker in controller.makers) {
                              if (maker.title == value) {
                                selectedMakerItem = maker;
                                break;
                              }
                            }
                            if (selectedMakerItem != null) {
                              onSelected!(selectedMakerItem);
                              controller.makeId =
                                  "${selectedMakerItem.id ?? 0}";
                              controller.getVehicleModelList();
                            }
                          }
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 200,
                        ),
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 200,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        dropdownSearchData: DropdownSearchData(
                          searchController: controller.textEditingController,
                          searchInnerWidgetHeight: 50,
                          searchInnerWidget: Container(
                            height: 50,
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 4,
                              right: 8,
                              left: 8,
                            ),
                            child: TextFormField(
                              expands: true,
                              maxLines: null,
                              controller: controller.textEditingController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Search for an item...',
                                hintStyle: const TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          searchMatchFn: (item, searchValue) {
                            return item.value.toString().contains(searchValue);
                          },
                        ),
                        //This to clear the search value when you close the menu
                        onMenuStateChange: (isOpen) {
                          if (!isOpen) {
                            controller.textEditingController.clear();
                          }
                        },
                      )
                    : DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Select Item',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: controller.modelNameList
                            .map((item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: controller.selectedModel?.value != ""
                            ? controller.selectedModel?.value
                            : null,
                        onChanged: (value) {
                          if (value != null && onSelectedModel != null) {
                            controller.selectedModel?.value = value;
                            ModelsItem? selectedModelItem;
                            for (var model in controller.models) {
                              if (model.name == value) {
                                selectedModelItem = model;
                                break;
                              }
                            }
                            if (selectedModelItem != null) {
                              onSelectedModel!(selectedModelItem);
                            }
                          }
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 200,
                        ),
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 200,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        dropdownSearchData: DropdownSearchData(
                          searchController: controller.textEditingController,
                          searchInnerWidgetHeight: 50,
                          searchInnerWidget: Container(
                            height: 50,
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 4,
                              right: 8,
                              left: 8,
                            ),
                            child: TextFormField(
                              expands: true,
                              maxLines: null,
                              controller: controller.textEditingController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Search for an item...',
                                hintStyle: const TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          searchMatchFn: (item, searchValue) {
                            return item.value.toString().contains(searchValue);
                          },
                        ),
                        //This to clear the search value when you close the menu
                        onMenuStateChange: (isOpen) {
                          if (!isOpen) {
                            controller.textEditingController.clear();
                          }
                        },
                      ),
              );
            }),
          ),
        ],
      );
    });
  }
}
