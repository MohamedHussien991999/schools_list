import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schools_list/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:schools_list/cubit/app_cubit/app_cubit_state.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    MediaQuery.of(context).orientation == Orientation.portrait
        ? height = MediaQuery.of(context).size.height
        : height = MediaQuery.of(context).size.width;

    MediaQuery.of(context).orientation == Orientation.portrait
        ? width = MediaQuery.of(context).size.width
        : width = MediaQuery.of(context).size.height;
    return BlocConsumer<SchoolsCubit, SchoolsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var color1 = SchoolsCubit.get(context).color1;
        var color2 = SchoolsCubit.get(context).color2;
        return Container(
          padding: EdgeInsets.all(height * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    SchoolsCubit.get(context).changeColor1('color1');
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: height * 0.019),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: color1,
                          width: width * 0.015,
                        ),
                      ),
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      'School',
                      style: TextStyle(
                          fontSize: height * 0.025,
                          color: color1,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Action when the "School" button is pressed
                    SchoolsCubit.get(context).changeColor1('color2');
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: height * 0.019),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: color2,
                          width: width * 0.015,
                        ),
                      ),
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      'My Favorites',
                      style: TextStyle(
                          fontSize: height * 0.025,
                          color: color2,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
