import '../../features/project/project_model.dart';

class Projects {
  static const List<ProjectModel> _projectDetails = [
    ProjectModel(
      id: '1',
      title: 'CutCount',
      logo: 'assets/Images/works/cutcount/cutcount-logo.webp',
      shortDescription: 'Local barber tracking & earnings app.',
      description:
          'A local, private application designed for barbers to safely track daily haircut counts and automatically calculate total earnings with zero internet required.',
      imagePath: 'assets/Images/works/cutcount/cutcount-dashboard-ss.webp',
      screenshots: [
        'assets/Images/works/cutcount/cutcount-dashboard-ss.webp',
        'assets/Images/works/cutcount/cutcount-history-ss.webp',
        'assets/Images/works/cutcount/cutcount-services-ss.webp',
      ],
      downloads: 'Coming Soon',
      rating: 'Not yet rated',
      type: 'Mobile App',
      tags: ['Flutter', 'Dart', 'Isar DB', 'Provider'],
      codeUrl: 'https://github.com/fazal-e-haq/CutCount.git',
    ),
  ];

  List<ProjectModel> get projects => _projectDetails;
}
