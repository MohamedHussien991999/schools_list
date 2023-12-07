import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schools_list/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:schools_list/cubit/app_cubit/app_cubit_state.dart';
import 'package:schools_list/widgets/custom_drop_down.dart';
import 'package:schools_list/widgets/school_item/school_item.dart';
import 'package:schools_list/widgets/school_item/school_item_landscape.dart';

class BodyHomePage extends StatelessWidget {
  const BodyHomePage({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    String selectedValue = SchoolsCubit.get(context).sortType;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<SchoolsCubit, SchoolsStates>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[200],
                  ),
                  child: CustomDropDown(
                      selectedValue:
                          selectedValue.isNotEmpty ? selectedValue : null,
                      onChanged: (value) {
                        SchoolsCubit.get(context).sortType = value!;
                        SchoolsCubit.get(context).sortSchools();
                      },
                      validateDropdown: (value) {
                        return null;
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 'Ascendingly',
                          child: Text('Ascendingly'),
                        ),
                        DropdownMenuItem(
                          value: 'Descendingly',
                          child: Text('Descendingly'),
                        ),
                      ],
                      labelText: 'Sort By',
                      hintText: 'Select Sort Type')),
              SizedBox(
                height: height * 0.02,
              ),
             
             
              Expanded(
                child: OrientationBuilder(
                  builder: (context, orientation) {
                    if (orientation == Orientation.portrait) {
                      return ListView.separated(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return SchoolItem(
                            schoolModel:
                                SchoolsCubit.get(context).schools[index],
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: height * 0.02,
                        ),
                        itemCount: SchoolsCubit.get(context).schools.length,
                      );
                    } else {
                      return GridView.builder(
                        controller: _scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return SchoolItemLandscape(
                            schoolModel:
                                SchoolsCubit.get(context).schools[index],
                          );
                        },
                        itemCount: SchoolsCubit.get(context).schools.length,
                      );
                    }
                  },
                ),
              ),
             
             
              if (state is LoadingLoadMoreSchoolsState)
                Padding(
                  padding: EdgeInsets.all(height * 0.02),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}