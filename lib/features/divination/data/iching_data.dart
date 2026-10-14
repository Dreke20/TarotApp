import '../domain/hexagram.dart';

class IChingData {
  static const List<Hexagram> primaryHexagrams = [
    Hexagram(
      number: 1,
      name: 'Qian',
      englishTitle: 'The Creative Force',
      chineseCharacter: '乾',
      upperTrigram: 'Heaven',
      lowerTrigram: 'Heaven',
      lines: [1, 1, 1, 1, 1, 1],
      judgment: 'The Creative works sublime success, furthering through perseverance.',
      image: 'The movement of heaven is full of power. Thus the superior seeker makes themselves strong and untiring.',
      guidance: 'Pure creative potential is surging through you. Step forward with unyielding integrity, clarity of will, and noble purpose.',
    ),
    Hexagram(
      number: 2,
      name: 'Kun',
      englishTitle: 'The Receptive Earth',
      chineseCharacter: '坤',
      upperTrigram: 'Earth',
      lowerTrigram: 'Earth',
      lines: [0, 0, 0, 0, 0, 0],
      judgment: 'The Receptive brings about supreme success. The devotion of the mare furthers. If the seeker initiates, they go astray; if they follow, they find guidance.',
      image: 'The earth\'s condition is receptive devotion. Thus the superior seeker sustains the world with broad generosity.',
      guidance: 'Now is the sacred hour of listening, not pushing. Open your hands, surrender control, and allow the universe to nurture your seeds.',
    ),
    Hexagram(
      number: 3,
      name: 'Zhun',
      englishTitle: 'Difficulty at the Beginning',
      chineseCharacter: '屯',
      upperTrigram: 'Water',
      lowerTrigram: 'Thunder',
      lines: [1, 0, 0, 0, 1, 0],
      judgment: 'Initial chaos precedes great order. Do not undertake reckless flight; appoint helpers and build your foundation.',
      image: 'Clouds and thunder: the image of chaos before form. The seeker brings order out of confusion.',
      guidance: 'A tender new sprout pushing through cold soil faces resistance. Do not mistake early friction for failure; be patient and assemble wise counsel.',
    ),
    Hexagram(
      number: 4,
      name: 'Meng',
      englishTitle: 'Youthful Folly',
      chineseCharacter: '蒙',
      upperTrigram: 'Mountain',
      lowerTrigram: 'Water',
      lines: [0, 1, 0, 0, 0, 1],
      judgment: 'Youthful inexperience brings success. It is not the master who seeks the student; the student seeks the master in humble sincerity.',
      image: 'A spring wells up at the foot of the mountain: the image of untamed youth. The seeker cultivates character through thoroughness.',
      guidance: 'Admit what you do not know. Approach life with beginner\'s mind. Wisdom will not force its way where arrogance has shut the door.',
    ),
    Hexagram(
      number: 5,
      name: 'Xu',
      englishTitle: 'Waiting / Nourishment',
      chineseCharacter: '需',
      upperTrigram: 'Water',
      lowerTrigram: 'Heaven',
      lines: [1, 1, 1, 0, 1, 0],
      judgment: 'Waiting with sincere presence. One has light and success. Perseverance brings good fortune. It furthers one to cross the great stream.',
      image: 'Clouds rise up to heaven: the image of waiting for rain. The seeker eats, drinks, and is joyous of good cheer while the sky gathers power.',
      guidance: 'Forcing the fruit to ripen will only poison the feast. Nourish your spirit, feast in good company, and allow timing to complete the circle.',
    ),
    Hexagram(
      number: 6,
      name: 'Song',
      englishTitle: 'Conflict / Restraint',
      chineseCharacter: '訟',
      upperTrigram: 'Heaven',
      lowerTrigram: 'Water',
      lines: [0, 1, 0, 1, 1, 1],
      judgment: 'You are sincere and are yet obstructed. A cautious halt brings good fortune. Going through to the end brings misfortune.',
      image: 'Heaven and water go their opposite ways: the image of conflict. The seeker considers well the beginning before entering contention.',
      guidance: 'Winning an argument at the cost of your peace is a defeat. Yield ground, cease the debate, and seek neutral mediation before damage is permanent.',
    ),
    Hexagram(
      number: 11,
      name: 'Tai',
      englishTitle: 'Peace & Harmony',
      chineseCharacter: '泰',
      upperTrigram: 'Earth',
      lowerTrigram: 'Heaven',
      lines: [1, 1, 1, 0, 0, 0],
      judgment: 'The small departs, the great approaches. Good fortune, supreme blessing and success.',
      image: 'Heaven and earth unite: the image of golden peace. The sovereign shares and divides wealth in accordance with the seasons.',
      guidance: 'A rare golden window of mutual trust and effortless momentum has opened. Pour your heart into meaningful connections and bold creative projects.',
    ),
    Hexagram(
      number: 12,
      name: 'Pi',
      englishTitle: 'Standstill / Stagnation',
      chineseCharacter: '否',
      upperTrigram: 'Heaven',
      lowerTrigram: 'Earth',
      lines: [0, 0, 0, 1, 1, 1],
      judgment: 'Heaven and earth do not communicate; the small comes and the great departs. The seeker perseveres in frugal virtue.',
      image: 'Heaven and earth do not interact: the image of stagnation. The seeker retreats into inner virtue to escape difficulties.',
      guidance: 'Outer circumstances are closed to outward expansion. Do not compromise your moral compass to force acceptance. Retreat into your quiet sanctuary.',
    ),
    Hexagram(
      number: 24,
      name: 'Fu',
      englishTitle: 'Return / The Turning Point',
      chineseCharacter: '復',
      upperTrigram: 'Earth',
      lowerTrigram: 'Thunder',
      lines: [1, 0, 0, 0, 0, 0],
      judgment: 'Return. Success. Going and coming without error. On the seventh day comes the return. It furthers one to have somewhere to go.',
      image: 'Thunder within the earth: the solstice turning point. The ancient kings closed the gates at solstice and rested from labor.',
      guidance: 'The darkest night has reached its peak and the first ray of starlight is returning. Welcome your quiet rebirth with gentle steps.',
    ),
    Hexagram(
      number: 29,
      name: 'Kan',
      englishTitle: 'The Abysmal / Water',
      chineseCharacter: '坎',
      upperTrigram: 'Water',
      lowerTrigram: 'Water',
      lines: [0, 1, 0, 0, 1, 0],
      judgment: 'Repeated danger. If you are sincere, you have success in your heart, and whatever you do succeeds.',
      image: 'Water flows on continuously: the image of the abysmal canyon. The seeker walks in enduring virtue and teaches with relentless flow.',
      guidance: 'You are passing through turbulent waters. Do not panic or thrash; flow like water around obstacles, staying true to your innermost current.',
    ),
    Hexagram(
      number: 30,
      name: 'Li',
      englishTitle: 'The Clinging / Fire',
      chineseCharacter: '離',
      upperTrigram: 'Fire',
      lowerTrigram: 'Fire',
      lines: [1, 0, 1, 1, 0, 1],
      judgment: 'The Clinging brings perseverance and supreme success. Tending the sacred fire brings blessing.',
      image: 'Bright fire rises doubly: the image of clarity and devotion. The great seeker continues the light by illuminating the four quarters.',
      guidance: 'Fire cannot burn without wood; brilliance cannot shine without humility and self-care. Tend to your emotional fuel so your sacred flame never consumes you.',
    ),
    Hexagram(
      number: 64,
      name: 'Wei Ji',
      englishTitle: 'Before Completion',
      chineseCharacter: '未濟',
      upperTrigram: 'Fire',
      lowerTrigram: 'Water',
      lines: [0, 1, 0, 1, 0, 1],
      judgment: 'Before completion: success. But if the little fox gets its tail wet just as it is completing the crossing, there is no advantage.',
      image: 'Fire over water: the image of the condition before completion. The seeker is careful in differentiating things so each finds its proper place.',
      guidance: 'The grand work is nearly finished, but the final steps demand the greatest reverence. Do not rush the conclusion; maintain absolute focus until the shore is reached.',
    ),
  ];

  static Hexagram resolveHexagram(List<int> lines) {
    for (final hex in primaryHexagrams) {
      if (hex.lines.length == lines.length) {
        bool match = true;
        for (int i = 0; i < 6; i++) {
          if (hex.lines[i] != lines[i]) {
            match = false;
            break;
          }
        }
        if (match) return hex;
      }
    }
    // Fallback default: The Creative or The Receptive based on sum
    final sum = lines.fold(0, (a, b) => a + b);
    return sum >= 3 ? primaryHexagrams[0] : primaryHexagrams[1];
  }
}
