import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Developer Info'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.darkGold,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.darkGold,
                child: Icon(Icons.person, size: 70, color: Colors.white),
              ),
              const SizedBox(height: 24),
              const Text(
                'Guillermo Zabala',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Estudiante de Ing. de sistemas',
                style: TextStyle(fontSize: 16, color: AppColors.deepGold),
              ),
              const SizedBox(height: 24),
              const ListTile(
                leading: Icon(Icons.email, color: AppColors.darkGold),
                title: Text('Gzabala.3122@unimar.edu.ve'),
              ),
              const ListTile(
                leading: Icon(Icons.code, color: AppColors.darkGold),
                title: Text('github.com/Guill07'),
              ),
              const ListTile(
                leading: Icon(Icons.school, color: AppColors.darkGold),
                title: Text('Universidad De Margarita'),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Volver a la calculadora'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkGold,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}