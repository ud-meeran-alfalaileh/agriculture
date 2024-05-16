import 'package:agriculture/src/config/app_text.dart';
import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/feature/farmer/all_exports/controller/all_export_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AllExportPage extends StatelessWidget {
  const AllExportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllExportsController());
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              headerText("Exports"),
              Divider(
                thickness: 2,
                color: AppTheme.lightAppColors.primary,
              ),
              FutureBuilder(
                future: controller.fetchAllExports(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      final post = snapshot.data!;

                      return Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns
                            crossAxisSpacing: 10, // Spacing between columns
                            mainAxisSpacing: 10, // Spacing between rows
                          ),
                          itemCount: post.length,
                          itemBuilder: (context, index) {
                            final name = post[index]['Name'].toString();
                            final phone = post[index]['phone'].toString();
                            final String img =
                                post[index]['imageUrl'].toString();

                            return GestureDetector(
                              onTap: () {
                                // Add your onTap functionality
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    width: 2.0,
                                    color: AppTheme.lightAppColors.primary,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 120, // Adjust as needed
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20)),
                                            image: DecorationImage(
                                              image: NetworkImage(img),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 5,
                                          right: 4,
                                          child: Container(
                                            height: 40, // Adjust as needed
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppTheme
                                                    .lightAppColors.background),
                                            child: IconButton(
                                              onPressed: () {
                                                controller
                                                    .openWhatsAppChat(phone);
                                              },
                                              icon: Icon(
                                                Icons.message,
                                                color: AppTheme
                                                    .lightAppColors.primary,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        name,
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                        )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error ${snapshot.error}'));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
