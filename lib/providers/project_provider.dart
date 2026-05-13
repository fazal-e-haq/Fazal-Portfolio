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
    ProjectModel(
      id: '3',
      title: 'Periodic Table App',
      description: 'A comprehensive periodic table application built with high-performance search and detailed element profiles.',
      imagePath: 'assets/Images/periodic_table.png',
      projectUrl: 'https://github.com/fazal-e-haq/Nuko-Periodic-Table',
      technologies: ['Flutter', 'Custom Search', 'Animation'],
    ),
    ProjectModel(
      id: '4',
      title: 'E-Commerce UI',
      description: 'A modern e-commerce mobile application interface with glassmorphic effects and a smooth checkout flow.',
      imagePath: 'assets/Images/ecommerce_ui.png',
      projectUrl: 'https://github.com/fazal-e-haq',
      technologies: ['Flutter', 'UI/UX', 'Glassmorphism'],
    ),
  ];

  List<ProjectModel> get projects => _projects;
}
