import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:MOMO/app/pages/example/example_controller.dart';
import 'package:MOMO/data/repositories/mock/data_mock_example_repository.dart';

class ExamplePage extends clean_architecture.View {
  ExamplePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExamplePageState();
}

class _ExamplePageState
    extends clean_architecture.ViewState<ExamplePage, ExampleController> {
  _ExamplePageState()
      : super(ExampleController(
            DataMockExampleRepository())); //Agregar controller
  @override
  Widget get view {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(title: Text('Hola Clean architecture')),
      body: clean_architecture.ControlledWidgetBuilder<ExampleController>(
        builder: (context, controller) {
          return Center(
            child: Text(controller.example!.greeting ?? ''),
          );
        },
      ),
    );
  }
}
