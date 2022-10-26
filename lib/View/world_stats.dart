import 'package:covid_tracker/Services/stats_services.dart';
import 'package:covid_tracker/View/country_list.dart';
import 'package:covid_tracker/model/WorldStatesModel.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen> with TickerProviderStateMixin {
  late final AnimationController _animationController=AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this).. repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    StatsServices statsServices=StatsServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.1,),
              FutureBuilder(
                  future: statsServices.getWorldStats(),
                  builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){
                    if(!snapshot.hasData){
                      return Expanded(
                         flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: _animationController,
                        ),
                      );
                    }
                    else{
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total":double.parse(snapshot.data!.cases.toString()),
                              "Recovered":double.parse(snapshot.data!.recovered.toString()),
                              "Death":double.parse(snapshot.data!.deaths.toString()),
                            }
                            ,
                            chartRadius: MediaQuery.of(context).size.width/3.2,
                            legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                            animationDuration: Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical:50 ),
                            child: Card(child: Column(
                              children: [
                                ReusableRow(title: 'Total Cases', value: snapshot.data!.cases.toString()),
                                ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                ReusableRow(title: 'Death', value: snapshot.data!.deaths.toString()),
                                ReusableRow(title: 'Active', value: snapshot.data!.active.toString()),
                                ReusableRow(title: 'Today Cases', value: snapshot.data!.todayCases.toString()),
                                ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                                ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),


                              ],
                            ),),
                          ),
                          GestureDetector(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryList()));
                            },
                            child: Container(
                              height: 50,
                              // width: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.cyan
                              ),
                              child: Center(child: Text("Track Countries")),
                            ),
                          )

                        ],
                      );
                    }

              }),
            ],
          ),
        ),
      ),
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
