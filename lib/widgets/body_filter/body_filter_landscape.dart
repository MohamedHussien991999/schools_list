import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schools_list/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:schools_list/cubit/app_cubit/app_cubit_state.dart';
import 'package:schools_list/widgets/custom_drop_down.dart';
import 'package:schools_list/widgets/school_item/school_item_landscape.dart';

class CustomBodyFilterLandscaper extends StatelessWidget {
  const CustomBodyFilterLandscaper({super.key});

  @override
  Widget build(BuildContext context) {
    String? selectedValue = '';
    String? selectedValue2 = '';

    final formKey = GlobalKey<FormState>();
    String? validateDropdown(String? value) {
      if (value == null || value.isEmpty) {
        return 'Please select an option';
      }
      return null;
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.09),
        child: BlocBuilder<SchoolsCubit, SchoolsStates>(
          builder: (context, state) {
            if (state is LoadingGetSchoolsSearchState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomDropDown(
                                hintText: 'Select Filter Type',
                                labelText: 'Filter Type',
                                items: const [
                                  DropdownMenuItem(
                                      value: 'type',
                                      child: Text('Type School')),
                                  DropdownMenuItem(
                                      value: 'level', child: Text('Level')),
                                  DropdownMenuItem(
                                      value: 'language',
                                      child: Text('Language')),
                                ],
                                selectedValue:
                                    SchoolsCubit.get(context).filterChoice,
                                onChanged: (value1) {
                                  selectedValue = value1!;
                                  selectedValue2 = '';
                                  SchoolsCubit.get(context).filterChoice =
                                      value1;
                                  SchoolsCubit.get(context)
                                      .changeFilterType(value1);
                                },
                                validateDropdown: validateDropdown,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.0,
                            ),
                            Expanded(
                              child: CustomDropDown(
                                hintText: 'Select Options Filter Type',
                                labelText: 'Filter Options Filter Type',
                                items:
                                    SchoolsCubit.get(context).filterChoiceList,
                                selectedValue: SchoolsCubit.get(context)
                                    .filterChoiceList?[0]
                                    .value,
                                onChanged: (value2) {
                                  selectedValue2 = value2!;
                                },
                                validateDropdown: validateDropdown,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      SchoolsCubit.get(context)
                                          .getListFilterSchools(
                                        filterOption: selectedValue2!,
                                        filterType: selectedValue!,
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Filter',
                                    style: TextStyle(fontSize: height * 0.04),
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Expanded(
                            child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.9,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return SchoolItemLandscape(
                              schoolModel: SchoolsCubit.get(context)
                                  .filterSchools[index],
                            );
                          },
                          itemCount:
                              SchoolsCubit.get(context).filterSchools.length,
                        )),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
