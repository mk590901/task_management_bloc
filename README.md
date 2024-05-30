# Async Task Management

Managing asynchronous task in the Flutter app, via BLoC pattern. This is an intermediate project in which a component has been created can be used in the next applications.

## Introduction

The task is divided into two parts:
1) Simulator of the task's process: instance of the __AsyncProcessSimulator__ class controlled by two commands: __start__ and __stop__. The __start__ method starts an internal timer, which completes its execution after a specified time, producing the result success or failed through two callback functions. The method __stop__ interrupts the process if necessary, removing the timer and signaling completion through the appropriate callback.

## State machine 

![async_task](https://github.com/mk590901/task_management_bloc/assets/125393245/f301926f-4bb8-491e-a053-9d601ae87dc6)

## Movie

https://github.com/mk590901/task_management_bloc/assets/125393245/4bdaaca9-8b3e-4543-9224-41f3b79dedd2


