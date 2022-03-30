import 'package:dio/dio.dart';
import 'package:jsondemoproject/constant/rest_path.dart';
import 'package:jsondemoproject/model/post_dto.dart';
import 'package:jsondemoproject/model/user_body.dart';
import 'package:jsondemoproject/model/user_dto.dart';
import 'package:retrofit/retrofit.dart';

/**
 * Created by Amit Rawat on 3/30/2022.
 */
part 'rest_client.g.dart';

@RestApi(baseUrl: RestPath.BASE_URL)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET(RestPath.POST)
  Future<List<PostDTO>> getListPost(
    @Query("_limit") int limit,
  );

  @GET(RestPath.USER)
  Future<List<UserDTO>> getUser();

  @DELETE("posts/{id}")
  Future<PostDTO> deletePost(@Path("id") int id);

  @PUT("posts/{id}")
  Future<PostDTO> updating(@Path() int id, @Body() UserBody userBody);

  @POST(RestPath.POST)
  Future<PostDTO> creatingNew(@Body() UserBody userBody);
}
