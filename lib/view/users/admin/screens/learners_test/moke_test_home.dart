import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';
import 'package:new_project_driving/view/users/admin/screens/learners_test/choicerow_widget.dart';
import 'package:new_project_driving/view/widget/responsive/responsive.dart';

class MokeTestHome extends StatefulWidget {
  const MokeTestHome({super.key});

  @override
  State<MokeTestHome> createState() => _MokeTestHomeState();
}

class _MokeTestHomeState extends State<MokeTestHome> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: ResponsiveWebSite.isMobile(context) ? Axis.horizontal : Axis.vertical,
      child: Container(
        color: screenContainerbackgroundColor,
        height: 650,
        width: ResponsiveWebSite.isDesktop(context) ? double.infinity : 1200,
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.arrow_back_ios,
                      size: 15,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        right: 10,
                        left: 10,
                      ),
                      padding: const EdgeInsets.only(
                        right: 15,
                        left: 15,
                        top: 10,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: const Center(
                        child: Text(
                          'Question 1/3',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(
                    right: 10,
                    left: 10,
                  ),
                  padding: const EdgeInsets.only(
                    right: 15,
                    left: 15,
                    top: 10,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: const Center(
                    child: Text(
                      'Add Question',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.only(top: 20, right: 50, left: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Question',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey.withOpacity(0.2)),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Lets ask your qn',
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: Transform.scale(
                          scale: 0.65,
                          child: Switch(
                            activeColor: Colors.green,
                            value: isActive,
                            onChanged: (value) {
                              setState(() {
                                isActive = value; // Update the state when the switch is toggled
                              });
                            },
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 20,
                        ),
                        child: Text(
                          'Single answer with image',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Choice',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: [
                        ChoiceRowWidget(
                          label: 'A',
                          hintText: 'Lets ask your qn',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          letterSpacing: 0.5,
                          iconColor: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: [
                        ChoiceRowWidget(
                          label: 'B',
                          hintText: 'Lets ask your qn',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          letterSpacing: 0.5,
                          iconColor: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: [
                        ChoiceRowWidget(
                          label: 'C',
                          hintText: 'Lets ask your qn',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          letterSpacing: 0.5,
                          iconColor: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: [
                        ChoiceRowWidget(
                          label: 'D',
                          hintText: 'Lets ask your qn',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          letterSpacing: 0.5,
                          iconColor: Colors.black,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
