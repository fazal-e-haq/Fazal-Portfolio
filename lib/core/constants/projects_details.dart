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
      rating: '4.9',
      type: 'Mobile App',
      tags: ['Flutter', 'Dart', 'Isar DB', 'Provider'],
      codeUrl: 'https://github.com/fazal-e-haq/CutCount.git',
    ),
    ProjectModel(
      id: '2',
      title: 'CopyFlutter',
      logo: 'assets/Images/works/copyflutter/copyflutter-logo.webp',
      shortDescription: 'Open-source Flutter UI component & template library.',
      description:
          'A curated library of responsive, copy-paste Flutter UI components, interactive widgets, buttons, loaders, and templates built to supercharge developer workflows.',
      imagePath: 'assets/Images/works/copyflutter/home_page.webp',
      screenshots: [
        'assets/Images/works/copyflutter/home_page.webp',
        'assets/Images/works/copyflutter/components_page.webp',
        'assets/Images/works/copyflutter/component_detail_page.webp',
      ],
      downloads: 'Open Source',
      rating: '5.0',
      type: 'Web App',
      tags: ['Flutter Web', 'Firebase', 'GetX', 'Dart'],
      liveUrl: 'https://copy-flutter.web.app',
      codeUrl: 'https://copy-flutter.web.app',
    ),
  ];

  List<ProjectModel> get projects => _projectDetails;
}
