import 'package:flutter/material.dart';

class CountryStats extends StatefulWidget {
  String name,image;
  int? cases,recovered,deaths,active,todayRecovered;
 CountryStats({required this.name,
   required this.cases,required this.recovered,
   required this.deaths,
   required this.active,
    required this.todayRecovered,
   required this.image,
 }) ;

  @override
  _CountryStatsState createState() => _CountryStatsState();
}

class _CountryStatsState extends State<CountryStats> {
  @override
  Widget build(BuildContext context) {
    // StatsServices statsServices = StatsServices();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                         Stack(
                           alignment: Alignment.topCenter,
                           children:[ Padding(
                             padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.067),
                             child: Card(
                               child: Column(
                                children: [
                                  ReusableRow(title: 'Country', value: widget.name.toString()),
                                  ReusableRow(title: 'Total Cases', value: widget.cases.toString()),
                                  ReusableRow(title: 'Recovered', value: widget.recovered.toString()),
                                  ReusableRow(title: 'Death', value: widget.deaths.toString()),
                                  ReusableRow(title: 'Active', value: widget.active.toString()),
                                  ReusableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),

                                    ],
                                  ),
                             ),

                           ),
                           CircleAvatar(
                             backgroundImage:NetworkImage(widget.image),
                             radius: 60,
                           )
                           ]
                         ),
          ],
        ),
      )

    );
  }
}
class ReusableRow extends StatelessWidget {
  String title,value;
  ReusableRow({Key? key, required this.title ,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.only(left: 10,top: 10,right: 10,bottom: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(title),
                Text(value),
              ],
            ),
            SizedBox(height: 5,),
            Divider()

          ],
        ),
      );
  }
}

