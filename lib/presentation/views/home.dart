import 'package:bloc_concept/constants/enums.dart';
import 'package:bloc_concept/logic/cubit/counter_cubit.dart';
import 'package:bloc_concept/logic/cubit/internet_cubit.dart';
import 'package:bloc_concept/presentation/views/home_second.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.WiFi) {
          context.read<CounterCubit>().increment();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.WiFi) {
          context.read<CounterCubit>().decrement();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
                  if (state is InternetConnected &&
                      state.connectionType == ConnectionType.WiFi) {
                    return Text(
                      "WIFI",
                      style: Theme.of(context).textTheme.headline3,
                    );
                  } else if (state is InternetConnected &&
                      state.connectionType == ConnectionType.WiFi) {
                    return Text(
                      "Mobile",
                      style: Theme.of(context).textTheme.headline3,
                    );
                  } else if (state is InternetDisconnected) {
                    return Text(
                      "Disconnected",
                      style: Theme.of(context).textTheme.headline3,
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              Text(
                'You have pushed the button this many times:',
              ),
              BlocConsumer<CounterCubit, CounterState>(
                listener: (context, state) {
                  if (state.wasIncremented) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Incremented"),
                      duration: Duration(milliseconds: 2),
                    ));
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Decremented"),
                        duration: Duration(milliseconds: 2)));
                  }
                },
                builder: (context, state) {
                  return Text(
                    state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
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
                    child: Icon(Icons.add),
                    heroTag: Text(widget.title),
                    tooltip: "Increment",
                    onPressed: () {
                      context.read<CounterCubit>().increment();
                    },
                  )
                ],
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return BlocProvider.value(
                      value: context.read<CounterCubit>(),
                      child: MyHomePageSecond(
                        title: "Second Page",
                      ),
                    );
                  }));
                },
                child: Text("Second Page"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
