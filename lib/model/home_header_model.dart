class HomeHeaderModel {
  HomeHeaderModel({
    this.carousel,
    this.services,
  });

  List<Carousel>? carousel;
  List<Service>? services;

  factory HomeHeaderModel.fromJson(Map<String, dynamic> json) =>
      HomeHeaderModel(
        carousel: List<Carousel>.from(
            json["carousel"].map((x) => Carousel.fromJson(x))),
        services: List<Service>.from(
            json["services"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "carousel": List<dynamic>.from(carousel!.map((x) => x.toJson())),
        "services": List<dynamic>.from(services!.map((x) => x.toJson())),
      };
}

class Carousel {
  Carousel({
    this.image,
    this.type,
    this.id,
  });

  String? image;
  String? type;
  int? id;

  factory Carousel.fromJson(Map<String, dynamic> json) => Carousel(
        image: json["image"],
        type: json["type"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "type": type,
        "id": id,
      };
}

class Service {
  Service({
    this.serviceId,
    this.serviceName,
    this.spaCount,
  });

  int? serviceId;
  String? serviceName;
  int? spaCount;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        serviceId: json["serviceId"],
        serviceName: json["serviceName"],
        spaCount: json["spaCount"],
      );

  Map<String, dynamic> toJson() => {
        "serviceId": serviceId,
        "serviceName": serviceName,
        "spaCount": spaCount,
      };
}
