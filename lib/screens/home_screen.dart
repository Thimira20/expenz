import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/expence_model.dart';
import 'package:flutter_application_1/models/income_model.dart';
import 'package:flutter_application_1/services/user_details_service.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/widgets/expence_card.dart';
import 'package:flutter_application_1/widgets/income_exp_chip.dart';
import 'package:flutter_application_1/widgets/line_chart.dart';

class HomeScreen extends StatefulWidget {
  final List<Expense> expensesList;
  final List<Income> incomesList;
  const HomeScreen({
    super.key,
    required this.expensesList,
    required this.incomesList,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //to store the username and email
  String username = "";
  String email = "";
  double expenseTotal = 0;
  double incomeTotal = 0;

  @override
  //state life  cycle method
  void initState() {
    //to initialize the state
    //get the user details from the shared preferences
    UserService.getUserDetails().then((value) {
      //check if the user details are not null
      if (value['username'] != null && value['email'] != null) {
        //set the username and email to the state
        setState(() {
          username = value['username']!;
          email = value['email']!;
        });
      }
    });

    setState(() {
      for (var i = 0; i < widget.expensesList.length; i++) {
        expenseTotal += widget.expensesList[i].amount;
      }
      for (var k = 0; k < widget.incomesList.length; k++) {
        incomeTotal += widget.incomesList[k].amount;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //bg colour container
              Container(
                //
                height: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  color: kMainColor.withOpacity(0.15), //
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(kDefalutPadding),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: kMainColor,
                              border: Border.all(
                                color: kMainColor,
                                width: 3,
                              ),
                            ),
                            child: ClipRRect(
                              //to round the image
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                "assets/images/user.jpg",
                                width: 50,
                                fit: BoxFit
                                    .cover, //to fit the image to the container
                              ),
                            ),
                          ),
                          Text(
                            "Welcome $username",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications,
                              color: kMainColor,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IncomeExpenceChip(
                            title: "Income",
                            amount: incomeTotal,
                            bgColor: kGreen,
                            imageUrl: "assets/images/income.png",
                          ),
                          IncomeExpenceChip(
                            title: "Expense",
                            amount: expenseTotal,
                            bgColor: kRed,
                            imageUrl: "assets/images/expense.png",
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              //spend frequency

              const Padding(
                padding: EdgeInsets.all(kDefalutPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Spend Frequency",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    //chart to show the spend frequency and the amount spent in a chart using fl_chart

                    LineChartSample()
                  ],
                ),
              ),

              //recent transactions
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefalutPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Recent Transactions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //show the recent transactions
                    Column(
                      // Wrap with Column to ensure proper layout
                      children: [
                        widget.expensesList.isEmpty
                            ? const Text(
                                "No expenses added yet, add some expenses to see here",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: kGrey,
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap:
                                    true, // Set shrinkWrap to true to allow the ListView to adapt to its content size
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.expensesList.length,
                                itemBuilder: (context, index) {
                                  final expense = widget.expensesList[index];
                                  return ExpenceCard(
                                    title: expense.title,
                                    date: expense.date,
                                    amount: expense.amount,
                                    category: expense.category,
                                    description: expense.description,
                                    createdAt: expense.time,
                                  );
                                },
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
