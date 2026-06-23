import '../../features/sections/project/project_detail_model.dart';

class Projects {
  static final List<ProjectDetail> _projectDetails = [
    ProjectDetail(
      projectId: '1',
      title: 'CutCount',
      subTitle: 'Offline Management App for Barbers',
      explanation:
          'A local, private application designed for barbers to safely track daily haircut counts and automatically calculate total earnings with zero internet required',
      pics: 'assets/Images/cut_count.webp',
      technologies: [
        'Flutter framework',
        'SQLite',
        'Provider(State Management)',
      ],
      url: 'https://github.com/fazal-e-haq/CutCount.git',
    ),
    ProjectDetail(
      projectId: '2',
      title: 'O News',
      subTitle: 'Clean, Non-Political Daily News Experience',
      explanation:
          'A curated UI/UX design for a minimalist news application that filters out political noise to deliver daily, high-quality updates strictly on education, health, science, and sports. Designed for a focused 30-to-60 minute clean reading routine.',
      pics: 'assets/Images/o-news.webp',
      technologies: [
        'Figma',
        'Design Thinking',
        'User Experience Design',
        'User Flows',
      ],
    ),
  ];

  List<ProjectDetail> get projects => _projectDetails;
}
