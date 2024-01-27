class AutoGenerateAlbums {
  AutoGenerateAlbums({
    required this.trackAlbumId,
    required this.trackAlbumName,
    required this.trackAlbumReleaseDate,
    this.url,
  });
  late final String trackAlbumId;
  late final String trackAlbumName;
  late final String trackAlbumReleaseDate;
  String? url;

  AutoGenerateAlbums.fromJson(Map<String, dynamic> json){
    trackAlbumId = json['track_album_id'] as String;
    trackAlbumName = json['track_album_name'] as String;
    trackAlbumReleaseDate = json['track_album_release_date'] as String;
    url = json['empUrl']; // Update to include empUrl
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['track_album_id'] = trackAlbumId;
    _data['track_album_name'] = trackAlbumName;
    _data['track_album_release_date'] = trackAlbumReleaseDate;
    _data['url'] = url; // Include empUrl in the JSON
    return _data;
  }

  // Method to set the url attribute
  void setUrl(String Url) {
    url = Url;
  }
}