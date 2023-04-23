import 'package:flutter/material.dart';
import 'package:houzeo_sample/constants/constant.dart';
import 'package:houzeo_sample/helper/detabase_helper.dart';
import 'package:houzeo_sample/model/user_model.dart';
import 'package:houzeo_sample/widget/loading_indicator.dart';

class UserProvider with ChangeNotifier {
  bool isLoading = false;
  List<User> userList = [];
  List<User> favouriteList = [];
  final DataBaseHelper _dataBaseHelper = DataBaseHelper();
  final Constants _constants = Constants();

  getAllContact() async {
    try {
      isLoading = true;
      notifyListeners();
      userList = await _dataBaseHelper.getAllUser() ?? [];
    } catch (e) {
      _constants.showToast(message: "Something went wrong");
    }
    isLoading = false;
    notifyListeners();
  }

  getFavouritesContact() async {
    try {
      isLoading = true;
      notifyListeners();
      favouriteList = await _dataBaseHelper.getFavouritesContact() ?? [];
    } catch (e) {
      _constants.showToast(message: "Something went wrong");
    }
    isLoading = false;
    notifyListeners();
  }

  saveContact({required User user, required BuildContext context}) async {
    try {
      isLoading = true;
      notifyListeners();
      String? id = await _dataBaseHelper.saveUser(user: user);
      if (id != null) {
        userList.add(User(
            lastName: user.lastName,
            userId: id,
            phone: user.phone,
            firstName: user.firstName,
            email: user.email,
            isFavourite: user.isFavourite));
      }
    } catch (e) {
      _constants.showToast(message: "Something went wrong");
    }
    isLoading = false;
    notifyListeners();
    Navigator.of(context).pop();
  }

  updateContact({required User user, required BuildContext context}) async {
    try {
      isLoading = true;
      notifyListeners();
      await _dataBaseHelper.updateUser(user: user);
      for (int i = 0; i < userList.length; i++) {
        if (userList[i].userId == user.userId) {
          userList[i] = user;
        }
      }
      notifyListeners();
    } catch (e) {
      _constants.showToast(message: "Something went wrong");
    }
    isLoading = false;
    notifyListeners();
    Navigator.of(context).pop();
  }

  updateFavourite({required User user, required BuildContext context}) async {
    try {
      isLoading = true;
      notifyListeners();
      await _dataBaseHelper.updateUser(user: user);
      if (user.isFavourite == true) {
        _constants.showToast(message: "Contact added to favourite");
      } else {
        _constants.showToast(message: "Contact removed to favourite");
      }
      for (int i = 0; i < favouriteList.length; i++) {
        if (favouriteList[i].userId == user.userId) {
          favouriteList[i] = user;
        }
      }
      for (int i = 0; i < userList.length; i++) {
        if (userList[i].userId == user.userId) {
          userList[i] = user;
        }
      }
      notifyListeners();
    } catch (e) {
      _constants.showToast(message: "Something went wrong");
    }
    isLoading = false;
    notifyListeners();
  }

  deleteContact({required User user, required BuildContext context}) async {
    try {
      isLoading = true;
      notifyListeners();
      showDialog(
          context: context,
          builder: (builder) {
            return const LoadingIndicator();
          });

      await _dataBaseHelper.deleteUser(user: user);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      _constants.showToast(message: "Contact deleted successfully");

      userList.removeWhere((element) => element.userId == user.userId);
      notifyListeners();
    } catch (e) {
      _constants.showToast(message: "Something went wrong");
    }
    isLoading = false;
    notifyListeners();
  }
}
