import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'async_process_simulator.dart';
import 'blocs/task_bloc.dart';
import 'blocs/task_state.dart';
import 'blocs/task_events.dart';

void main() {
  runApp(const AsyncOperationDemoApp());
}

class AsyncOperationDemoApp extends StatelessWidget {
  const AsyncOperationDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => TaskBloc(TaskState(TaskStates.idle)),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final simulator = AsyncProcessSimulator(const Duration(seconds: 5));

  @override
  Widget build(BuildContext context) {
    final taskBloc = BlocProvider.of<TaskBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Async Operation with BLoC'),
      ),
      body: Center(
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state.state() == TaskStates.idle) {
              return const Text('Press run button to start task',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.lightBlue, fontSize: 18),);
            } else if (state.state() == TaskStates.active) {
              return const CircularProgressIndicator();
            } else if (state.state() == TaskStates.error) {
              return const Text('Task is failed. Press reset button\nto back initial state',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.redAccent, fontSize: 18),
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              taskBloc.add(Run(() {
                simulator.start(() {
                  taskBloc.add(Success());
                }, () {
                  taskBloc.add(Failed());
                });
              }));
            },
            tooltip: 'Start process',
            child: const Icon(Icons.run_circle_outlined, size: 32, color: Colors.lightBlue),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              simulator.stop(() {
                taskBloc.add(Cancel());
              });
            },
            tooltip: 'Cancel',
            child: const Icon(Icons.cancel_outlined, size: 32, color: Colors.lightBlue),
          ),

          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              simulator.stop(() {
                taskBloc.add(Failed());
              });
            },
            tooltip: 'Failed',
            child: const Icon(Icons.error_outline_sharp, size: 32, color: Colors.lightBlue),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              taskBloc.add(Reset());
            },
            tooltip: 'Reset',
            child: const Icon(Icons.refresh_sharp, size: 32, color: Colors.lightBlue),
           ),
        ],
      ),
    );
  }
}
