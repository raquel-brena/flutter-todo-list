import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:mini_projeto_02/TodoApp.dart';
import 'package:mini_projeto_02/model/TaskDetailsArgs.dart';
import 'package:mini_projeto_02/screens/TaskDetail.dart';

final GoRouter routes = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const TodoApp();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            final args = state.extra as TaskDetailArgs;
            final tarefa = args.tarefa;
            final excluirTask = args.excluirTask;
            final editTarefa = args.editTarefa;

            return TaskDetail(
              tarefa: tarefa,
              excluirTask: excluirTask,
              editTarefa: editTarefa,
            );
          },
        ),
      ],
    ),
  ],
);
