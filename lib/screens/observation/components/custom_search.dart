import 'package:flutter/material.dart';

class CustomSearchInput extends StatefulWidget {
  final Function(String) onSearchChanged;
  final bool readOnly;

  const CustomSearchInput({
    Key? key, 
    this.readOnly = false,
    required this.onSearchChanged
  })
      : super(key: key);

  @override
  State<CustomSearchInput> createState() => _CustomSearchInputState();
}

class _CustomSearchInputState extends State<CustomSearchInput> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    searchController.addListener(() {
      widget.onSearchChanged(searchController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          readOnly: widget.readOnly,
          cursorColor: Colors.black,
          controller: searchController,
          style: const TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            filled: true,
            fillColor: const Color(0xFFC3C3C3),
            labelStyle: const TextStyle(
              color: Colors.transparent,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            suffixIcon: searchController.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      searchController.clear();
                      widget.onSearchChanged('');
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
