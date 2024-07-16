class Audio {
  final String word;
  final String audioUrl;

  Audio({
    required this.word,
    required this.audioUrl,
  });

  factory Audio.fromJson(Map<String, dynamic> json) {
    return Audio(
      word: json['word'],
      audioUrl: json['audio_url'],
    );
  }
}
