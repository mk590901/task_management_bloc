# Async Task Management

Managing asynchronous task in the Flutter app, via BLoC pattern. This is an intermediate project in which a component has been created can be used in the next applications.

## Introduction

The task is divided into two parts:
1) Simulator of the task's process: instance of the __AsyncProcessSimulator__ class controlled by two commands: __start__ and __stop__. The __start__ method starts an internal timer, which completes its execution after a specified time, producing the result success or failed through two callback functions. The method __stop__ interrupts the process if necessary, removing the timer and signaling completion through the appropriate callback.
2) Class __TaskBloc__, mapped to the state machine __TaskStateMachine__ (diagram below), that controls the above-described simulator using five events: __Run__, __Success__, __Failed__, __Cancel__ and __Reset__. 

## State machine 

![async_task](https://github.com/mk590901/task_management_bloc/assets/125393245/f301926f-4bb8-491e-a053-9d601ae87dc6)

## Async operations

- In app mplemented two simulators of the tasks: __AsyncTimerProcessSimulator__ and __AsyncFutureProcessSimulator__. The first module is a pure simulation that has no special relation to reality, the second is a slightly more valuable product of creative thought :-). This simulator is implemented as a __cancelable__ _Flutter Feature_ and can be used as a prototype or even a wrapper for a time-consuming real asynchronous operation in an application related, for example, to accessing resources via the Internet.
- Both simulators implement the __IAsyncTask__ interface with the __start__ and __stop__ functions and do not have any external visual manifestations. The difference can only be seen in the trace messages in debug mode.
The application has the ability to select and replace simulators. For these purposes, a switch on the application bar is used. By the way, this widget is from the set of widgets from the repository https://github.com/mk590901/Event-driven-BLoC-s-switch-widgets. Its use helped to quickly and easily solve a not entirely trivial problem in a stateless application.

## Brief (Briefest) app user's guide :-)

The user has four buttons at his disposal: __start__ task, __cancel__ task, __terminate__ a task with an error, and __reset__ the task to its initial state after an erroneous completion of a task. The __start__ command starts an asynchronous task with a duration of 5s, which can complete either __successfully__ or with an __error__.

## Movie

https://github.com/mk590901/task_management_bloc/assets/125393245/1d05c65a-ca9b-43d7-8ea2-4fc535892f28




