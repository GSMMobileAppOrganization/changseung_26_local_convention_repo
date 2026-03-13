class CardModel {
  final int number;
  final String name;
  final String storytelling;
  final String image;

  CardModel({
    required this.number,
    required this.name,
    required this.storytelling,
    required this.image,
  });

  factory CardModel.fromJson(Map json) => CardModel(
    number: json["number"],
    name: json["name"],
    storytelling: json["storytelling"],
    image: json["image"],
  );
}

/*
{
"number": 1,
"name": "마법사 (The Magician)",
"storytelling": "마법사는 무한한 잠재력과 창조적인 힘을 상징합니다. 그는 눈앞의 도구들(지팡이, 컵, 검, 펜타클)을 자유자재로 다루며, 자신의 의지를 현실로 구현할 준비가 되어 있습니다. 마치 백지 위에 그림을 그리기 시작하는 예술가처럼, 당신은 삶을 새롭게 시작하고, 원하는 것을 만들어낼 능력을 타고났습니다. 마법사는 당신이 아이디어를 현실로 바꾸고, 새로운 시작을 주도할 수 있는 힘을 가지고 있음을 알려줍니다. 당신의 말과 행동에는 큰 영향력이 있으니, 의식적으로 긍정적인 에너지를 창조하는 데 집중하세요.",
"image": "1_magician.png"
},
{
"number": 2,
"name": "고위 여사제 (The High Priestess)",
"storytelling": "고위 여사제는 신비로운 지혜와 직관을 상징합니다. 그녀는 두 개의 기둥 사이에 앉아 베일 뒤에 숨겨진 진실을 응시하며, 내면의 소리에 귀 기울이라고 속삭입니다. 당신은 겉으로 드러나지 않는 깊은 통찰력과 강한 직감을 가지고 있습니다. 이 카드는 당신이 외부의 소란에서 벗어나 자신의 내면세계와 연결될 때 가장 큰 지혜를 얻을 수 있음을 나타냅니다. 고요함 속에서 당신의 직관은 빛을 발하고, 중요한 결정을 내리는 데 필요한 비밀스러운 지식을 알려줄 것입니다.",
"image": "2_high_preienstess.png"
},*/
