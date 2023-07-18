import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/utils/colors.dart';
import '../../domain/entity/answer.dart';
import '../../domain/entity/question.dart';
import '../../domain/entity/user_profile.dart';
import '../../domain/entity/vote.dart';
import '../widget/question_card.dart';
import 'ask_question.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Question> questions = [
    Question(
      isAnonymous: false,
      discussions: [],
      questionId: '1',
      createdAt: DateTime.now(),
      title: 'What is the capital of France?',
      description: 'I am curious to know the capital city of France.',
      imageUrl:
          'https://media.istockphoto.com/id/802362348/photo/church-candles-burn-in-the-church.jpg?s=612x612&w=0&k=20&c=fXV1cFjlDZ9WjiZjn4JCAXXqTY-N-Md1gehR47GII7g=',
      updatedAt: DateTime.now(),
      isClosed: false,
      vote: Vote(
        voteId: '1',
        createdAt: DateTime.now(),
        upvote: 10,
        downvote: 2,
      ),
      numberOfViews: 100,
      answers: [
        Answer(
          answerId: 1,
          createdAt: DateTime.now(),
          userId: 'user1',
          updatedAt: DateTime.now(),
          description: 'The capital of France is Paris.',
          vote: Vote(
            voteId: '2',
            createdAt: DateTime.now(),
            upvote: 5,
            downvote: 1,
          ),
          imageUrl: "",
          questionId: '1',
          isAnsweredForUser: false,
        ),
      ],
      userProfile: UserProfile(
        userProfileId: 1,
        createdAt: DateTime.now(),
        userId: 'user1',
        bio: 'I love traveling and exploring new cultures.',
        profilePicture: '',
        fullName: 'Piohn Doe',
        followers: 'user2',
        following: 'user3',
      ),
    ),
    Question(
      isAnonymous: false,
      discussions: [],
      questionId: '2',
      createdAt: DateTime.now(),
      title:
          'What are some good coding resources I heard that if the text is too long it will be trimmed and I want to make sure that?',
      description: 'I want to learn coding and looking for recommendations.',
      imageUrl: "",
      updatedAt: DateTime.now(),
      isClosed: false,
      vote: Vote(
        voteId: '3',
        createdAt: DateTime.now(),
        upvote: 8,
        downvote: 3,
      ),
      numberOfViews: 50,
      answers: [],
      userProfile: UserProfile(
        userProfileId: 2,
        createdAt: DateTime.now(),
        userId: 'user2',
        bio: 'Passionate about technology and programming.',
        profilePicture: '',
        fullName: 'Nane Smith',
        followers: 'user1',
        following: '',
      ),
    ),
    Question(
      isAnonymous: true,
      discussions: [],
      questionId: '3',
      createdAt: DateTime.now(),
      title: 'What is the best book for learning Python?',
      description:
          'I want a recommendation for a beginner-friendly Python book.I want a recommendation for a beginner-friendly Python book. I want a recommendation for a beginner-friendly Python book.I want a recommendation for a beginner-friendly Python book.',
      imageUrl:
          'https://i.pinimg.com/550x/f0/44/27/f04427c1c01dbaa5d0bdfb6d90db06b9.jpg',
      updatedAt: DateTime.now(),
      isClosed: true,
      vote: Vote(
        voteId: '4',
        createdAt: DateTime.now(),
        upvote: 15,
        downvote: 0,
      ),
      numberOfViews: 80,
      answers: [
        Answer(
          answerId: 2,
          createdAt: DateTime.now(),
          userId: 'user3',
          updatedAt: DateTime.now(),
          description:
              'I highly recommend "Python Crash Course" by Eric Matthes.',
          vote: Vote(
            voteId: '5',
            createdAt: DateTime.now(),
            upvote: 10,
            downvote: 0,
          ),
          imageUrl: "",
          questionId: '3',
          isAnsweredForUser: true,
        ),
        Answer(
          answerId: 3,
          createdAt: DateTime.now(),
          userId: 'user4',
          updatedAt: DateTime.now(),
          description:
              'Another good book is "Automate the Boring Stuff with Python" by Al Sweigart.',
          vote: Vote(
            voteId: '6',
            createdAt: DateTime.now(),
            upvote: 7,
            downvote: 2,
          ),
          imageUrl: "",
          questionId: '3',
          isAnsweredForUser: false,
        ),
      ],
      userProfile: UserProfile(
        userProfileId: 3,
        createdAt: DateTime.now(),
        userId: 'user3',
        bio: 'Python enthusiast and software developer.',
        profilePicture:
            'https://i.pinimg.com/550x/f0/44/27/f04427c1c01dbaa5d0bdfb6d90db06b9.jpg',
        fullName: 'David Johnson',
        followers: 'user2',
        following: 'user4',
      ),
    ),
  ];
  var tabIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  
  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(backgroundColor: white, actions: [
        InkWell(
          onTap: (){
            showDialog(context: context, builder: (context) => AskQuestion());


          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
            decoration: BoxDecoration(
                color: secondaryColor, borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Text("Ask", style: textTheme.bodySmall!.copyWith(color: white)),
                SizedBox(width: 1.w),
                const Icon(Icons.add_sharp, color: white),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 2.w,
        )
      ]),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                _pageController.animateToPage(0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              },
              child: Text(
                'Questions',
                style: textTheme.bodyLarge!
                    .copyWith(color: tabIndex == 0 ? black : blackTextColor),
              ),
            ),
            TextButton(
              onPressed: () {
                _pageController.animateToPage(1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              },
              child: Text(
                'Posts',
                style: textTheme.bodyLarge!
                    .copyWith(color: tabIndex == 1 ? black : blackTextColor),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 2.w),
              child: Container(
                width: MediaQuery.of(context).size.width / 2 - 10,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: tabIndex == 0 ? black : blackTextColor,
                      width: tabIndex == 0 ? 2.0 : 1,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 2.w),
              child: Container(
                width: MediaQuery.of(context).size.width / 2 - 10,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: tabIndex == 1 ? black : blackTextColor,
                      width: tabIndex == 1 ? 2.0 : 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 1.h,
        ),
        Expanded(
          child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  tabIndex = index;
                });
              },
              children: [
                Flex(direction: Axis.vertical, children: [
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: questions.length,
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: QuestionCard(questions[index]),
                            )),
                  ),
                ]),
                Flex(
                  direction: Axis.vertical,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: questions.length,
                          itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: QuestionCard(questions[index]),
                              )),
                    ),
                  ],
                ),
              ]),
        )
      ]),
    );
  }

  
}
