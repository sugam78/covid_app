import 'package:covid_app/Services/states_services.dart';
import 'package:covid_app/routing/route_name.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountiresList extends StatefulWidget {
  const CountiresList({super.key});

  @override
  State<CountiresList> createState() => _CountiresListState();
}

class _CountiresListState extends State<CountiresList> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: search,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Search Countries',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 1, color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 1, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder(
                  future: statesServices.getCountriesData(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.white,
                                    ),
                                    title: Container(
                                      height: 10,
                                      width: 90,
                                      color: Colors.white,
                                    ),
                                    subtitle: Container(
                                      height: 10,
                                      width: 90,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              highlightColor: Colors.grey.shade100,
                              baseColor: Colors.grey.shade700,
                            );
                          });
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data![index]['country'];
                            if (search.text.isEmpty) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RouteName.detailsCountry,
                                          arguments: {
                                            'name': snapshot.data![index]
                                                ['country'],
                                            'cases' : snapshot.data![index]['cases'],
                                            'active' : snapshot.data![index]['active'],
                                            'deaths' : snapshot.data![index]['deaths'],
                                            'recovered' : snapshot.data![index]['recovered'],
                                            'todayCases' : snapshot.data![index]['todayCases'],
                                            'todayDeaths' : snapshot.data![index]['todayDeaths'],
                                            'flag' : snapshot.data![index]['countryInfo']
                                            ['flag'],
                                          });
                                    },
                                    child: ListTile(
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag']),
                                      ),
                                      title: Text(
                                          snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                    ),
                                  ),
                                ],
                              );
                            } else if (name.toLowerCase().contains(
                                search.text.toString().toLowerCase())) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RouteName.detailsCountry);
                                    },
                                    child: ListTile(
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag']),
                                      ),
                                      title: Text(
                                          snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
