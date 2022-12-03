import 'package:ace_player/models/apic.model.dart';

class MusicModel {
  final String filename;
  final String path;
  final int duration; // in seconds
  final String? title;
  final String? artist;
  final String? album;
  final int? year;
  final String? genre;
  final ApicModel? apic;

  MusicModel(
      {required this.filename,
      required this.path,
      required this.duration,
      this.album,
      this.apic,
      this.artist,
      this.genre,
      this.title,
      this.year});

  factory MusicModel.fromJson(Map<String, dynamic> json) {
    return MusicModel(
      filename: json['filename'],
      path: json['path'],
      duration: json['duration'],
      album: json['Album'],
      apic: ApicModel.fromJson(json['APIC']),
      artist: json['Artist'],
      genre: json['Genre'],
      title: json['Title'],
      year: int.tryParse(json['Year'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'filename': filename,
      'path': path,
      'duration': duration,
      'Title': title,
      'Artist': artist,
      'Album': album,
      'Year': year,
      'Genre': genre,
      'APIC': apic?.toJson()
    };
  }
}
