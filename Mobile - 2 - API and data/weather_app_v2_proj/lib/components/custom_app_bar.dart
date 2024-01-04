import 'package:flutter/material.dart';
import 'package:weather_app_v2_proj/components/custom_search_delegate.dart';
import 'package:weather_app_v2_proj/functions/connection.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey.shade100,
      title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white70, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: TextField(
            readOnly: true,
            onTap: () =>
                showSearch(context: context, delegate: CustomSearchDelegate()),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search...',
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      actions: [
        const VerticalDivider(
          color: Colors.black,
          thickness: 0.8,
          endIndent: 10,
          indent: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: IconButton(
              onPressed: () async {
                await getLocation(context);
              },
              icon: const Icon(Icons.location_on_outlined)),
        ),
      ],
    );
  }
}
