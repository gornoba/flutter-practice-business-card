import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController _introduceController = TextEditingController();
  bool isEditMode = false; // 자기소개 수정모드

  @override
  void initState() {
    super.initState();

    getIntroduceData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.accessibility_new,
              color: Colors.black,
              size: 32,
            ),
            onPressed: () {},
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            '처음 만드는 Flutter 앱~! Business Card ',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(16),
                width: double.infinity,
                height: 270,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/business-card-design.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // 이름 섹션,
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 150,
                      child: Text(
                        '이름',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '임현후',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // 나이 섹션
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 150,
                      child: Text(
                        '나이',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '40',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // 취미 섹션
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 150,
                      child: Text(
                        '취미',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '젤다의전설',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // 직업 섹션
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 150,
                      child: Text(
                        '직업',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '개발자',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // 학력 섹션
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 150,
                      child: Text(
                        '학력',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '세종대학교 졸업',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // MBTI 섹션,
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 150,
                      child: Text(
                        'MBTI',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      'INTJ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // 자기소개 입력필드,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Text(
                      '자기소개',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Icon(
                        Icons.mode_edit,
                        color: isEditMode
                            ? Colors.blueAccent.shade700
                            : Colors.black,
                      ),
                    ),
                    onTap: () async {
                      if (isEditMode) {
                        if (_introduceController.text.isEmpty) {
                          var snackBar = SnackBar(
                            content: Text('자기소개를 입력해주세요'),
                            duration: Duration(seconds: 2),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        } else {
                          var sharedRef = await SharedPreferences.getInstance();
                          sharedRef.setString(
                              'introduce', _introduceController.text);
                        }
                      }

                      setState(
                        () {
                          isEditMode = !isEditMode;
                        },
                      );
                    },
                  ),
                ],
              ),

              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: TextField(
                  enabled: isEditMode,
                  maxLines: 5,
                  controller: _introduceController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xffd9d9d9),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Future<void> getIntroduceData() async {
    var sharedRef = await SharedPreferences.getInstance();
    var introduce = sharedRef.getString('introduce');
    _introduceController.text = introduce ?? '';
  }
}
