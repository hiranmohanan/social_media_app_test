import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app/constants/constants.dart';
import 'package:social_media_app/service/api_services.dart';

import '../../auth/bloc/auth_bloc.dart';
import '../bloc/home_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home View'),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false)
                  .then((value) {
                context.read<AuthBloc>().add(AuthLogout());
              });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            context.read<HomeBloc>().add(HomeScreenApiCallEvent());
          },
          child: ListView(
            children: [
              Text(
                'Quotes of the day',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoadingState) {
                    return const CircularProgressIndicator();
                  } else if (state is HomeSuccessState) {
                    return SizedBox(
                      height: 10.h,
                      width: 100.w,
                      child: CarouselView(
                        itemExtent: 100.w,
                        itemSnapping: true,
                        children: state.quotes.quotes!.map((quote) {
                          return Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(quote.quote.toString()));
                        }).toList(),
                      ),
                    );
                  }
                  return const Text('No images found');
                },
              ),
              vSizedBox1,
              SizedBox(
                height: 100.h,
                width: 100.w,
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ]),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60,
                              width: 90.w,
                              child: const ListTile(
                                title: Text('Title'),
                                subtitle: Text('Subtitle'),
                                leading: Icon(Icons.title),
                              ),
                            ),
                            const Divider(),
                            SizedBox(
                              height: 30.h,
                              width: 100.w,
                              child: CarouselView(itemExtent: 100.w, children: [
                                Image.network(
                                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                                  fit: BoxFit.contain,
                                ),
                                Image.network(
                                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                                  fit: BoxFit.contain,
                                ),
                                Image.network(
                                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-3.jpg',
                                  fit: BoxFit.contain,
                                ),
                              ]),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/post');
        },
        child: const Icon(Icons.add_a_photo_outlined),
      ),
    );
  }
}
