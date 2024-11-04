// To parse this JSON data, do
//
//     final quoteSet = quoteSetFromJson(jsonString);

import 'dart:convert';

QuoteSet quoteSetFromJson(String str) => QuoteSet.fromJson(json.decode(str));

String quoteSetToJson(QuoteSet data) => json.encode(data.toJson());

class QuoteSet {
  List<Quote>? quotes;
  int? total;
  int? skip;
  int? limit;

  QuoteSet({
    this.quotes,
    this.total,
    this.skip,
    this.limit,
  });

  factory QuoteSet.fromJson(Map<String, dynamic> json) => QuoteSet(
        quotes: json["quotes"] == null
            ? []
            : List<Quote>.from(json["quotes"]!.map((x) => Quote.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "quotes": quotes == null
            ? []
            : List<dynamic>.from(quotes!.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}

class Quote {
  int? id;
  String? quote;
  String? author;

  Quote({
    this.id,
    this.quote,
    this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        id: json["id"],
        quote: json["quote"],
        author: json["author"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quote": quote,
        "author": author,
      };
}
