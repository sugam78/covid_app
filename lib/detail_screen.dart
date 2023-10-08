import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  dynamic data;
  DetailScreen({super.key,required this.data
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data['name']),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height *0.06,),
                      reusuableRow(title: 'Total', value: widget.data['cases'].toString()),
                      reusuableRow(title: 'Active', value: widget.data['active'].toString()),
                      reusuableRow(title: 'Deaths', value: widget.data['deaths'].toString()),
                      reusuableRow(title: 'Recovered', value: widget.data['recovered'].toString()),
                      reusuableRow(title: 'Today Cases', value: widget.data['todayCases'].toString()),
                      reusuableRow(title: 'Today Deaths', value: widget.data['todayDeaths'].toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.data['flag']),
              ),
            ],
          ),
        ],
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

