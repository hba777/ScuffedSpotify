class AutoGenerate {
  AutoGenerate({
    required this.trackId,
    required this.trackName,
    required this.trackArtist,
    required this.trackPopularity,
    required this.trackAlbumId,
    required this.danceability,
    required this.energy,
    required this.keyValue,
    required this.loudness,
    required this.modeValue,
    required this.speechiness,
    required this.acousticness,
    required this.instrumentalness,
    required this.liveness,
    required this.valence,
    required this.tempo,
    required this.durationMs,
    this.url,
  });
  late final String trackId;
  late final String trackName;
  late final String trackArtist;
  late final int trackPopularity;
  late final String trackAlbumId;
  late final double danceability;
  late final double energy;
  late final int keyValue;
  late final double loudness;
  late final int modeValue;
  late final double speechiness;
  late final double acousticness;
  late final double instrumentalness;
  late final double liveness;
  late final double valence;
  late final double tempo;
  late final int durationMs;
  String? url;

  AutoGenerate.fromJson(Map<String, dynamic> json){
    trackId = json['track_id'];
    trackName = json['track_name'];
    trackArtist = json['track_artist'];
    trackPopularity = json['track_popularity'];
    trackAlbumId = json['track_album_id'];
    danceability = json['danceability'];
    energy = json['energy'];
    keyValue = json['key_value'];
    loudness = json['loudness'];
    modeValue = json['mode_value'];
    speechiness = json['speechiness'];
    acousticness = json['acousticness'];
    instrumentalness = json['instrumentalness'];
    liveness = json['liveness'];
    valence = json['valence'];
    tempo = json['tempo'];
    durationMs = json['duration_ms'];
    url = json['empUrl']; // Update to include empUrl
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['track_id'] = trackId;
    _data['track_name'] = trackName;
    _data['track_artist'] = trackArtist;
    _data['track_popularity'] = trackPopularity;
    _data['track_album_id'] = trackAlbumId;
    _data['danceability'] = danceability;
    _data['energy'] = energy;
    _data['key_value'] = keyValue;
    _data['loudness'] = loudness;
    _data['mode_value'] = modeValue;
    _data['speechiness'] = speechiness;
    _data['acousticness'] = acousticness;
    _data['instrumentalness'] = instrumentalness;
    _data['liveness'] = liveness;
    _data['valence'] = valence;
    _data['tempo'] = tempo;
    _data['duration_ms'] = durationMs;
    _data['url'] = url; // Include empUrl in the JSON
    return _data;
  }

  // Method to set the url attribute
  void setUrl(String Url) {
    url = Url;
  }
}