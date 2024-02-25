import 'package:fuiopia/configs/config.dart';
import 'package:fuiopia/constants/constants.dart';
import 'package:fuiopia/presentation/screens/search/bloc/bloc.dart';
import 'package:fuiopia/presentation/screens/search/widgets/search_bar.dart'
    as sb;
import 'package:fuiopia/presentation/widgets/custom_widgets.dart';
import 'package:fuiopia/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchControler = TextEditingController();

  @override
  void dispose() {
    searchControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc()..add(OpenScreen()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              sb.SearchBar(searchController: searchControler),
              Expanded(child: _buildContent()),
            ],
          ),
        ),
      ),
    );
  }

  _buildContent() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is Searching) {
          return const Loading();
        }
        if (state is SuggestionLoaded) {
          return _buildSuggestion(state);
        }
        if (state is ResultsLoaded) {
          return _buildResults(state);
        }
        if (state is SearchFailure) {
          return const Center(child: Text("Load Failure"));
        }
        return const Center(child: Text("Something went wrongs."));
      },
    );
  }

  _buildSuggestion(SuggestionLoaded state) {
    Widget recentSearchWidget = Container();
    Widget hotKeywordsWidget = Container();
    if (state.recentKeywords.isNotEmpty) {
      recentSearchWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translate.of(context).translate("recent_search"),
            style: FONT_CONST.BOLD_DEFAULT_26,
          ),
          Wrap(
            children: List.generate(state.recentKeywords.length, (index) {
              return _buildSuggestionItem(state.recentKeywords[index]);
            }),
          ),
        ],
      );
    }
    if (state.hotKeywords.isNotEmpty) {
      hotKeywordsWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translate.of(context).translate("hot_keywords"),
            style: FONT_CONST.BOLD_DEFAULT_26,
          ),
          Wrap(
            children: List.generate(state.hotKeywords.length, (index) {
              return _buildSuggestionItem(state.hotKeywords[index]);
            }),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(SizeConfig.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          recentSearchWidget,
          SizedBox(height: SizeConfig.defaultSize * 3),
          hotKeywordsWidget
        ],
      ),
    );
  }

  _buildResults(ResultsLoaded state) {
    var results = state.results;
    if (results.isNotEmpty) {
      return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultPadding),
        physics: const BouncingScrollPhysics(),
        itemCount: results.length,
        itemBuilder: (context, index) {
          return CustomListTile(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRouter.DETAIL_PRODUCT,
                arguments: results[index],
              );
            },
            leading: ShimmerImage(imageUrl: results[index].images[0]),
            title: results[index].name,
            subTitle: Text(results[index].price.toPrice()),
          );
        },
      );
    } else {
      return Center(
        child: Image.asset(
          IMAGE_CONST.NOT_FOUND,
          width: SizeConfig.defaultSize * 25,
          height: SizeConfig.defaultSize * 25,
        ),
      );
    }
  }

  _buildSuggestionItem(String keyword) {
    return GestureDetector(
      onTap: () {
        searchControler.text = keyword;
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultSize * 3,
          vertical: SizeConfig.defaultSize * 1.5,
        ),
        margin: EdgeInsets.only(
          top: SizeConfig.defaultSize,
          right: SizeConfig.defaultSize,
        ),
        decoration: BoxDecoration(
          color: COLOR_CONST.primaryColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          keyword,
          style: FONT_CONST.BOLD_DEFAULT_16,
        ),
      ),
    );
  }
}
