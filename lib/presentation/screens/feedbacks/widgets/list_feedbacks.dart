import 'package:fuiopia/presentation/screens/feedbacks/bloc/bloc.dart';
import 'package:fuiopia/presentation/widgets/others/loading.dart';
import 'package:fuiopia/presentation/widgets/single_card/feedback_card.dart';
import 'package:fuiopia/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListFeedbacks extends StatelessWidget {
  const ListFeedbacks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackBloc, FeedbackState>(
      builder: (context, state) {
        if (state is FeedbacksLoaded) {
          var feedbacks = state.feedbacks;
          return feedbacks.isNotEmpty
              ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: feedbacks.length,
                  itemBuilder: (context, index) {
                    return FeedbackCard(feedBack: feedbacks[index]);
                  },
                )
              : Center(
                  child: Text(Translate.of(context).translate("no_feedbacks")),
                );
        }
        if (state is FeedbacksLoading) {
          return const Loading();
        }
        if (state is FeedbacksLoadFailure) {
          return const Center(child: Text("Load Failure"));
        }

        return const Center(child: Text("Something went wrongs."));
      },
    );
  }
}
