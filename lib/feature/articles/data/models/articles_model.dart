import '../../domain/entities/articles_entity.dart';

/// Model untuk Articles yang digunakan di data layer
/// Extends ArticlesEntity dan menambahkan metode JSON serialization
class ArticlesModel extends ArticlesEntity {
  const ArticlesModel({
    required int count,
    required String? next,
    required dynamic previous,
    required List<ResultModel> results,
  }) : super(count: count, next: next, previous: previous, results: results);

  /// Factory constructor untuk membuat ArticlesModel dari JSON
  factory ArticlesModel.fromJson(Map<String, dynamic> json) {
    return ArticlesModel(
      count: json['count'] as int,
      next: json['next'] as String?,
      previous: json['previous'],
      results: (json['results'] as List<dynamic>)
          .map((x) => ResultModel.fromJson(x as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Mengkonversi ArticlesModel ke JSON
  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.cast<ResultModel>().map((x) => x.toJson()).toList(),
    };
  }
}

/// Model untuk Result/Article individual
class ResultModel extends ResultEntity {
  const ResultModel({
    required int id,
    required String title,
    required List<AuthorModel> authors,
    required String url,
    required String imageUrl,
    required String newsSite,
    required String summary,
    required DateTime publishedAt,
    required DateTime updatedAt,
    required bool featured,
    required List<LaunchModel> launches,
    required List<dynamic> events,
  }) : super(
         id: id,
         title: title,
         authors: authors,
         url: url,
         imageUrl: imageUrl,
         newsSite: newsSite,
         summary: summary,
         publishedAt: publishedAt,
         updatedAt: updatedAt,
         featured: featured,
         launches: launches,
         events: events,
       );

  /// Factory constructor untuk membuat ResultModel dari JSON
  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      id: json['id'] as int,
      title: json['title'] as String,
      authors: (json['authors'] as List<dynamic>)
          .map((x) => AuthorModel.fromJson(x as Map<String, dynamic>))
          .toList(),
      url: json['url'] as String,
      imageUrl: json['image_url'] as String,
      newsSite: json['news_site'] as String,
      summary: json['summary'] as String,
      publishedAt: DateTime.parse(json['published_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      featured: json['featured'] as bool,
      launches: (json['launches'] as List<dynamic>)
          .map((x) => LaunchModel.fromJson(x as Map<String, dynamic>))
          .toList(),
      events: json['events'] as List<dynamic>? ?? [],
    );
  }

  /// Mengkonversi ResultModel ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'authors': authors.cast<AuthorModel>().map((x) => x.toJson()).toList(),
      'url': url,
      'image_url': imageUrl,
      'news_site': newsSite,
      'summary': summary,
      'published_at': publishedAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'featured': featured,
      'launches': launches.cast<LaunchModel>().map((x) => x.toJson()).toList(),
      'events': events,
    };
  }
}

/// Model untuk Author
class AuthorModel extends AuthorEntity {
  const AuthorModel({required String name, required SocialsModel? socials})
    : super(name: name, socials: socials);

  /// Factory constructor untuk membuat AuthorModel dari JSON
  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      name: json['name'] as String,
      socials: json['socials'] != null
          ? SocialsModel.fromJson(json['socials'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Mengkonversi AuthorModel ke JSON
  Map<String, dynamic> toJson() {
    return {'name': name, 'socials': (socials as SocialsModel?)?.toJson()};
  }
}

/// Model untuk Socials
class SocialsModel extends SocialsEntity {
  const SocialsModel({
    String? x,
    String? youtube,
    String? instagram,
    String? linkedin,
    String? mastodon,
    String? bluesky,
  }) : super(
         x: x,
         youtube: youtube,
         instagram: instagram,
         linkedin: linkedin,
         mastodon: mastodon,
         bluesky: bluesky,
       );

  /// Factory constructor untuk membuat SocialsModel dari JSON
  factory SocialsModel.fromJson(Map<String, dynamic> json) {
    return SocialsModel(
      x: json['x'] as String?,
      youtube: json['youtube'] as String?,
      instagram: json['instagram'] as String?,
      linkedin: json['linkedin'] as String?,
      mastodon: json['mastodon'] as String?,
      bluesky: json['bluesky'] as String?,
    );
  }

  /// Mengkonversi SocialsModel ke JSON
  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'youtube': youtube,
      'instagram': instagram,
      'linkedin': linkedin,
      'mastodon': mastodon,
      'bluesky': bluesky,
    };
  }
}

/// Model untuk Launch
class LaunchModel extends LaunchEntity {
  const LaunchModel({required String launchId, required String provider})
    : super(launchId: launchId, provider: provider);

  /// Factory constructor untuk membuat LaunchModel dari JSON
  factory LaunchModel.fromJson(Map<String, dynamic> json) {
    return LaunchModel(
      launchId: json['launch_id'] as String,
      provider: json['provider'] as String,
    );
  }

  /// Mengkonversi LaunchModel ke JSON
  Map<String, dynamic> toJson() {
    return {'launch_id': launchId, 'provider': provider};
  }
}
