part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoadingState extends PostState {}

class PostCompressedState extends PostState {
  final List<File> image;

  PostCompressedState({
    required this.image,
  });
}
