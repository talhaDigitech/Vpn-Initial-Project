class SplashScreenContent {
  String title;
  String image;
  String description;

  SplashScreenContent({
    required this.image,
    required this.title,
    required this.description,
  });

}

List<SplashScreenContent> contents = [
  SplashScreenContent(
    title: "100% Safe and Secured", 
    image: "assets/images/safe.svg", 
    description: "Surf the web without fear! Our VPN provides robust encryption to guarantee your online presence. Protect your data against snoopers and hackers. Experience absolute online freedom in a secure environment!" ,
    ),
  SplashScreenContent(
    title: "Upto 3 time faster", 
    image: "assets/images/fastloading.svg", 
    description: "Surf the web without fear! Our VPN provides robust encryption to guarantee your online presence. Protect your data against snoopers and hackers. Experience absolute online freedom in a secure environment!"  ,
    ),
  SplashScreenContent(
    title: "High speed server", 
    image: "assets/images/speed.svg", 
    description: "Surf the web without fear! Our VPN provides robust encryption to guarantee your online presence. Protect your data against snoopers and hackers. Experience absolute online freedom in a secure environment!"  ,
    ),
];