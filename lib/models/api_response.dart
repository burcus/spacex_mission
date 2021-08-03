import 'dart:collection';

class ApiResponse {

  String firingTime;
  String details;
  String patchUrl;
  String redditUrl;
  String name;
  List<String> images;

  ApiResponse({required this.patchUrl, required this.details, required this.name, required this.firingTime, required this.images, required this.redditUrl});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    LinkedHashMap<dynamic, dynamic> links =  json['links'];
    var map = HashMap.from(links);
    var patches = map["patch"];
    String patch = patches["small"] as String;
    var images = map['flickr']['original'];
    var redditUrl = map['reddit']['campaign'];
    List<String> imageList = images.cast<String>();

    return ApiResponse(
        images: imageList,
        firingTime: json['static_fire_date_utc'] as String,
        patchUrl : patch,
        details: json['details'] as String,
        name: json['name'] as String,
        redditUrl: redditUrl,
    );

  }
}
