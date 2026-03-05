import 'package:equatable/equatable.dart';

/// Entity untuk article di domain layer
/// Ini adalah representasi pure business logic tanpa dependency external
class ArticlesEntity extends Equatable {
  final int count;
  final String? next;
  final dynamic previous;
  final List<ResultEntity> results;

  const ArticlesEntity({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  @override
  List<Object?> get props => [count, next, previous, results];
}

/// Entity untuk individual article result
class ResultEntity extends Equatable {
  final int id;
  final String title;
  final List<AuthorEntity> authors;
  final String url;
  final String imageUrl;
  final String newsSite;
  final String summary;
  final DateTime publishedAt;
  final DateTime updatedAt;
  final bool featured;
  final List<LaunchEntity> launches;
  final List<dynamic> events;

  const ResultEntity({
    required this.id,
    required this.title,
    required this.authors,
    required this.url,
    required this.imageUrl,
    required this.newsSite,
    required this.summary,
    required this.publishedAt,
    required this.updatedAt,
    required this.featured,
    required this.launches,
    required this.events,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    authors,
    url,
    imageUrl,
    newsSite,
    summary,
    publishedAt,
    updatedAt,
    featured,
    launches,
    events,
  ];
}

/// Entity untuk article author
class AuthorEntity extends Equatable {
  final String name;
  final SocialsEntity? socials;

  const AuthorEntity({required this.name, required this.socials});

  @override
  List<Object?> get props => [name, socials];
}

/// Entity untuk author socials
class SocialsEntity extends Equatable {
  final String? x;
  final String? youtube;
  final String? instagram;
  final String? linkedin;
  final String? mastodon;
  final String? bluesky;

  const SocialsEntity({
    this.x,
    this.youtube,
    this.instagram,
    this.linkedin,
    this.mastodon,
    this.bluesky,
  });

  @override
  List<Object?> get props => [
    x,
    youtube,
    instagram,
    linkedin,
    mastodon,
    bluesky,
  ];
}

/// Entity untuk launch
class LaunchEntity extends Equatable {
  final String launchId;
  final String provider;

  const LaunchEntity({required this.launchId, required this.provider});

  @override
  List<Object?> get props => [launchId, provider];
}
