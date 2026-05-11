import 'package:flutter/material.dart';
import 'package:fazal_portfolio/core/models/project_model.dart';

class ProjectProvider extends ChangeNotifier {
  final List<ProjectModel> _projects = [
    ProjectModel(
      id: '2',
      title: 'Portfolio Design',
      description: 'A premium, dark-themed Neumorphic portfolio designed to showcase creative work with smooth animations and responsive layouts.',
      imagePath: 'assets/Images/my_portfolio_pic.png',
      projectUrl: 'https://github.com/fazal-e-haq/Fazal-Portfolio',
      technologies: ['Flutter', 'Neumorphism', 'Provider'],
    ),
  ];

  List<ProjectModel> get projects => _projects;
}
