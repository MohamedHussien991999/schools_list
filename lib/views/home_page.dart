import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schools_list/config/route/scale_route.dart';
import 'package:schools_list/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:schools_list/cubit/app_cubit/app_cubit_state.dart';
import 'package:schools_list/views/filter_page.dart';
import 'package:schools_list/views/my_favorites_page.dart';
import 'package:schools_list/views/search_page.dart';
import 'package:schools_list/widgets/custom_bottom_app_bar.dart';
import 'package:schools_list/widgets/home/home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    MediaQuery.of(context).orientation == Orientation.portrait
        ? height = MediaQuery.of(context).size.height
        : height = MediaQuery.of(context).size.width;

    MediaQuery.of(context).orientation == Orientation.portrait
        ? width = MediaQuery.of(context).size.width
        : width = MediaQuery.of(context).size.height; // Get the screen size
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('School List'),
        backgroundColor: Colors.white,
        toolbarHeight:
            MediaQuery.of(context).orientation == Orientation.portrait
                ? height * 0.1
                : height * 0.05, // Adjust the height as needed
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: width * 0.05),
          child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const FilterPage();
                }));
              },
              child: Image.asset(
                'assets/images/filter.png',
              )),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.1),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(context, ScaleRoute(page: const SearchPage()));
                },
                child: Image.asset(
                  'assets/images/search.png',
                  width: width * 0.08,
                  height: height * 0.08,
                )),
          ),
        ],
        // Adding a bottom section to the AppBar
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(height * 0.07),
          child: const CustomBottomAppBar(),
        ),
      ),
      body: BlocConsumer<SchoolsCubit, SchoolsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SchoolsCubit.get(context).color1 == Colors.green
              ? const HomeBody()
              : const MyFavorites();
        },
      ),
    );
  }
}
