import 'dart:math';
import 'package:flutter/material.dart';

class HomeDrawer extends StatefulWidget {
  final List<String> homeDrawerCategories;
  final String selectedHomeDrawerCategory;
  final void Function(String selectedHomeDrawerCategory)
      selectHomeDrawerCategory;
  const HomeDrawer({
    required this.selectedHomeDrawerCategory,
    required this.homeDrawerCategories,
    required this.selectHomeDrawerCategory,
  });

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromRGBO(54, 209, 220, 1),
                          Color.fromRGBO(91, 134, 229, 1),
                        ],
                      ),
                    ),
                  ),
                  // Image.asset('assets/images/home_drawer_background.jpg'),
                  Image.asset(
                    'assets/icons/user_profile.png',
                    height: 150,
                  ),
                ],
              ),
              Container(
                // color: Theme.of(context).colorScheme.background,
                color: Color.fromRGBO(0, 0, 0, 0.01),
                child: Column(
                  children: [
                    // Column inside a ListView , can this be problematic?
                    Container(
                      margin: EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 0.2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                      ),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          fontFamily: 'Raleway',
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search here',
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                          ),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 20,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: buildListTiles(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  List<Widget> buildListTiles(BuildContext context) =>
      widget.homeDrawerCategories
          .map(
            (homeDrawerCategory) => GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                setState(
                  () => widget.selectHomeDrawerCategory(homeDrawerCategory),
                );
              },
              child: Container(
                padding: EdgeInsets.only(
                  top: 15,
                  bottom: 15,
                  left: 15,
                ),
                child: Row(
                  children: [
                    buildHomeDrawerIcon(
                      homeDrawerCategory,
                      homeDrawerCategory == widget.selectedHomeDrawerCategory,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 20,
                      ),
                      child: Text(
                        homeDrawerCategory,
                        style: TextStyle(
                          color: homeDrawerCategory ==
                                  widget.selectedHomeDrawerCategory
                              ? Theme.of(context).colorScheme.background
                              : Color.fromRGBO(0, 0, 0, 0.5),
                          fontFamily: 'Raleway',
                          fontSize: homeDrawerCategory ==
                                  widget.selectedHomeDrawerCategory
                              ? 18
                              : 18,
                          fontWeight: homeDrawerCategory ==
                                  widget.selectedHomeDrawerCategory
                              ? FontWeight.w500
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  // border: Border(
                  //   bottom: BorderSide(
                  //     color: Theme.of(context).colorScheme.primary,
                  //     width: 0.3,
                  //   ),
                  // ),
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(
                      10,
                    ),
                  ),
                  color: homeDrawerCategory == widget.selectedHomeDrawerCategory
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                // child: ListTile(
                //   dense: true,
                //   // shape: RoundedRectangleBorder(
                //   //   borderRadius: BorderRadius.circular(5),
                //   //   side: BorderSide(
                //   //     width: 1,
                //   //     color: homeDrawerCategory == widget.selectedHomeDrawerCategory
                //   //         ? Theme.of(context).colorScheme.primary
                //   //         : Colors.white,
                //   //   ),
                //   // ),
                //   shape: Border(
                //     bottom: BorderSide(color: Colors.white, width: 20),
                //   ),
                //   selected: homeDrawerCategory == widget.selectedHomeDrawerCategory,
                //   selectedTileColor: Theme.of(context).colorScheme.secondary,
                //   onTap: () {
                //     setState(
                //       () => widget.selectHomeDrawerCategory(homeDrawerCategory),
                //     );
                //     Navigator.of(context).pop();
                //   },
                // leading: buildHomeDrawerIcon(
                //   homeDrawerCategory,
                //   homeDrawerCategory == widget.selectedHomeDrawerCategory,
                // ),
                // title: Text(
                //   homeDrawerCategory,
                //   style: TextStyle(
                //     color: homeDrawerCategory == widget.selectedHomeDrawerCategory
                //         ? Theme.of(context).colorScheme.secondary
                //         : Theme.of(context).colorScheme.background,
                //     fontFamily: 'Raleway',
                //     fontSize:
                //         homeDrawerCategory == widget.selectedHomeDrawerCategory
                //             ? 18
                //             : 16,
                //     fontWeight:
                //         homeDrawerCategory == widget.selectedHomeDrawerCategory
                //             ? FontWeight.w500
                //             : FontWeight.w300,
                //   ),
                // ),
                // ),
              ),
            ),
          )
          .toList();

  Color get randomColor {
    Random rand = Random();
    double opacity = rand.nextDouble();
    if (opacity < 0.75) opacity += 0.75;
    return Color.fromRGBO(
      rand.nextInt(256),
      rand.nextInt(256),
      rand.nextInt(256),
      opacity,
    );
  }

  Map<String, IconData> homeDrawerIconData = {
    'My Activity': Icons.bolt_outlined,
    'Daily Evaluation': Icons.assessment_outlined,
    'Coursework': Icons.local_library_outlined,
    'Mock Board Exam': Icons.quiz_outlined,
    'Problem Sets': Icons.history_edu_outlined,
    'Notes and Reviewers': Icons.auto_stories_outlined,
  };

  // Widget buildImageAsset(String imagePath, bool selected) => Image.asset(
  //       imagePath,
  //       color:
  //           selected ? CustomColors.colorfulOrange : CustomColors.colorfulWhite,
  //       width: 30,
  //       height: 30,
  //     );

  Widget buildIcon(IconData iconData, bool selected) => Icon(
        iconData,
        color: randomColor,
      );

  Widget buildHomeDrawerIcon(String homeDrawerCategory, bool selected) {
    final IconData? iconData = homeDrawerIconData[homeDrawerCategory];
    if (iconData != null) return buildIcon(iconData, selected);
    throw Exception('buildHomeDrawerIcon: imagePath evaluated to null');
  }
}
