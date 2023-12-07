import 'package:flutter/material.dart';
import 'package:schools_list/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:schools_list/views/home_page.dart';
import 'package:schools_list/widgets/body_filter/body_filter_landscape.dart';
import 'package:schools_list/widgets/body_filter/custom_body_filter.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1A237E),
          leading: Padding(
            padding: EdgeInsets.only(left: width * 0.05),
            child: IconButton(
                onPressed: () {
                  SchoolsCubit.get(context).filterSchools.clear();
                  SchoolsCubit.get(context).filterChoiceList = null;
                   SchoolsCubit.get(context).filterChoice = null;

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const HomePage();
                  }));
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: height * 0.05,
                  color: Colors.white,
                )),
          ),
          title: const Text('Filter Schools',
              style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: OrientationBuilder(
            builder: (context, orientation) =>
                orientation == Orientation.portrait
                    ? const CustomBodyFilter()
                    : const CustomBodyFilterLandscaper()));
  }
}
