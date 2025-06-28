abstract class LightUseCase<T>{
  Future<void> call(T t);
}