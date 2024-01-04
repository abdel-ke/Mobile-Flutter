import 'package:flutter/material.dart';
import 'package:weather_final_proj/functions/connection.dart';
import 'package:weather_final_proj/models/custom_search_delegate.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: titleContent(context),
      actions: [
        const VerticalDivider(
          color: Colors.grey,
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
              icon: const Icon(
                Icons.location_on_outlined,
                color: Colors.white,
              )),
        ),
      ],
    );
  }

  Padding titleContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: TextField(
          readOnly: true,
          textInputAction: TextInputAction.done,
          onTap: () async {
            await showSearch(
                context: context, delegate: CustomSearchDelegate());
          },
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.white),
              hintText: 'Search...',
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}
