import '../../features/project/project_model.dart';

class Projects {
  static const List<ProjectModel> _projectDetails = [
    ProjectModel(
      id: '1',
      title: 'CutCount',
      description: 'A local, private application designed for barbers to safely track daily haircut counts and automatically calculate total earnings with zero internet required.',
      imagePath: 'assets/Images/cut_count.webp',
      type: 'Mobile App',
      tags: ['Flutter', 'Dart', 'Isar DB', 'Provider'],
      codeUrl: 'https://github.com/fazal-e-haq/CutCount.git',
    ),
    ProjectModel(
      id: '2',
      title: 'O News',
      description: 'A curated UI/UX design for a minimalist news application that filters out political noise to deliver daily, high-quality updates strictly on education, health, science, and sports.',
      imagePath: 'assets/Images/o-news.webp',
      type: 'UI/UX Design',
      tags: ['Figma', 'UI/UX', 'Prototyping', 'Minimalism'],
    ),
  ];

  List<ProjectModel> get projects => _projectDetails;
}
