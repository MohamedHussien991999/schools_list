import 'package:flutter/material.dart';
import 'package:schools_list/config/route/scale_route.dart';
import 'package:schools_list/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:schools_list/views/home_page.dart';
import 'package:schools_list/widgets/body_search/body_search_landscape.dart';
import 'package:schools_list/widgets/body_search/custom_body_search.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    MediaQuery.of(context).orientation == Orientation.portrait
        ? h = MediaQuery.of(context).size.height
        : h = MediaQuery.of(context).size.width;

    MediaQuery.of(context).orientation == Orientation.portrait
        ? width = MediaQuery.of(context).size.width
        : width = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1A237E),
          leading: Padding(
            padding: EdgeInsets.only(left: width * 0.03),
            child: IconButton(
                onPressed: () {
                  SchoolsCubit.get(context).searchSchools.clear();
                  SchoolsCubit.get(context).searchType = null;
                  

                  Navigator.pushAndRemoveUntil(
                    context,
                    ScaleRoute(page: const HomePage()),
                    (Route<dynamic> route) => false,
                  );
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: h * 0.05,
                  color: Colors.white,
                )),
          ),
          title: const Text(
            'Search',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: OrientationBuilder(
            builder: (context, orientation) =>
                orientation == Orientation.portrait
                    ? const CustomBodySearch()
                    : const CustomBodySearchLandscape()));
  }
}
