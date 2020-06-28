import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:walkingapp/config/initialization.dart';
import 'package:walkingapp/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;

  FirebaseUser _user;

  FirebaseUser get user => _user;

  UserData _userData;

  UserData get userData => _userData;

  Status _status = Status.Uninitialized;

  Status get status => _status;

  bool get isMailExist => _isMailExist;

  set isMailExist(bool value) {
    _isMailExist = value;
  }

  bool _isLogin = false;

  bool get isLogin => _isLogin;
  bool _isMailExist = false;
  bool _loginGoogle = false;

  bool get loginGoogle => _loginGoogle;

  set loginGoogle(bool value) {
    _loginGoogle = value;
  }

  Firestore _firestore = Firestore.instance;

  //GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['profile', 'account']);

  GoogleSignInAccount account;

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  //--------------------Đăng Nhập-----------------------------

  Future<bool> signIn(String account, String password, BuildContext context, GlobalKey<ScaffoldState> _key) {
    Firestore.instance
        .collection('users')
        .where("account", isEqualTo: account)
        .snapshots()
        .listen((data) {
      if (data.documents.length != 0) {
        print("đúng tài khoản");
        Firestore.instance
            .collection('users')
            .where("pass", isEqualTo: password)
            .snapshots()
            .listen((data) async {
          if (data.documents.length != 0) {
            print("đúng pass");
            Firestore.instance
                .collection('users')
                .where("account", isEqualTo: account)
                .snapshots()
                .listen((data) => data.documents.forEach((doc) {
                      _userData = UserData.formSnapShot(doc);
                      notifyListeners();
                    }));
            Navigator.pushNamed(context, '/main');
          } else {
            _key.currentState.showSnackBar(SnackBar(
                content: Text("Tài khoản hoặc mật khẩu không đúng")));
            print("đăng nhập không thành công");
          }
        });
      }
    });
  }

  Future<bool> loginWithGoogle() async {
    try {
      _loginGoogle = true;
      notifyListeners();
      _status = Status.Authenticating;
      notifyListeners();
      account = await googleSignIn.signIn();
      notifyListeners();
      Firestore.instance
          .collection('users')
          .where("account", isEqualTo: account.email)
          .snapshots()
          .listen((data) async {
        if (data.documents.length == 0) {
          await _auth
              .signInWithCredential(GoogleAuthProvider.getCredential(
            idToken: (await account.authentication).idToken,
            accessToken: (await account.authentication).accessToken,
          ))
              .then((user) {
            _isMailExist = false;
            notifyListeners();
            _status = Status.Unauthenticated;
            notifyListeners();
          });
        } else {
          await _auth
              .signInWithCredential(GoogleAuthProvider.getCredential(
            idToken: (await account.authentication).idToken,
            accessToken: (await account.authentication).accessToken,
          ))
              .then((user) {
            Firestore.instance
                .collection('users')
                .where("account", isEqualTo: account.email)
                .snapshots()
                .listen((data) => data.documents.forEach((doc) {
                      _userData = UserData.formSnapShot(doc);
                      notifyListeners();
                      _isMailExist = true;
                      notifyListeners();
                    }));
          });
        }
        return true;
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  //-------------------Đăng Ký-------------------------------------

  Future<bool> signUp(String name, String account, String password,
      String phone, String weight, String height, String gender) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInAnonymously().then((user) {
        _firestore.collection('users').document(user.user.uid).setData({
          'name': name,
          'account': account,
          'pass': password,
          'uid': user.user.uid,
          'phone': phone,
          'weight': weight,
          'height': height,
          'gender': gender,
          'url_avt':
              'https://firebasestorage.googleapis.com/v0/b/walking-app-1eadb.appspot.com/o/background.jpg?alt=media&token=a122f72e-73fa-4743-9090-0e0eb40711e9',
          'url_cover':
              'https://firebasestorage.googleapis.com/v0/b/walking-app-1eadb.appspot.com/o/background_profile.jpg?alt=media&token=d1f8afc3-c99d-40bd-a4d7-ba8b87ddc0a9'
        });
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      //print(e.toString());
      return false;
    }
  }

  Future<bool> signUp_Google(String name, String email, String phone,
      String weight, String height, String gender) async {
    try {
      _firestore.collection('users').document(account.id).setData({
        'name': name,
        'account': email,
        'uid': account.id,
        'phone': phone,
        'weight': weight,
        'height': height,
        'gender': gender,
        'url_avt':
            'https://firebasestorage.googleapis.com/v0/b/walking-app-1eadb.appspot.com/o/background.jpg?alt=media&token=a122f72e-73fa-4743-9090-0e0eb40711e9',
        'url_cover':
            'https://firebasestorage.googleapis.com/v0/b/walking-app-1eadb.appspot.com/o/background_profile.jpg?alt=media&token=d1f8afc3-c99d-40bd-a4d7-ba8b87ddc0a9'
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      //print(e.toString());
      return false;
    }
  }

  //-------------------Đăng Xuất--------------------
  Future signOut() async {
    _auth.signOut();

    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  //-------------------------Cập nhật dữ liệu-----------------

  //------Cập nhật thông tin cơ bản--------------------
  Future updateDataUser(String id, String name, String phone, String weight,
      String height) async {
    _firestore.collection('users').document(id).updateData(
        {'name': name, 'phone': phone, 'weight': weight, 'height': height});
    notifyListeners();
  }

  //------------Cập nhật Avatar-----------------
  Future updateAvt(String id, String urlAvt) async {
    _firestore.collection('users').document(id).updateData({
      'url_avt': urlAvt,
    });
    notifyListeners();
  }

  //---------------Cập nhật ảnh bìa---------------------
  Future updateCover(String id, String urlCover) async {
    _firestore.collection('users').document(id).updateData({
      'url_cover': urlCover,
    });
    notifyListeners();
  }

  //------------------------Tạo dữ liệu mới ----------------------
  Future setDataCount(String idUser, int step, double distance, double calories,
      String time, String date) async {
    _firestore.collection('data_count').document().setData({
      'uid': idUser,
      'step': step.toString(),
      'time': time,
      'distance': distance.toString(),
      'calories': calories.toString(),
      'date': date,
    });
    notifyListeners();
  }

  Future<void> _onStateChanged(FirebaseUser user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  Future<void> setName(String name) {
    _userData.name = name;
    notifyListeners();
  }

  Future<void> setPhone(String phone) {
    _userData.phone = phone;
    notifyListeners();
  }

  Future<void> setHeight(String height) {
    _userData.height = height;
    notifyListeners();
  }

  Future<void> setWeight(String weight) {
    _userData.weight = weight;
    notifyListeners();
  }

  Future<void> setUrlAvt(String urlAvt) {
    _userData.urlAvt = urlAvt;
    notifyListeners();
  }

  Future<void> setUrlCover(String urlCover) {
    _userData.urlCover = urlCover;
    notifyListeners();
  }

  Future<bool> checkAccount(String account, String password) async {
    Firestore.instance
        .collection('users')
        .where("account", isEqualTo: account)
        .snapshots()
        .listen((data) {
      if (data.documents.length != 0) {
        print("đúng tài khoản");
        Firestore.instance
            .collection('users')
            .where("pass", isEqualTo: password)
            .snapshots()
            .listen((data) {
          if (data.documents.length != 0) {
            print("đúng pass");
            Firestore.instance
                .collection('users')
                .where("account", isEqualTo: account)
                .snapshots()
                .listen((data) => data.documents.forEach((doc) {
                      _userData = UserData.formSnapShot(doc);
                      notifyListeners();
                    }));
          }
        });
      }
    });
    return true;
  }
}
