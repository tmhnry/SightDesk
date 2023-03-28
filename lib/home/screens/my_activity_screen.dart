import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../entities/user.dart';

class MyActivityScreen extends StatefulWidget {
  @override
  _MyActivityScreenState createState() => _MyActivityScreenState();
}

class _MyActivityScreenState extends State<MyActivityScreen>
    with SingleTickerProviderStateMixin {
  int _selectedCategoryIndex = 0;
  late TabController _tabController;
  bool isLoading = false;

  @override
  void initState() {
    refresh();
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  final DateFormat _dateFormatter = DateFormat('dd MMM');
  final DateFormat _timeFormatter = DateFormat('h:mm');

  Future<void> refresh() async {
    setState(() => isLoading = true);
    Future.delayed(
      const Duration(seconds: 1),
      () => setState(
        () => isLoading = false,
      ),
    );
  }

  Widget _buildCategoryCard(int index, String title, int count) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        height: 240.0,
        width: 175.0,
        decoration: BoxDecoration(
          color: _selectedCategoryIndex == index
              ? Color(0xff392850)
              : Color(0xFFF5F7FB),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            _selectedCategoryIndex == index
                ? BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 10.0)
                : BoxShadow(color: Colors.transparent),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                title,
                style: TextStyle(
                  color: _selectedCategoryIndex == index
                      ? Colors.white
                      : Color(0xFFAFB4C6),
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                count.toString(),
                style: TextStyle(
                  color: _selectedCategoryIndex == index
                      ? Colors.white
                      : Colors.black,
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : CustomScrollView(
            physics: ClampingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                leading: IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: Image.asset(
                    'assets/icons/drawer_00.png',
                    width: 24,
                    height: 24,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      // Map<CID, String> map = {};
                      // for (int i = 0; i < 100; i++) {
                      //   CID cid = CID(
                      //     cidLength: map.isEmpty ? 5 : null,
                      //     cidStrings: cFuncGetCIDStrings(map),
                      //   );
                      //   map.addEntries({MapEntry(cid, '')});
                      // }
                      // map.keys.forEach((cid) {
                      //   print(cid.cidString);
                      // });
                      refresh();
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                // title: Text(
                //   'Title',
                //   style: Theme.of(context).appBarTheme.titleTextStyle,
                // ),
                floating: true,
              ),
              SliverToBoxAdapter(
                child: Text(
                  '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    // Padding(
                    //   padding: EdgeInsets.all(30),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         'Chapter 10 Means of Egress',
                    //         style: TextStyle(
                    //           fontSize: 25,
                    //         ),
                    //       ),
                    //       Container(
                    //         margin: EdgeInsets.only(top: 20, bottom: 20),
                    //         child: Text(
                    //           '1012.1 Where required.',
                    //           style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 20,
                    //           ),
                    //         ),
                    //       ),
                    //       Text(
                    //         LoremIpsum.text,
                    //         textAlign: TextAlign.justify,
                    //         style: TextStyle(fontSize: 18),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: [
                          Text(
                            'Welcome ' + User.getInfo(firstName),
                            style: TextStyle(fontSize: 35),
                          ),
                          Icon(Icons.settings, size: 150),
                          Text('Look what you have done recently: ')
                        ],
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/icons/drawer_00.png'),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          SizedBox(width: 20.0),
                          Text(
                            User.getInfo(firstName) +
                                ' ' +
                                User.getInfo(lastName),
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      height: 280.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return SizedBox(width: 20.0);
                          }
                          return _buildCategoryCard(
                            index - 1,
                            categories.keys.toList()[index - 1],
                            categories.values.toList()[index - 1],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: TabBar(
                        controller: _tabController,
                        labelColor: Colors.black,
                        unselectedLabelColor: Color(0xFFAFB4C6),
                        indicatorColor: Color(0xff392850),
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 4.0,
                        isScrollable: true,
                        tabs: <Widget>[
                          Tab(
                            child: Text(
                              'Notes',
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'To Do',
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Performed',
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30.0),
                      padding: EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F7FB),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                notes[0].title,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                _timeFormatter.format(notes[0].date),
                                style: TextStyle(
                                  color: Color(0xFFAFB4C6),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            notes[0].content,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                _dateFormatter.format(notes[0].date),
                                style: TextStyle(
                                  color: Color(0xFFAFB4C6),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                height: 50.0,
                                width: 50.0,
                                decoration: BoxDecoration(
                                  color: Color(0xff392850),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30.0),
                      padding: EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F7FB),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                notes[1].title,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                _timeFormatter.format(notes[1].date),
                                style: TextStyle(
                                  color: Color(0xFFAFB4C6),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            notes[1].content,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                _dateFormatter.format(notes[1].date),
                                style: TextStyle(
                                  color: Color(0xFFAFB4C6),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                height: 50.0,
                                width: 50.0,
                                decoration: BoxDecoration(
                                  color: Color(0xff392850),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}

class Note {
  String title;
  String content;
  DateTime date = DateTime.now();

  Note(
    this.date, {
    this.title = '',
    this.content = '',
  });
}

final Map<String, int> categories = {
  'Notes': 02,
  'Work': 0,
  'Home': 0,
  'Complete': 0,
};

final List<Note> notes = [
  Note(
    DateTime(2030, 02, 14, 8, 30),
    title: 'Bomb University of Cebu',
    content: 'Bomb University of Cebu Main Mechanical Engineering',
  ),
  Note(
    DateTime(2030, 02, 20, 10, 30),
    title: 'Go to Jail',
    content: 'Go to jail with friends and buddies.',
  ),
];

class NewClass {
  String title;
  String pass;
  NewClass(this.title, this.pass);
}
