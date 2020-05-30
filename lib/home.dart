import 'package:exom/posts/filterPage.dart';
import 'package:exom/posts/postPage.dart';
import 'package:exom/schedules/schedulePage.dart';
import 'package:exom/space/spaceFacts.dart';
import 'package:exom/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var drawerPage = 0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var bottomBarPage = 0;
  GlobalKey<ScaffoldState> scaff = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaff,
      drawer: DrawerWidget(
        update: () {
          setState(() {});
          scaff.currentState.openEndDrawer();
        },
      ),
      appBar: AppBar(
        centerTitle: false,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.teal, 
        ),
        title: Text(
          drawerPage == 0
              ? (bottomBarPage == 0 ? 'Recent Posts' : 'Formed Schedules')
              : 'Space Facts',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          drawerPage == 0 && bottomBarPage == 0
              ? IconButton(
                  icon: Icon(
                    Icons.filter_list,
                    size: 25,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) => FilterPage(),
                    ));
                  },
                )
              : SizedBox.shrink(),
        ],
      ),
      body: drawerPage == 0
          ? (bottomBarPage == 0 ? PostPage() : SchedulePage())
          : SpaceFacts(),
      bottomNavigationBar: drawerPage == 0
          ? BottomNavigationBar(
              currentIndex: bottomBarPage,
              onTap: (val) {
                bottomBarPage = val;
                setState(() {});
              },
              items: List.generate(2, (index) {
                return BottomNavigationBarItem(
                    icon: Icon(index == 0 ? Icons.home : Icons.assignment),
                    title: Text(index == 0 ? 'Posts' : 'Schedules'));
              }))
          : null,
    );
  }
}

class DrawerWidget extends StatelessWidget {
  final update;

  const DrawerWidget({Key key, this.update}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              UserBox(),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                      children: List.generate(2, (index) {
                    return GestureDetector(
                      onTap: () {
                        drawerPage = index;
                        update();
                      },
                      child: Container(
                        color: drawerPage == index
                            ? Colors.teal
                            : Colors.transparent,
                        height: 50,
                        width: double.maxFinite,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(index == 0 ? 'Home Page' : 'Space Facts',
                                  style: TextStyle(
                                    fontSize: 20,color: drawerPage == index?Colors.white:Colors.black
                                  )),
                              Icon(index == 0 ? Icons.home : Icons.book,
                                  size: 25, color: drawerPage == index?Colors.white:Colors.black,),
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

