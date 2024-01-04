import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_v2_proj/components/error_message.dart';
import 'package:weather_app_v2_proj/functions/api.dart';
import 'package:weather_app_v2_proj/models/city.dart';
import 'package:weather_app_v2_proj/provider/provider.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buidlSuggest();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buidlSuggest();
  }

  FutureBuilder<dynamic> buidlSuggest() {
    return FutureBuilder(
      future: fettchData(query),
      builder: (context, snapshot) {
        if (snapshot.data == false) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<MyProvider>().isconnected = false;
          });
          return const ErrorMessage(
              message:
                  'No internet connection, please enable it in your App settings');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error fetshing data'),
          );
        }
        if (snapshot.data == null) {
          return Center(
            child: Text('No locations found for $query'),
          );
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<MyProvider>().isconnected = true;
        });
        final cities = snapshot.data;
        return ListView.builder(
            itemCount: cities.length,
            itemBuilder: (context, index) {
              final Cities city = Cities.fromJson(cities[index]);
              return ListTile(
                onTap: () {
                  final prov = context.read<MyProvider>();
                  fetchWeatherData(city.latitude, city.longitude).then((curr) {
                    prov.city = city;
                    prov.city.currentWeather = curr;
                    prov.permission = true;
                    close(context, null);
                  });
                },
                leading:
                    Text('${city.name} | ${city.admin1} | ${city.country}'),
              );
            });
      },
    );
  }
}
