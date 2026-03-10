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
"number": 2,
"name": "고위 여사제 (The High Priestess)",
"storytelling": "고위 여사제는 신비로운 지혜와 직관을 상징합니다. 그녀는 두 개의 기둥 사이에 앉아 베일 뒤에 숨겨진 진실을 응시하며, 내면의 소리에 귀 기울이라고 속삭입니다. 당신은 겉으로 드러나지 않는 깊은 통찰력과 강한 직감을 가지고 있습니다. 이 카드는 당신이 외부의 소란에서 벗어나 자신의 내면세계와 연결될 때 가장 큰 지혜를 얻을 수 있음을 나타냅니다. 고요함 속에서 당신의 직관은 빛을 발하고, 중요한 결정을 내리는 데 필요한 비밀스러운 지식을 알려줄 것입니다.",
"image": "2_high_preienstess.png"
},*/
