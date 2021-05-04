import 'package:flutter/material.dart';
import 'package:touchngo/screens/home.dart';
// import 'package:touchngo/screens/hotel/screens/FoodTab.dart';

class FoodList extends StatefulWidget {
  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  Widget customBox(
      var text, var price, var textColor, var backgroundColor, var img) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => DetailPage(text, price, img)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          color: Color(backgroundColor),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Container(
            height: 220,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircleAvatar(
                  radius: 38.0,
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Image(
                      image: AssetImage(img),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "$text\n$price",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color(textColor),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Colors.redAccent,
                        child: IconButton(
                            splashColor: Colors.deepPurple,
                            icon: Icon(Icons.add),
                            color: Colors.white,
                            onPressed: () {})),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 26.0),
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.arrow_left_rounded),
                    onPressed: () {
                      Navigator.of(context).pushNamed(Home.routeName);
                    }),
                Spacer(),
                CircleAvatar(
                  backgroundColor: Color(0xffFF7E68),
                  radius: 22,
                  child: IconButton(
                      icon: Icon(Icons.shopping_cart, color: Colors.white),
                      onPressed: () {}),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: Colors.grey[200],
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //     height: 52.0,
          //     child: TextFormField(
          //       decoration: InputDecoration(
          //           border: InputBorder.none,
          //           prefixIcon: Icon(Icons.search),
          //           hintText: "Search",
          //           hintStyle: TextStyle(
          //             fontSize: 18.0,
          //             color: Colors.grey,
          //           )),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 26.0,
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Recommended",
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.75,
              ),
            ),
          ),
          SizedBox(
            height: 22.0,
          ),
          Container(
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                customBox("Burger", "₹ 52", 0xffDE9B4F, 0xffFFEAC5,
                    "assets/images/burger.png"),
                customBox("Cheese", "₹ 48", 0xff698CAC, 0xffC3E3FF,
                    "assets/images/cheese.png"),
                customBox("Doughnut", "₹ 17", 0xff51CF79, 0xffD7FBD9,
                    "assets/images/doughnut.png"),
                customBox("Bufriesrger", "₹ 99", 0xffffa194, 0xffFFE4E0,
                    "assets/images/fries.png"),
              ],
            ),
          ),
          SizedBox(
            height: 22.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBar(
              controller: tabController,
              isScrollable: true,
              indicatorColor: Colors.transparent,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.0,
              ),
              tabs: <Widget>[
                Tab(child: Text("FEATURED")),
                Tab(child: Text("COMBOS")),
                // Tab(child: Text("FAVORITES")),
                // Tab(child: Text("RECOMMENDED")),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 450,
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                // Foodtab(),
                // Foodtab(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
