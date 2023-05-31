import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:plantilla_ca/domain/repositories/example_repository.dart';
import 'package:plantilla_ca/domain/usecases/get_example_use_case.dart';

class ExamplePresenter extends Presenter {
  Function? getGreetingOnNext;
  Function? getGreetingOnError;
  Function? getGreetingOnComplete;

  GetExampleUseCase _getExampleUseCase;

  ExamplePresenter(ExampleRepository exampleRepository)
      : _getExampleUseCase = GetExampleUseCase(exampleRepository);

  @override
  void dispose() {
    _getExampleUseCase.dispose();
  }

  void getGreeting(String greeting) {
    //llamar al observer
    _getExampleUseCase.execute(
        _GetExampleUseCaseObserver(this), GetExampleUseCaseParams(greeting));
  }
}

class _GetExampleUseCaseObserver
    implements Observer<GetExampleUseCaseResponse> {
  final ExamplePresenter presenter;
  _GetExampleUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    assert(presenter.getGreetingOnComplete != null);
    presenter.getGreetingOnComplete!();
  }

  @override
  void onError(e) {
    assert(presenter.getGreetingOnComplete != null);
    presenter.getGreetingOnError!(e);
  }

  @override
  void onNext(GetExampleUseCaseResponse? response) {
    assert(presenter.getGreetingOnComplete != null);
    presenter.getGreetingOnNext!(response);
  }
}
