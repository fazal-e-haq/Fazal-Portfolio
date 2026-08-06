class ProjectModel {
  final String id;
  final String title;
  final String logo; // New Play Store style
  final String shortDescription; // New Play Store style
  final String description; // Full description
  final String imagePath; // Main/Feature image
  final List<String> screenshots; // New Play Store style (3-5 screenshots)
  final String downloads; // New Play Store style (e.g. "1k+", "500+")
  final String rating; // New Play Store style (e.g. 4.8)
  final String type; // e.g., "Mobile App", "Web App", "UI/UX"
  final List<String> tags;
  final String? codeUrl;
  final String? liveUrl;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.logo,
    required this.shortDescription,
    required this.description,
    required this.imagePath,
    required this.screenshots,
    required this.downloads,
    required this.rating,
    required this.type,
    this.tags = const [],
    this.codeUrl,
    this.liveUrl,
  });
}
