import 'package:apple/restaurant/component/restaurant_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RestaurantScreen extends StatelessWidget {
  RestaurantScreen({super.key});

  final dio = Dio();
  final storage = FlutterSecureStorage();

  Future<List> paginateRestaurant() async {
    try {
      final response = await dio.get(
        'http://127.0.0.1:3000/restaurant',
        options: Options(
          headers: {
            'authorization':
                'Bearer $accessToken'
          },
        ),
      );
      return response.data['data'];
    } on DioException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder<List>(
          future: paginateRestaurant(),
          builder: (context, AsyncSnapshot<List> snapshot){
            print(snapshot.data);
            return RestaurantCard(
              image: Image.asset(
                'asset/img/food/ddeok_bok_gi.jpg',
                fit: BoxFit.cover,
              ),
              name: '불타는 떡볶이',
              tags: ['떡볶이', '치즈', '매운맛'],
              ratingsCount: 100,
              deliveryTime: 15,
              deliveryFee: 2000,
              ratings: 4.67,
            );
          },

        ),
      ),
    );
  }
}
