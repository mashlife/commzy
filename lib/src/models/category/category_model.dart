// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoryModel {
  String? slug;
  String? name;
  String? url;
  CategoryModel({this.slug, this.name, this.url});

  CategoryModel copyWith({String? slug, String? name, String? url}) {
    return CategoryModel(
      slug: slug ?? this.slug,
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'slug': slug, 'name': name, 'url': url};
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      slug: map['slug'] != null ? map['slug'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
    );
  }

  @override
  String toString() => 'CategoryModel(slug: $slug, name: $name, url: $url)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.slug == slug && other.name == name && other.url == url;
  }

  @override
  int get hashCode => slug.hashCode ^ name.hashCode ^ url.hashCode;

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
