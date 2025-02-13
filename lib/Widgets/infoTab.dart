import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class infoTab extends StatelessWidget {
  const infoTab({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        // border: Border.symmetric(
        //     vertical: BorderSide(width: 1),
        //     horizontal: BorderSide(width: 1))
      ),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                  flex: 4,
                  fit: FlexFit.loose,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "sasuke Uchiha (122)",
                        style: TextStyle(
                            fontFamily: "H1",
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "Ui Dev",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_business_outlined),
                          Text("Sample Location")
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.gps_fixed_rounded),
                            Text("GPS Tracker")
                          ],
                        ),
                      ),
                    ],
                  )),
              Flexible(
                  flex: 3,
                  fit: FlexFit.loose,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      color: Colors.green,
                    ),
                    height: 160,
                    width: 160,
                    child: Center(),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Text("Present"),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Text("Absent"),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  Text("Leave")
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
