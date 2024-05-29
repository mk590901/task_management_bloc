import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocks/task_bloc.dart';
import 'events/task_events.dart';
import 'states/task_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => TaskBloc(TaskState(TaskStates.idle)),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
              return const Text('IDLE...');
            } else if (state.state() == TaskStates.active) {
              return const CircularProgressIndicator();
            } else if (state.state() == TaskStates.error) {
              return const Text('ERROR...');
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
              taskBloc.add(Run(taskBloc));
            },
            tooltip: 'Fetch Data',
            child: const Icon(Icons.download),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              taskBloc.add(Cancel());
            },
            tooltip: 'Cancel',
            child: const Icon(Icons.cancel),
          ),

          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              taskBloc.add(Failed());
            },
            tooltip: 'Failed',
            child: const Icon(Icons.error_outline_sharp),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              taskBloc.add(Reset());
            },
            tooltip: 'Refresh',
            child: const Icon(Icons.refresh_sharp),
          ),
        ],
      ),
    );
  }
}
