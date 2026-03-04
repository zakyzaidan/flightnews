class Articles {
  int count;
  String? next;
  dynamic previous;
  List<Result> results;

  Articles({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory Articles.fromJson(Map<String, dynamic> json) => Articles(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  int id;
  String title;
  List<Author> authors;
  String url;
  String imageUrl;
  String newsSite;
  String summary;
  DateTime publishedAt;
  DateTime updatedAt;
  bool featured;
  List<Launch> launches;
  List<dynamic> events;

  Result({
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

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    title: json["title"],
    authors: List<Author>.from(json["authors"].map((x) => Author.fromJson(x))),
    url: json["url"],
    imageUrl: json["image_url"],
    newsSite: json["news_site"],
    summary: json["summary"],
    publishedAt: DateTime.parse(json["published_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    featured: json["featured"],
    launches: List<Launch>.from(
      json["launches"].map((x) => Launch.fromJson(x)),
    ),
    events: json["events"] ?? [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "authors": List<dynamic>.from(authors.map((x) => x.toJson())),
    "url": url,
    "image_url": imageUrl,
    "news_site": newsSite,
    "summary": summary,
    "published_at": publishedAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "featured": featured,
    "launches": List<dynamic>.from(launches.map((x) => x.toJson())),
    "events": events,
  };
}

class Author {
  String name;
  Socials? socials;

  Author({required this.name, required this.socials});

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    name: json["name"],
    socials: json["socials"] != null ? Socials.fromJson(json["socials"]) : null,
  );

  Map<String, dynamic> toJson() => {"name": name, "socials": socials?.toJson()};
}

class Socials {
  String? x;
  String? youtube;
  String? instagram;
  String? linkedin;
  String? mastodon;
  String? bluesky;

  Socials({
    this.x,
    this.youtube,
    this.instagram,
    this.linkedin,
    this.mastodon,
    this.bluesky,
  });

  factory Socials.fromJson(Map<String, dynamic> json) => Socials(
    x: json["x"],
    youtube: json["youtube"],
    instagram: json["instagram"],
    linkedin: json["linkedin"],
    mastodon: json["mastodon"],
    bluesky: json["bluesky"],
  );

  Map<String, dynamic> toJson() => {
    "x": x,
    "youtube": youtube,
    "instagram": instagram,
    "linkedin": linkedin,
    "mastodon": mastodon,
    "bluesky": bluesky,
  };
}

class Launch {
  String launchId;
  String provider;

  Launch({required this.launchId, required this.provider});

  factory Launch.fromJson(Map<String, dynamic> json) =>
      Launch(launchId: json["launch_id"], provider: json["provider"]);

  Map<String, dynamic> toJson() => {
    "launch_id": launchId,
    "provider": provider,
  };
}
