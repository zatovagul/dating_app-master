import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'screens/add_feedback_screen/add_feedback.dart';
import 'screens/global_search_screen/global_search.dart';
import 'screens/messages/message.dart';
import 'screens/profile_screen/edit_social_networks.dart';

abstract class AppStatesInterface extends GetxController {
  RxString profilePhoto;
  RxBool isMaximizedContainer;

  List<PopularTag> popularTags;
  RxInt firstPages;
  Rx<RxList<FilledTag>> filledTags;
  Rx<RxList<FilledTagSearch>> filledSearchTags;
  Rx<RxSet<FilledCountrySearch>> filledSearchCountry;
  Rx<RxSet<FilledCitySearch>> filledSearchCity;
  Rx<List<SocialNetworksBlock>> socialNetworksList;
  Rx<List<SocialNetworksBlockGlobal>> socialNetworksListGlobal;
  Rx<List<Message>> messages;
}

class AppStates extends AppStatesInterface {
  var profilePhoto = 'assets/images/top_user1.png'.obs;
  var isMaximizedContainer = false.obs;
  var popularTags = [
    PopularTag(
      tag: 'love',
    ),
    PopularTag(
      tag: 'phone',
    ),
    PopularTag(
      tag: 'example',
    ),
    PopularTag(
      tag: 'sea',
    ),
    PopularTag(
      tag: 'ocean',
    ),
  ].obs;

  var firstPages = 0.obs;

  var filledTags = RxList<FilledTag>().obs;
  var filledSearchTags = RxList<FilledTagSearch>().obs;
  var filledSearchCountry = RxSet<FilledCountrySearch>().obs;
  var filledSearchCity = RxSet<FilledCitySearch>().obs;
  Rx<List<SocialNetworksBlock>> socialNetworksList = Rx<List<SocialNetworksBlock>>([SocialNetworksBlock(index: 0)]);

  Rx<List<SocialNetworksBlockGlobal>> socialNetworksListGlobal = Rx<List<SocialNetworksBlockGlobal>>([SocialNetworksBlockGlobal(index: 0)]);

  Rx<List<Message>> messages = Rx<List<Message>>(
    [
      Message(
        text: 'Hi, how are you?',
        toMe: true,
        dateTime: DateTime(2020, 11, 5, 13, 30),
      ),
    ],
  );
}

class AppStatesGlobalSearch extends AppStatesInterface {
  var profilePhoto = 'assets/images/top_user1.png'.obs;
  var isMaximizedContainer = false.obs;
  var popularTags = [
    PopularTag(
      tag: 'love',
    ),
    PopularTag(
      tag: 'phone',
    ),
    PopularTag(
      tag: 'example',
    ),
    PopularTag(
      tag: 'sea',
    ),
    PopularTag(
      tag: 'ocean',
    ),
  ].obs;

  var firstPages = 0.obs;

  var filledTags = RxList<FilledTag>().obs;
  var filledSearchTags = RxList<FilledTagSearch>().obs;
  var filledSearchCountry = RxSet<FilledCountrySearch>().obs;
  var filledSearchCity = RxSet<FilledCitySearch>().obs;
  Rx<List<SocialNetworksBlock>> socialNetworksList = Rx<List<SocialNetworksBlock>>([SocialNetworksBlock(index: 0)]);

  Rx<List<SocialNetworksBlockGlobal>> socialNetworksListGlobal = Rx<List<SocialNetworksBlockGlobal>>([SocialNetworksBlockGlobal(index: 0)]);

  Rx<List<Message>> messages = Rx<List<Message>>(
    [
      Message(
        text: 'Hi, how are you?',
        toMe: true,
        dateTime: DateTime(2020, 11, 5, 13, 30),
      ),
    ],
  );
}
