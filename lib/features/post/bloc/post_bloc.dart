import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PickImageEvent>(_pickImage);
  }

  final List<File> _images = [];
  Future<void> _pickImage(
    PickImageEvent event,
    Emitter emit,
  ) async {
    if (_images.length >= 3) return;

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final targetPath = '${pickedFile.path}_compressed.jpg';
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        pickedFile.path,
        targetPath,
        quality: 50,
      );

      if (compressedFile != null) {
        _images.add(File(compressedFile.path));
        emit(PostCompressedState(image: _images));
      }
    }
  }
}
