abstract class UseCase<T,B>{
  Future<T> call(B b);
}