// lib/screens/common/onboarding_screen.dart
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen>  createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  // List of onboarding data
  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/onboarding1.png',
      'title': 'Welcome to CampusConnect',
      'description': 'Discover and join events happening on your campus.'
    },
    {
      'image': 'assets/images/onboarding2.png',
      'title': 'Personalized Recommendations',
      'description': 'Get event suggestions tailored to your interests.'
    },
    {
      'image': 'assets/images/onboarding3.png',
      'title': 'Connect with Societies',
      'description': 'Follow your favorite societies and stay updated.'
    },
    {
      'image': 'assets/images/onboarding4.png',
      'title': 'Ready to Explore?',
      'description': 'Sign up or log in to get started!'
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  // Save that onboarding has been seen
  Future<void> _completeOnboarding() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('onboarding_complete', true);
    // Navigate to the login screen
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void dispose() {
    _pageController.dispose(); 
    super.dispose();
  }

  Widget _buildPageContent(Map<String, String> data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          data['image']!,
          height: 250,
        ),
        const SizedBox(height: 30),
        Text(
          data['title']!,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            data['description']!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingData.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return _buildPageContent(onboardingData[index]);
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: _currentPage < onboardingData.length - 1
                ? TextButton(
                    onPressed: _completeOnboarding,
                    child: const Text('Skip'),
                  )
                : const SizedBox.shrink(),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: _currentPage == onboardingData.length - 1
                ? TextButton(
                    onPressed: _completeOnboarding,
                    child: const Text('Get Started'),
                  )
                : TextButton(
                    child: const Text('Next'),
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => _buildIndicator(index == _currentPage),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 6,
      width: isActive ? 20 : 6,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
