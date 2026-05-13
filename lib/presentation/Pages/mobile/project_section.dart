import 'package:fazal_portfolio/core/models/project_model.dart';
import 'package:fazal_portfolio/providers/project_provider.dart';
import 'package:fazal_portfolio/presentation/widgets/responsive_text.dart';
import 'package:flutter/material.dart';
import 'package:fazal_portfolio/presentation/widgets/info_card_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';
import 'package:provider/provider.dart';

// This is the project section tailored for mobile devices
class MobileProjectSection extends StatelessWidget {
  const MobileProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final projectProvider = context.watch<ProjectProvider>();
    final projects = projectProvider.projects;

    return SizedBox(
      width: size.width,
      child: Center(
        child: InfoCardWidget(
          width: size.width * 0.92,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ResponsiveText(
                'My Projects',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                minFontSize: 24,
                maxFontSize: 30,
              ),
              const SizedBox(height: 30),
              // Changed to horizontal scrolling as requested
            _MobileProjectsCards( ),

            ],
          ),
        ),
      ),
    );
  }
}

class _MobileProjectsCards extends StatelessWidget {
 const _MobileProjectsCards({super.key,   });
   // final ProjectModel project;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
         height: size.height * 0.6,
          width: size.width * 0.65,
          decoration: BoxDecoration(
            color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF2A2A2A)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(4, 4),
          ),
        ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF222222),
                  image: DecorationImage(
                    image: AssetImage( ''),
                    fit: BoxFit.cover,
                    opacity: 0.2,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.code_rounded,
                    size: 40,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
              Text('prjt name'),
              Text('decri '),
              Text('button'),

            ],),
          ),
        ),
      ],
    );
  }
}

// class _MobileProjectCard extends StatelessWidget {
//   final ProjectModel project;
//
//   const _MobileProjectCard({required this.project});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width:
//           MediaQuery.of(context).size.width *
//           0.8, // Take most of the screen width
//       margin: const EdgeInsets.only(right: 15),
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: const Color(0xFF151515),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: const Color(0xFF2A2A2A)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.3),
//             blurRadius: 10,
//             offset: const Offset(4, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(15),
//             child: Container(
//               height: 140,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: const Color(0xFF222222),
//                 image: DecorationImage(
//                   image: AssetImage(project.imagePath),
//                   fit: BoxFit.cover,
//                   opacity: 0.2,
//                 ),
//               ),
//               child: const Center(
//                 child: Icon(
//                   Icons.code_rounded,
//                   size: 40,
//                   color: Colors.blueAccent,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 15),
//           Text(
//             project.title,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             project.description,
//             style: const TextStyle(
//               color: Colors.grey,
//               fontSize: 13,
//               height: 1.4,
//             ),
//             maxLines: 3,
//             overflow: TextOverflow.ellipsis,
//           ),
//           const Spacer(),
//           ButtonWidget(
//             url: project.projectUrl,
//             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//             child: const Text('View Project', style: TextStyle(fontSize: 11)),
//           ),
//         ],
//       ),
//     );
//   }
// }
