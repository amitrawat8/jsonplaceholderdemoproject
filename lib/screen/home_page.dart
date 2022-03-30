import 'dart:core';

import 'package:flutter/material.dart';
import 'package:jsondemoproject/constant/base_key.dart';
import 'package:jsondemoproject/model/post_dto.dart';
import 'package:jsondemoproject/network/http_client.dart';
import 'package:jsondemoproject/utility/InternetUtil.dart';
import 'package:jsondemoproject/utility/LoadingIndicator.dart';
import 'package:jsondemoproject/utility/common_exception.dart';
import 'package:jsondemoproject/utility/ui_util.dart';

import '../model/user_dto.dart';

/**
 * Created by Amit Rawat on 3/30/2022.
 */
class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  bool loading = false;
  List<PostDTO> post = [];

  int limit = 15;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  int arraysize = 0;
  bool deleteLoading = false;
  int indexDelete = 0;
  List<UserDTO> user = [];
  var msg = "Something Went Wrong";

  @override
  void initState() {
    super.initState();
    checkInternet();
    getUser();
  }

  void checkInternet() {
    InternetUtil.check().then((value) => {
          if (value)
            {updateMsg(BaseKey.EMPTY)}
          else
            {updateMsg(BaseKey.Check_your_internet_connection)}
        });
  }

  void updateMsg(String value) {
    if (mounted) {
      setState(() {
        msg = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.text_snippet,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              UIUtil.PostPage(context, null);
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: NotificationListener<ScrollNotification>(
            child: loading ? LoadingIndicator() : setPost(post),
            onNotification: (ScrollNotification scrollInfo) {
              if (_isFirstLoadRunning == true &&
                  _isLoadMoreRunning == false &&
                  _hasNextPage == true &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                _loadMore();
              }
              return false;
            },
          )),
          if (_isLoadMoreRunning == true) UIUtil.loadMoreData(),
          if (_hasNextPage == false) UIUtil.nothingToLoad(),
        ],
      ),
    );
  }

  void loadingData(bool load) {
    if (mounted) {
      setState(() {
        loading = load;
      });
    }
  }

  firstLoading(bool value) {
    if (mounted) {
      setState(() {
        _isFirstLoadRunning = value;
      });
    }
  }

  loadMoreData(bool value) {
    if (mounted) {
      setState(() {
        _isLoadMoreRunning = value;
      });
    }
  }

  void noDataLoadMore(bool value) {
    if (mounted) {
      setState(() {
        _hasNextPage = value;
      });
    }
  }

  void getUser() {
    loadingData(true);
    HttpObj.instance.getClient().getUser().then((it) {
      setState(() {
        user = it;

        getapi();
      });
    }).catchError((Object obj) {
      CommonException().exception(context, obj);
    });
  }

  void getapi() {
    HttpObj.instance.getClient().getListPost(limit).then((it) {
      loadingData(false);
      setState(() {
        firstLoading(true);
        arraysize = it.length;
        for (var item in it) {
          for (var author in user) {
            if (item.userId == author.id) {
              item.authorName = author.name;
              break;
            }
          }
        }
        post.addAll(it);
      });
    }).catchError((Object obj) {
      loadingData(false);
      CommonException().exception(context, obj);
    });
  }

  void _loadMore() async {
    limit = limit + 10;
    loadMoreData(true);
    HttpObj.instance.getClient().getListPost(limit).then((it) {
      loadingData(false);
      if (it.isNotEmpty && it.length > arraysize) {
        setState(() {
          var list = it.sublist(arraysize);
          for (var item in list) {
            for (var author in user) {
              if (item.userId == author.id) {
                item.authorName = author.name;
                break;
              }
            }
          }
          post.addAll(list);
          arraysize = post.length;
        });
      } else {
        noDataLoadMore(false);
      }
      loadMoreData(false);
    }).catchError((Object obj) {
      loadingData(false);
      CommonException().exception(context, obj);
    });
  }

  setPost(List<PostDTO> post) {
    if (post.isEmpty) {
      if (msg.isEmpty) {
        return const Center(
          child: Text(
            "No data Found ",
          ),
        );
      } else {
        return Center(
          child: Text(
            msg,
          ),
        );
      }
    }
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: post.length,
          itemBuilder: (context, index) => ListTile(
                leading: Text("${post[index].id}"),
                subtitle: Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Text("${post[index].authorName}"),
                ),
                title: InkWell(
                  child: Text("${post[index].title}"),
                  onTap: () {
                    UIUtil.readPage(context, post[index]);
                  },
                ),
                trailing:
                    Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    highlightColor: Colors.grey,
                    onPressed: () {
                      UIUtil.PostPage(context, post[index]);
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  deleteLoading
                      ? indexDelete == index
                          ? const SizedBox(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.blue),
                                strokeWidth: 3.0,
                              ),
                              height: 25.0,
                              width: 25.0,
                            )
                          : IconButton(
                              icon: const Icon(Icons.delete),
                    color: Colors.amber,
                              highlightColor: Colors.grey,
                              onPressed: () {
                                delete(post[index].id!, index);
                              },
                            )
                      : IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.amber,
                          highlightColor: Colors.grey,
                          onPressed: () {
                            InternetUtil.check().then((value) => {
                                  if (value)
                                    {delete(post[index].id!, index)}
                                  else
                                    {
                                      UIUtil.toastPrint(BaseKey
                                          .Check_your_internet_connection)
                                    }
                                });

                            print("cilick");
                          },
                        ),
                ]),
              )),
    );
  }

  void delete(int Id, int index) {
    indexDelete = index;
    loadingdelete(true);
    HttpObj.instance.getClient().deletePost(Id).then((it) {
      loadingdelete(false);
      setState(() {
        post.removeAt(index);
        UIUtil.toastPrint("Post successfully deleted : $Id");
      });
    }).catchError((Object obj) {
      UIUtil.toastPrint(BaseKey.Something_went_wrong);
      loadingdelete(false);
      CommonException().exception(context, obj);
    });
  }

  void loadingdelete(bool load) {
    if (mounted) {
      setState(() {
        deleteLoading = load;
      });
    }
  }
}
