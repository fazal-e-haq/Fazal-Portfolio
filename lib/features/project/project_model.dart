class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final String type; // e.g., "Mobile App", "Web App", "UI/UX"
  final List<String> tags;
  final String? codeUrl;
  final String? liveUrl;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.type,
    this.tags = const [],
    this.codeUrl,
    this.liveUrl,
  });
}
