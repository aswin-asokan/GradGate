import 'package:flutter/material.dart';
import 'package:gradgate/colors.dart';

Widget collSelect(List<String> colleges) {
  return Column(
    children: [
      const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "College",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<String>.empty();
              }
              return colleges.where((String option) {
                return option.toLowerCase().contains(
                      textEditingValue.text.toLowerCase(),
                    );
              });
            },
            onSelected: (String selection) {
              print('You selected: $selection');
            },
            fieldViewBuilder: (BuildContext context,
                TextEditingController textEditingController,
                FocusNode focusNode,
                VoidCallback onFieldSubmitted) {
              return TextField(
                controller: textEditingController,
                focusNode: focusNode,
                decoration: InputDecoration(
                  hintText: "Enter college name",
                  hintStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400),
                  counterText: "",
                  fillColor: textField,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: textField),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: textField),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: textField),
                  ),
                ),
              );
            },
            optionsViewBuilder: (BuildContext context,
                AutocompleteOnSelected<String> onSelected,
                Iterable<String> options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: textField, // Same background color as TextField
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: textField), // Match borders
                    ),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final String option = options.elementAt(index);
                        return ListTile(
                          title: Text(option),
                          onTap: () {
                            onSelected(option);
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ],
  );
}
