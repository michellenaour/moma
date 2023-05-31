import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:plantilla_ca/domain/entities/example.dart';
import 'package:plantilla_ca/domain/repositories/example_repository.dart';

class GetExampleUseCase
    extends UseCase<GetExampleUseCaseResponse, GetExampleUseCaseParams> {
  GetExampleUseCase(this.exampleRepository);
  final ExampleRepository exampleRepository;

  @override
  Future<Stream<GetExampleUseCaseResponse?>> buildUseCaseStream(
      GetExampleUseCaseParams? params) async {
    final controller = StreamController<GetExampleUseCaseResponse>();

    try {
      final Example example =
          await exampleRepository.getGreeting(params!.greeting);
      controller.add(GetExampleUseCaseResponse(example));
      logger.finest('GetExampleUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetExampleUseCase unsuccessful.');
      controller.addError(e);
    }

    return controller.stream;
  }
}

class GetExampleUseCaseParams {
  final String greeting;
  GetExampleUseCaseParams(this.greeting);
}

class GetExampleUseCaseResponse {
  final Example example;
  GetExampleUseCaseResponse(this.example);
}
