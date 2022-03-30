import 'package:flutter/material.dart';
import 'package:jsondemoproject/constant/base_key.dart';
import 'package:jsondemoproject/model/Field.dart';
import 'package:jsondemoproject/model/post_dto.dart';
import 'package:jsondemoproject/model/user_body.dart';
import 'package:jsondemoproject/network/http_client.dart';
import 'package:jsondemoproject/utility/InternetUtil.dart';
import 'package:jsondemoproject/utility/LoadingIndicator.dart';
import 'package:jsondemoproject/utility/common_exception.dart';
import 'package:jsondemoproject/utility/ui_util.dart';

/**
 * Created by Amit Rawat on 3/30/2022.
 */
class NewPostPage extends StatefulWidget {
  const NewPostPage({Key? key, this.title, this.postDTO}) : super(key: key);
  final String? title;
  final PostDTO? postDTO;

  @override
  State<NewPostPage> createState() => _NewPostPage();
}

class _NewPostPage extends State<NewPostPage> {
  var titleController = TextEditingController();
  var bodyController = TextEditingController();
  List<Field> fieldList = [];
  bool loading = false;
  Field? selectedUser;
  bool buttonLoading = false;
  var headerTitle = "Create new Post";

  @override
  void initState() {
    super.initState();

    if (isEditPost()) {
      headerTitle = "Edit Post";
      titleController.text = widget.postDTO!.title.toString();
      bodyController.text = widget.postDTO!.body.toString();
    } else {
      getUser();
    }
  }

  void getUser() {
    loadingData(true);
    HttpObj.instance.getClient().getUser().then((it) {
      loadingData(false);
      setState(() {
        for (var item in it) {
          fieldList.add(Field(item.id, item.name));
        }
      });
    }).catchError((Object obj) {
      loadingData(false);
      CommonException().exception(context, obj);
    });
  }

  void loadingData(bool load) {
    if (mounted) {
      setState(() {
        loading = load;
      });
    }
  }

  void btnLoading(bool load) {
    if (mounted) {
      setState(() {
        buttonLoading = load;
      });
    }
  }

  bool isEditPost() {
    if (widget.postDTO == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: loading
            ? LoadingIndicator()
            : SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                headerTitle,
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: [
                                dropDown(),
                                UIUtil.makeInputTitle(titleController,
                                    label: "Title"),
                                UIUtil.makeInputTitle(bodyController,
                                    label: "Body"),
                              ],
                            ),
                          ),
                          buttonLoading
                              ? LoadingIndicator()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Container(
                                    padding:
                                        const EdgeInsets.only(top: 3, left: 3),
                                    child: MaterialButton(
                                      minWidth: double.infinity,
                                      height: 60,
                                      onPressed: () {
                                        if (titleController.text.isEmpty) {
                                          UIUtil.toastPrint(
                                              "Please Enter title ");
                                          return;
                                        }
                                        if (bodyController.text.isEmpty) {
                                          UIUtil.toastPrint(
                                              "Please Enter Body ");
                                          return;
                                        }
                                        InternetUtil.check().then((value) => {
                                              if (value)
                                                {
                                                  if (isEditPost())
                                                    {EditNewPost()}
                                                  else
                                                    {createNewPost()}
                                                }
                                              else
                                                {
                                                  UIUtil.toastPrint(BaseKey
                                                      .Check_your_internet_connection)
                                                }
                                            });
                                      },
                                      color: Colors.redAccent,
                                      textColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: const Text(
                                        "Sumit",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  dropDown() {
    if (fieldList == null) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isEditPost()) ...[
          /*  UIUtil.getText("Id : " + widget.postDTO!.id.toString()),
          UIUtil.height(5),*/
          UIUtil.getText("User : " + widget.postDTO!.authorName.toString(), 18),
          UIUtil.height(5),
        ],
        if (!isEditPost()) ...[
          UIUtil.getText("Users ", 15),
          UIUtil.height(5),
          DropdownButtonFormField<Field>(
            hint: const Text("Select user"),
            menuMaxHeight: 300,

            decoration: const InputDecoration(  isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15.0),
              border: OutlineInputBorder(),
            ),
            value: selectedUser,
            onChanged: (Field? newValue) {
              setState(() {
                selectedUser = newValue;
              });
            },
            items: fieldList.map((Field user) {
              return DropdownMenuItem<Field>(
                value: user,
                child: Text(
                  user.name!,
                  style: const TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
          ),
          UIUtil.height(5),
        ],
      ],
    );
  }

  void createNewPost() {
    if (selectedUser == null) {
      UIUtil.toastPrint("Please Select User ");
      return;
    }
    var user = UserBody(
        titleController.text, bodyController.text, null, selectedUser!.id);

    btnLoading(true);
    HttpObj.instance.getClient().creatingNew(user).then((it) {
      btnLoading(false);
      setState(() {
        UIUtil.toastPrint("Post successfully Created ");
      });
    }).catchError((Object obj) {
      btnLoading(false);
      CommonException().exception(context, obj);
    });
  }

  void EditNewPost() {
    var user = UserBody(titleController.text, bodyController.text, null,
        widget.postDTO!.userId);
    btnLoading(true);
    HttpObj.instance.getClient().updating(widget.postDTO!.id!, user).then((it) {
      btnLoading(false);
      setState(() {
        UIUtil.toastPrint("Post Edit successfully ");
      });
    }).catchError((Object obj) {
      btnLoading(false);
      CommonException().exception(context, obj);
    });
  }
}
