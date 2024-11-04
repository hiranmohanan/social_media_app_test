import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/post_bloc.dart';

class PostView extends StatelessWidget {
  PostView({super.key});

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post View'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                context.read<PostBloc>().add(PickImageEvent());
              },
              child: const Text('Upload Image'),
            ),
            const SizedBox(height: 16.0),
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                if (state is PostLoadingState) {
                  return const CircularProgressIndicator();
                }
                if (state is PostCompressedState) {
                  return Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: state.image.map((image) {
                      return Image.file(
                        image,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      );
                    }).toList(),
                  );
                }

                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
