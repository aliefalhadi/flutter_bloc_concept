import 'package:bloc_concept/logic/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePageSecond extends StatefulWidget {
  MyHomePageSecond({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageSecondState createState() => _MyHomePageSecondState();
}

class _MyHomePageSecondState extends State<MyHomePageSecond> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state){
                if(state.wasIncremented){
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text("Incremented"),duration: Duration(milliseconds: 2),));
                }else{
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text("Decremented"), duration: Duration(milliseconds: 2)));
                }
              },
              builder: (context, state) {
                return Text(
                  state.counterValue.toString(),
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline4,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  child: Icon(Icons.remove),
                  heroTag: Text(widget.title),
                  tooltip: "Decrement",
                  onPressed: () {
                    context.read<CounterCubit>().decrement();
                  },
                ),
                FloatingActionButton(
                  heroTag: Text(widget.title),
                  child: Icon(Icons.add),
                  tooltip: "Increment",
                  onPressed: () {
                    context.read<CounterCubit>().increment();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}