import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:local_notification_flutter_project/test/bloc/test_bloc.dart';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/repo/Test_repository.dart';

class Test extends StatefulWidget {
  const Test({
    key,
  });
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final TestApi testApi = Get.put(TestApi());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider<TestBloc>(
        create: (context) {
          final bloc = TestBloc(testRepository: testRepository);
          bloc.add(TestStarted());
          return bloc;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<TestBloc, TestState>(
              builder: (context, state) {
                if (state is TestSuccess) {
                  return Column(
                    children: [
                      Container(
                        width: size.width,
                        height: size.height,
                        child: ListView.builder(
                          itemCount: state.test.length,
                          itemBuilder: (context, index) {
                            final data = state.test[index];
                            return Container(
                              child: Column(
                                children: [
                                  Text(data.usr_firstname),
                                  Text(data.usr_lastname),
                                  Text(data.usr_username),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else if (state is TestLoading) {
                  return Container(
                    width: size.width,
                  );
                } else if (state is TestError) {
                  return Text(state.exception.message);
                } else {
                  throw Exception('error');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
