import 'package:covid_tracker/Services/stats_services.dart';
import 'package:covid_tracker/View/country.stats.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class CountryList extends StatefulWidget {
  const CountryList({Key? key}) : super(key: key);

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  StatsServices statsServices=StatsServices();
  TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value){
                  setState(() {

                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)
                  ),
                  hintText: 'Search with country name',
                ),
              ),
            ),
            Expanded(
                child:FutureBuilder(
                future: statsServices.getCountryListApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                  if(!snapshot.hasData){
                    return ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context,index){
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Container(height: 05, width: 50,color: Colors.white,),
                                  title: Container(height: 10, width: 89,color: Colors.white,),
                                  subtitle: Container(height: 10, width: 89,color: Colors.white,),

                                ),
                              ],
                            ),
                          );
                        });
                  }
                  else{
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context,index){
                    String name= snapshot.data![index]['country'];
                    if(searchController.text.isEmpty){ return Column(
                      children: [
                        InkWell(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryStats(
                              name:snapshot.data![index]['country'],
                              cases:snapshot.data![index]!['cases']
                              ,recovered:snapshot.data![index]!['recovered'],
                              deaths:snapshot.data![index]!['death'],
                              active:snapshot.data![index]!['active'],
                              todayRecovered:snapshot.data![index]!['todayRecovered'],
                              image: snapshot.data![index]!['countryInfo']['flag'],


                            )));
                          },
                          child: ListTile(
                            leading: Image(
                              height: 50,
                              width: 50,
                              image: NetworkImage(snapshot.data![index]['countryInfo']['flag'].toString()),
                            ),
                            title: Text(
                                snapshot.data![index]['country'].toString()
                            ),
                            subtitle: Text(
                                snapshot.data![index]['cases'].toString()
                            ),

                          ),
                        ),
                      ],
                    );}
                    else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                      return Column(
                        children: [
                          InkWell(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryStats(
                                name:snapshot.data![index]['country'],
                                cases:snapshot.data![index]!['cases']
                                ,recovered:snapshot.data![index]!['recovered'],
                                deaths:snapshot.data![index]!['death'],
                                active:snapshot.data![index]!['active'],
                                todayRecovered:snapshot.data![index]!['todayRecovered'],
                                image: snapshot.data![index]['countryInfo']['flag'],
                              )));
                            },
                            child: ListTile(
                              leading: Image(
                                height: 50,
                                width: 50,
                                image: NetworkImage(snapshot.data![index]['countryInfo']['flag'].toString()),
                              ),
                              title: Text(
                                  snapshot.data![index]['country'].toString()
                              ),
                              subtitle: Text(
                                  snapshot.data![index]['cases'].toString()
                              ),

                            ),
                          ),
                        ],
                      );
                    }
                    else{
                      return Container();
                    }

              });}
            }))

          ],
        ),
      ) ,
    );
  }
}
