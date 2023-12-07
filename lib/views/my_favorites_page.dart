import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schools_list/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:schools_list/cubit/app_cubit/app_cubit_state.dart';
import 'package:schools_list/widgets/school_item/school_item.dart';

class MyFavorites extends StatelessWidget {
  const MyFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Get the screen size
    return BlocConsumer<SchoolsCubit, SchoolsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (SchoolsCubit.get(context).favoriteSchools.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.01, vertical: height * 0.09),
            child: Center(
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/images/empty.svg",
                    height: height * 0.4,
                    width: width * 0.4,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  const Text(
                    'No Favorites School',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            ),
          );
        } else {
          return ListView.builder(
            itemBuilder: (context, index) => SchoolItem(
                schoolModel: SchoolsCubit.get(context).favoriteSchools[index]),
            itemCount: SchoolsCubit.get(context).favoriteSchools.length,
          );
        }
      },
    );
  }
}
