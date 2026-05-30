import 'package:flutter/material.dart';

class ProjectDetail {
  // Global variables
  final int projectId;
  final String projectName;
  final String projectDetail;
  final List<AssetImage> pics;
  final List<String> technologies;
  // Constructure
  ProjectDetail({
    required this.projectId,
    required this.projectName,
    required this.projectDetail,
    required this.pics,
    required this.technologies,
  });
  // add data to json
  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'projectName': projectName,
      'projectDetail': projectDetail,
      'pics': pics,
      'technologies': technologies,
    };
  }

  //take data from json data
  factory ProjectDetail.fromJson(Map<String, dynamic> json) {
    return ProjectDetail(
      projectId: json['projectId'],
      projectName: json['projectName'],
      projectDetail: json['projectDetail'],
      pics: json['pics'],
      technologies: json['technologies'],
    );
  }
}
