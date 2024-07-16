class Alphabet {
  final int id;
  final String alphabet;
  final String audioUrl;
  final int languageId;

  Alphabet({
    required this.id,
    required this.languageId,
    required this.alphabet,
    required this.audioUrl,
    
  });

  factory Alphabet.fromJson(Map<String, dynamic> json) {
    return Alphabet(
      id: json['id'],
      languageId: json['language_id'],
      alphabet: json['alphabet'],
      audioUrl: json['audio_url'],
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'alphabet': alphabet,
      'audio_url': audioUrl,
      'language_id': languageId,
    };
  }
}
