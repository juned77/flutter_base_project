import 'package:flutter/material.dart';

/* return CustomDropDown<CitiesModelRows>(
                                  valueChanged: (value) {
                                    cityName = value.city.toString();
                                  },
                                  hint: 'City',
                                  // dataSet: citiesModel.data!.data,
                                  items: citiesModel.data?.rows?.map((CitiesModelRows innerCityData) {
                                    return DropdownMenuItem<CitiesModelRows>(
                                      value: innerCityData,
                                      child: Text(
                                        innerCityData.city ?? '',
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                ) */

class CustomDropDown<T> extends StatefulWidget {
  final Key? key;

  final DropdownMenuItem<T> Function(T selectedVendorTypesData)? dropDownItem;
  final String hint;
  final T? value;
  final ValueChanged valueChanged;
  final List<DropdownMenuItem<T>>? items;

  const CustomDropDown({
    this.key,
    required this.hint,
    required this.items,
    this.dropDownItem,
    this.value,
    required this.valueChanged,
  }) : super(key: key);

  @override
  _CustomDropDownState<T> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown> {
  T? selectedVendorTypesData;
  List<DropdownMenuItem<T>>? items;

  @override
  void initState() {
    items = widget.items as List<DropdownMenuItem<T>>?;
    selectedVendorTypesData = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10.0))),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          value: selectedVendorTypesData,
          hint: new Text(widget.hint),
          onChanged: (T? newValue) {
            selectedVendorTypesData = newValue!;

            // widget.selectedVendorTypesData!(newValue);
            widget.valueChanged(newValue);
            setState(() {});
          },
          items: items,
        ),
      ),
    );
  }
}
