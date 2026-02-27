class DummyPost {
  final int id;
  final String username;
  final String avatar;
  final String location;
  final String image;
  final String caption;
  final String time;
  int likes;
  bool isLiked;
  bool isSaved;

  DummyPost({
    required this.id,
    required this.username,
    required this.avatar,
    required this.location,
    required this.image,
    required this.caption,
    required this.time,
    required this.likes,
    this.isLiked = false,
    this.isSaved = false,
  });
}

class DummyStory {
  final String username;
  final String avatar;
  final bool isSeen;
  DummyStory({required this.username, required this.avatar, this.isSeen = false});
}

class DummyReel {
  final int id;
  final String username;
  final String avatar;
  final String image;
  final String description;
  final String likes;
  final String comments;
  final String music;
  DummyReel({
    required this.id,
    required this.username,
    required this.avatar,
    required this.image,
    required this.description,
    required this.likes,
    required this.comments,
    required this.music,
  });
}

final List<DummyStory> dummyStories = [
  DummyStory(username: 'ahmed_k',    avatar: 'https://i.pravatar.cc/60?img=1'),
  DummyStory(username: 'sara_life',  avatar: 'https://i.pravatar.cc/60?img=5'),
  DummyStory(username: 'travel.log', avatar: 'https://i.pravatar.cc/60?img=8'),
  DummyStory(username: 'hamza_pk',   avatar: 'https://i.pravatar.cc/60?img=11', isSeen: true),
  DummyStory(username: 'nadia.arts', avatar: 'https://i.pravatar.cc/60?img=16', isSeen: true),
  DummyStory(username: 'usman.fx',   avatar: 'https://i.pravatar.cc/60?img=20', isSeen: true),
];

final List<DummyPost> dummyPosts = [
  DummyPost(
    id: 1, username: 'ahmed_k',
    avatar: 'https://i.pravatar.cc/40?img=1',
    location: 'Lahore, Pakistan',
    image: 'https://picsum.photos/480/480?random=11',
    caption: 'Golden hour never disappoints 🌅 #photography #lahore',
    time: '2 HOURS AGO', likes: 2847,
  ),
  DummyPost(
    id: 2, username: 'sara_life',
    avatar: 'https://i.pravatar.cc/40?img=5',
    location: 'Karachi Beach',
    image: 'https://picsum.photos/480/480?random=22',
    caption: 'Weekend vibes with the squad 🌊',
    time: '5 HOURS AGO', likes: 1293, isLiked: true,
  ),
  DummyPost(
    id: 3, username: 'travel.log',
    avatar: 'https://i.pravatar.cc/40?img=8',
    location: 'Hunza Valley',
    image: 'https://picsum.photos/480/480?random=33',
    caption: 'Pakistan is breathtaking 🏔️ #hunza #travel',
    time: '1 DAY AGO', likes: 9821,
  ),
  DummyPost(
    id: 4, username: 'hamza_pk',
    avatar: 'https://i.pravatar.cc/40?img=11',
    location: 'Islamabad',
    image: 'https://picsum.photos/480/480?random=44',
    caption: 'Coffee & code ☕💻 That\'s my whole personality',
    time: '2 DAYS AGO', likes: 542,
  ),
];

final List<DummyReel> dummyReels = [
  DummyReel(
    id: 1, username: 'nadia.arts',
    avatar: 'https://i.pravatar.cc/60?img=16',
    image: 'https://picsum.photos/480/860?random=50',
    description: 'Creating magic with colors 🎨 #art #creative',
    likes: '24.5K', comments: '342',
    music: 'Original audio - nadia.arts',
  ),
  DummyReel(
    id: 2, username: 'travel.log',
    avatar: 'https://i.pravatar.cc/60?img=8',
    image: 'https://picsum.photos/480/860?random=60',
    description: 'Pakistan — a land of wonders 🏔️ You NEED to visit!',
    likes: '89.2K', comments: '1.2K',
    music: 'Coke Studio - Ahmad Shah',
  ),
  DummyReel(
    id: 3, username: 'ahmed_k',
    avatar: 'https://i.pravatar.cc/60?img=1',
    image: 'https://picsum.photos/480/860?random=70',
    description: 'Behind the scenes of my latest shoot 📸',
    likes: '15.8K', comments: '892',
    music: 'Original audio - ahmed_k',
  ),
];