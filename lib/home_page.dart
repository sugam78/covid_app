import 'package:covid_app/Model/WorldStatesModel.dart';
import 'package:covid_app/Services/states_services.dart';
import 'package:covid_app/routing/route_name.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  late final AnimationController controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync:this)..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
  }
  final colorList =<Color> [
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Covid app'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            FutureBuilder(
                future: statesServices.getData(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot){
              if(!snapshot.hasData){
                return Expanded(child: SpinKitFadingCircle(
                  color: Colors.white,
                  controller: controller,
                ));
              }
              else{
                return Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height *0.01,),
                    PieChart(
                      dataMap: {
                        'Total' : double.parse(snapshot.data!.cases!.toString()),
                        'Recovered': double.parse(snapshot.data!.recovered.toString()),
                        'death': double.parse(snapshot.data!.deaths.toString()),
                      },
                      chartValuesOptions:const ChartValuesOptions(
                        showChartValuesInPercentage: true
                      ),
                      animationDuration: const Duration(seconds: 2),
                      chartType: ChartType.ring,
                      colorList: colorList,
                      legendOptions: const LegendOptions(
                        legendPosition: LegendPosition.left,
                      ),
                      ringStrokeWidth: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Card(
                        child: Column(
                          children: [
                            reusuableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                            reusuableRow(title: 'Active', value: snapshot.data!.active.toString()),
                            reusuableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                            reusuableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                            reusuableRow(title: 'Today Cases', value: snapshot.data!.todayCases.toString()),
                            reusuableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, RouteName.countrylist);
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xff1aa260)
                        ),
                        child: const Center(
                          child: Text('Track Countries'),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
class reusuableRow extends StatelessWidget {
 final String title,value;
  const reusuableRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0,left: 10,right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
        ),
        const SizedBox(height: 5,),
        const Divider(),
      ],
    );
  }
}


