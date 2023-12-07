import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schools_list/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:schools_list/cubit/app_cubit/app_cubit_state.dart';
import 'package:schools_list/model/school_model.dart';
import 'package:schools_list/views/details_school.dart';

class SchoolItem extends StatelessWidget {
  const SchoolItem({super.key, required this.schoolModel});
  final SchoolModel schoolModel;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 5,
      child: Column(
        children: [
          BlocConsumer<SchoolsCubit, SchoolsStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return CachedNetworkImage(
                // Use CachedNetworkImage instead of CircleAvatar
                imageUrl: schoolModel.profilePhoto,
                imageBuilder: (context, imageProvider) => Stack(
                  children: [
                    Container(
                      height: height * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: height * 0.02,
                      right: width * 0.02,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color(0xffebedee),
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/location.png',
                              width: width * 0.05,
                              height: height * 0.03,
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Text(
                              schoolModel.street,
                              style: TextStyle(
                                fontSize: height * 0.016,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: height * 0.02,
                      right: width * 0.03,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xffebedee),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {
                            SchoolsCubit.get(context)
                                .changeFavorite(schoolModel);
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: schoolModel.isFavorite
                                ? Colors.red
                                : Colors.grey,
                            size: height * 0.05,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                placeholder: (context, url) =>
                    const CircularProgressIndicator(), // Loading indicator
                errorWidget: (context, url, error) => const Icon(Icons.error),
              );
            },
          ),
          ListTile(
            contentPadding:
                EdgeInsets.only(left: width * 0.03, top: width * 0.03),
            leading: CachedNetworkImage(
              // Use CachedNetworkImage instead of CircleAvatar
              imageUrl: schoolModel.profilePhoto,
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: 30,
                backgroundImage: imageProvider,
              ),
              placeholder: (context, url) =>
                  const CircularProgressIndicator(), // Loading indicator
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            title: Text(
              schoolModel.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: height * 0.019,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: height * 0.02),
              child: Text(
                'Type : ${schoolModel.type} \nLevel : ${schoolModel.level}    \nLanguage : ${schoolModel.language}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: height * 0.02,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailsSchool(
                  schoolModel: schoolModel,
                );
              }));
            },
            child: Padding(
              padding: EdgeInsets.only(
                  right: width * 0.02,
                  bottom: height * 0.02,
                  left: width * 0.02),
              child: Row(
                children: [
                  const Spacer(),
                  Text(
                    "Learn More",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: height * 0.027,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blue,
                      size: height * 0.04,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
