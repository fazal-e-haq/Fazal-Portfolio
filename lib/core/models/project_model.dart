class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final String? projectUrl;
  final List<String> technologies;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    this.projectUrl,
    required this.technologies,
  });
}
