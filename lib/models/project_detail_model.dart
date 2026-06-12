class ProjectDetail {
  // Global variables
  final String projectId;
  final String title;
  final String subTitle;
  final String explanation;
  final String pics;
  final List<String> technologies;
  final String? url;
  // Constructure
  ProjectDetail({
    required this.projectId,
    required this.title,
    required this.subTitle,
    required this.explanation,
    required this.pics,
    required this.technologies,
    this.url,
  });
  // add data to json
  // Map<String, dynamic> toJson() {
  //   return {
  //     'projectId': projectId,
  //     'projectName': projectName,
  //     'projectDetail': projectDetail,
  //     'pics': pics,
  //     'technologies': technologies,
  //   };
  // }
  //
  // //take data from json data
  // factory ProjectDetail.fromJson(Map<String, dynamic> json) {
  //   return ProjectDetail(
  //     projectId: json['projectId'],
  //     projectName: json['projectName'],
  //     projectDetail: json['projectDetail'],
  //     pics: json['pics'],
  //     technologies: json['technologies'],
  //   );
  // }
}
