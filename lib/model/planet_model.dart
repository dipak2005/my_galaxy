// To parse this JSON data, do
//
//     final planet = planetFromJson(jsonString);

import 'dart:convert';

List<Planet> planetFromJson(String str) => List<Planet>.from(json.decode(str).map((x) => Planet.fromJson(x)));

String planetToJson(List<Planet> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Planet {
  String? position;
  String? name;
  String? spe;
  String? image;
  String? equatorialDistance;
  String? mass;
  String? galCenterDistance;
  String? rotationPeriod;
  String? galacticOrbitPeriod;
  String? surfaceGravity;
  String? surfaceTemperature;
  String? detail;
  String? composition;
  String? distance;
  String? equatorialDiameter;
  String? meanDistFromSun;
  String? planetSolarOrbitPeriod;
  String? planetObservation;
  String? galaxy;
  String? atmosphere;
  String? surface;
  String? axialTilt;
  String? magField;
  String? origin;
  String? earthLike;
  String? water;
  String? moons;
  String? missions;
  String? starLike;
  String? observation;
  String? massD;
  String? ring;
  String? discovery;
  String? purpleAxialTilt;
  String? massU;
  String? solarOrbitPeriod;
  String? planetAxialTilt;

  Planet({
    this.position,
    this.name,
    this.spe,
    this.image,
    this.equatorialDistance,
    this.mass,
    this.galCenterDistance,
    this.rotationPeriod,
    this.galacticOrbitPeriod,
    this.surfaceGravity,
    this.surfaceTemperature,
    this.detail,
    this.composition,
    this.distance,
    this.equatorialDiameter,
    this.meanDistFromSun,
    this.planetSolarOrbitPeriod,
    this.planetObservation,
    this.galaxy,
    this.atmosphere,
    this.surface,
    this.axialTilt,
    this.magField,
    this.origin,
    this.earthLike,
    this.water,
    this.moons,
    this.missions,
    this.starLike,
    this.observation,
    this.massD,
    this.ring,
    this.discovery,
    this.purpleAxialTilt,
    this.massU,
    this.solarOrbitPeriod,
    this.planetAxialTilt,
  });

  factory Planet.fromJson(Map<String, dynamic> json) => Planet(
    position: json["position"],
    name: json["name"],
    spe: json["spe:"],
    image: json["image"],
    equatorialDistance: json["Equatorial Distance"],
    mass: json["Mass"],
    galCenterDistance: json["Gal.Center Distance"],
    rotationPeriod: json["Rotation Period"],
    galacticOrbitPeriod: json["Galactic Orbit Period"],
    surfaceGravity: json["Surface Gravity"],
    surfaceTemperature: json["Surface Temperature"],
    detail: json["Detail"],
    composition: json["Composition"],
    distance: json["Distance"],
    equatorialDiameter: json["Equatorial Diameter"],
    meanDistFromSun: json["Mean Dist. from Sun"],
    planetSolarOrbitPeriod: json["Solar Orbit Period "],
    planetObservation: json["Observation"],
    galaxy: json["Galaxy"],
    atmosphere: json["Atmosphere"],
    surface: json["Surface"],
    axialTilt: json["Axial Tilt"],
    magField: json["Mag. Field"],
    origin: json["Origin"],
    earthLike: json["Earth-Like"],
    water: json["Water"],
    moons: json["Moons"],
    missions: json["Missions"],
    starLike: json["Star-Like"],
    observation: json["Observation"],
    massD: json["Mass-D"],
    ring: json["Ring"],
    discovery: json["Discovery"],
    purpleAxialTilt: json["Axial-tilt"],
    massU: json["Mass-u"],
    solarOrbitPeriod: json["Solar Orbit Period"],
    planetAxialTilt: json["Axial-Tilt"],
  );

  Map<String, dynamic> toJson() => {
    "position": position,
    "name": name,
    "spe:": spe,
    "image": image,
    "Equatorial Distance": equatorialDistance,
    "Mass": mass,
    "Gal.Center Distance": galCenterDistance,
    "Rotation Period": rotationPeriod,
    "Galactic Orbit Period": galacticOrbitPeriod,
    "Surface Gravity": surfaceGravity,
    "Surface Temperature": surfaceTemperature,
    "Detail": detail,
    "Composition": composition,
    "Distance": distance,
    "Equatorial Diameter": equatorialDiameter,
    "Mean Dist. from Sun": meanDistFromSun,
    "Solar Orbit Period ": planetSolarOrbitPeriod,
    "Observation": planetObservation,
    "Galaxy": galaxy,
    "Atmosphere": atmosphere,
    "Surface": surface,
    "Axial Tilt": axialTilt,
    "Mag. Field": magField,
    "Origin": origin,
    "Earth-Like": earthLike,
    "Water": water,
    "Moons": moons,
    "Missions": missions,
    "Star-Like": starLike,
    "Observation": observation,
    "Mass-D": massD,
    "Ring": ring,
    "Discovery": discovery,
    "Axial-tilt": purpleAxialTilt,
    "Mass-u": massU,
    "Solar Orbit Period": solarOrbitPeriod,
    "Axial-Tilt": planetAxialTilt,
  };
}
