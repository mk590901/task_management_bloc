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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
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
        title: Text('Async Operation with BLoC', style: buildTitleTextStyle()),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state.state() == TaskStates.idle) {
              return Text(
                'Press run button to start task',
                textAlign: TextAlign.center,
                style: buildTextStyle(),
              );
            } else if (state.state() == TaskStates.active) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  const SizedBox(
                    width: 256.0,
                    height: 256.0,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey,
                      strokeWidth: 16,
                    ),
                  ),
                  Text(
                    'Task in progress...\nPlease wait',
                    textAlign: TextAlign.center,
                    style: buildTextStyle(),
                  ),
                ],
              );
            } else if (state.state() == TaskStates.error) {
              return Text(
                'Task is failed. Press reset button\nto back initial state',
                textAlign: TextAlign.center,
                style: buildWarningTextStyle(),
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: isButtonInverseEnabled(state.state())
                    ? () {
                        taskBloc.add(Run(() {
                          simulator.start(() {
                            taskBloc.add(Success());
                          }, () {
                            taskBloc.add(Failed());
                          });
                        }));
                      }
                    : null,
                tooltip: 'Start process',
                backgroundColor:
                    buttonInverseBackgroundColor(state.state(), context),
                child: Icon(Icons.run_circle_outlined,
                    size: 32, color: iconInverseColor(state.state())),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                onPressed: isButtonInverseEnabled(state.state())
                    ? () {
                        simulator.stop(() {
                          taskBloc.add(Cancel());
                        });
                      }
                    : null,
                tooltip: 'Cancel',
                backgroundColor:
                    buttonInverseBackgroundColor(state.state(), context),
                child: Icon(Icons.cancel_outlined,
                    size: 32, color: iconInverseColor(state.state())),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                onPressed: isButtonInverseEnabled(state.state())
                    ? () {
                        simulator.stop(() {
                          taskBloc.add(Failed());
                        });
                      }
                    : null,
                tooltip: 'Failed',
                backgroundColor:
                    buttonInverseBackgroundColor(state.state(), context),
                child: Icon(Icons.error_outline_sharp,
                    size: 32, color: iconInverseColor(state.state())),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                onPressed: isButtonEnabled(state.state())
                    ? () {
                        taskBloc.add(Reset());
                      }
                    : null,
                tooltip: 'Reset',
                backgroundColor: buttonBackgroundColor(state.state(), context),
                child: Icon(Icons.refresh_sharp,
                    size: 32, color: iconColor(state.state())),
              ),
            ],
          );
        },
      ),
    );
  }

  TextStyle buildTitleTextStyle() {
    return const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontStyle: FontStyle.italic,
      shadows: [
        Shadow(
          blurRadius: 8.0,
          color: Colors.indigo,
          offset: Offset(3.0, 3.0),
        ),
      ],
    );
  }

  TextStyle buildTextStyle() {
    return const TextStyle(
      color: Colors.lightBlue,
      fontSize: 18,
      fontStyle: FontStyle.normal,
      shadows: [
        Shadow(
          blurRadius: 4.0,
          color: Colors.black12,
          offset: Offset(2.0, 2.0),
        ),
      ],
    );
  }

  TextStyle buildWarningTextStyle() {
    return const TextStyle(
      color: Colors.red,
      fontSize: 18,
      fontStyle: FontStyle.normal,
      shadows: [
        Shadow(
          blurRadius: 4.0,
          color: Colors.black12,
          offset: Offset(2.0, 2.0),
        ),
      ],
    );
  }

  Color? buttonBackgroundColor(TaskStates state, BuildContext context) =>
      (state == TaskStates.error)
          ? Theme.of(context).primaryColor
          : Colors.grey[200];

  Color? buttonInverseBackgroundColor(TaskStates state, BuildContext context) =>
      (state == TaskStates.error)
          ? Colors.grey[200]
          : Theme.of(context).primaryColor;

  Color? iconColor(TaskStates state) =>
      (state == TaskStates.error) ? Colors.white70 : Colors.grey;

  Color? iconInverseColor(TaskStates state) =>
      (state == TaskStates.error) ? Colors.grey : Colors.white70;

  bool isButtonEnabled(TaskStates state) =>
      (state == TaskStates.error) ? true : false;

  bool isButtonInverseEnabled(TaskStates state) =>
      (state == TaskStates.error) ? false : true;
}
