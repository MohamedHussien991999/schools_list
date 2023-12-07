import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schools_list/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:schools_list/cubit/app_cubit/app_cubit_state.dart';
import 'package:schools_list/widgets/custom_drop_down.dart';
import 'package:schools_list/widgets/school_item/school_item.dart';

class CustomBodySearch extends StatelessWidget {
  const CustomBodySearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? selectedValue;
    String search = '';
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
        padding: EdgeInsets.all(height * 0.035),
        child: BlocBuilder<SchoolsCubit, SchoolsStates>(
          builder: (context, state) {
            if (state is LoadingGetSchoolsSearchState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Form(
                key: formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Search must not be empty';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              search = value;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                shadows: [
                                  Shadow(
                                    color: Colors.grey,
                                    blurRadius: 1,
                                  ),
                                ],
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.02),
                          child: Image.asset(
                            'assets/images/search.png',
                            width: width * 0.07,
                            height: height * 0.07,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    CustomDropDown(
                      hintText: 'Select Search Type',
                      labelText: 'Search Type',
                      items: const [
                        DropdownMenuItem(value: 'name', child: Text('Name')),
                        DropdownMenuItem(value: 'type', child: Text('Type')),
                        DropdownMenuItem(value: 'level', child: Text('Level')),
                        DropdownMenuItem(
                            value: 'language', child: Text('Language')),
                        DropdownMenuItem(
                            value: 'street', child: Text('Street')),
                      ],
                      selectedValue: SchoolsCubit.get(context).searchType,
                      onChanged: (value) {
                        selectedValue = value!;
                        SchoolsCubit.get(context).searchType = value;
                      },
                      validateDropdown: validateDropdown,
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  SchoolsCubit.get(context)
                                      .getListSearchSchools(
                                          searchType: selectedValue!,
                                          searchText: search);
                                }
                              },
                              child: Text(
                                'Search',
                                style: TextStyle(fontSize: height * 0.04),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => SchoolItem(
                          schoolModel:
                              SchoolsCubit.get(context).searchSchools[index],
                        ),
                        itemCount:
                            SchoolsCubit.get(context).searchSchools.length,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
