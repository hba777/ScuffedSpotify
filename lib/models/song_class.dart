class AutoGenerate {
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

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    trackId = json['track_id'];
    trackName = json['track_name'];
    trackArtist = json['track_artist'];
    trackPopularity = json['track_popularity'];
    trackAlbumId = json['track_album_id'];

    // Parsing danceability, energy, loudness, speechiness, acousticness, instrumentalness, liveness, valence, tempo
    danceability = parseDouble(json['danceability']);
    energy = parseDouble(json['energy']);
    keyValue = json['key_value'];
    loudness = parseDouble(json['loudness']);
    modeValue = json['mode_value'];
    speechiness = parseDouble(json['speechiness']);
    acousticness = parseDouble(json['acousticness']);
    instrumentalness = parseDouble(json['instrumentalness']);
    liveness = parseDouble(json['liveness']);
    valence = parseDouble(json['valence']);
    tempo = parseDouble(json['tempo']);

    durationMs = json['duration_ms'];
    url = json['empUrl']; // Update to include empUrl
  }

  // Utility method to safely parse double values
  double parseDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else {
      return 0.0; // Default value or handle accordingly
    }
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
