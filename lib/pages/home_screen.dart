import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:coba/pages/data.dart';
import 'package:coba/pages/profile_screen.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    FirstScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 157, 255),
        automaticallyImplyLeading: false, // Removes the back button
        title: Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center aligns the title
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Image.asset(
                'assets/logo.png', // Replace with your logo asset path
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              'DELAIN', // Your app title
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold, // Use Roboto Bold
                fontFamily: 'Roboto', // Specify the font family
              ),
            ),
          ],
        ),
      ),
      body: _selectedIndex == 0
          ? Stack(
              children: [
                // Main Content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // CarouselSlider
                      CarouselSlider(
                        items: [
                          // Add your images here
                          Image.asset("assets/1.jpeg"),
                          Image.asset("assets/2.jpeg"),
                          Image.asset('assets/3.jpeg'),
                        ],
                        options: CarouselOptions(
                          height: 200,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            // Callback when the carousel changes image
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'SELAMAT DATANG',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(137, 244, 232, 232),
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 2,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Taatilah peraturan lalu lintas untuk menjaga keselamatan diri dan orang lain di jalan.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(166, 25, 25, 25),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        color: Theme.of(context).primaryColor,
                        margin: EdgeInsets.all(20),
                        height: 50,
                        width: w,
                        child: MaterialButton(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => YoloVideo(),
                              ),
                            );
                          },
                          child: Text('Start Detecting'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 59, 157, 255),
        unselectedItemColor:
            Colors.grey, // Set the color of the unselected icons to grey
        onTap: _onItemTapped,
      ),
    );
  }
}
