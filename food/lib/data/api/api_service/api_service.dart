import 'package:food/domain/entities/categories/categories.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../../domain/entities/dishes/dishes.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://run.mocky.io/v3/")
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET("058729bd-1402-4578-88de-265481fd7d54")
  Future<Categories> getCategories();

  @GET("aba7ecaa-0a70-453b-b62d-0e326c859b3b")
  Future<Dishes> getDishes();
}