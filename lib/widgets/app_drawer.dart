import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Appdrawer extends StatelessWidget {
  const Appdrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: HexColor("E1EAFF"),
        padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.23,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      color: HexColor("5685FF"),
                      size: 30,
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[400],
                          // image: DecorationImage(
                          //   fit: BoxFit.cover,
                          //   image: AssetImage("assets/images/profile.png",),
                          // ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Admin Name",
                            style:
                                TextStyle(fontSize: 18, fontFamily: 'Nunito'),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "+91 9999999999",
                            style:
                                TextStyle(fontSize: 15, fontFamily: 'Nunito'),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 15),
                child: Row(
                  children: [
                    Icon(Icons.person),
                    Text(
                      '  My Profile',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Nunito',
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) => About()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 15),
                child: Row(
                  children: [
                    Icon(Icons.beenhere_outlined),
                    Text(
                      '  About',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Nunito',
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) => ContactUs()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 15),
                child: Row(
                  children: [
                    Icon(Icons.live_help_outlined),
                    Text(
                      '  Contact Us',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Nunito',
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              // onTap: share,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 15),
                child: Row(
                  children: [
                    Icon(Icons.share),
                    Text(
                      '  Share',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Nunito',
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // FirebaseAuth.instance.signOut();
                // Navigator.of(context).pop();
                // Navigator.of(context).pushReplacementNamed("/");
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 15),
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    Text(
                      '  Log Out',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Nunito',
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
