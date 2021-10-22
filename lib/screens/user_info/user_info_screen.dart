import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app_eds/utils/styles/styles.dart';


class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({
    Key? key,
    required this.name,
    required this.userName,
    required this.email,
    required this.phone,
    required this.website,
    required this.compName,
    required this.bs,
    required this.street,
    required this.suite,
    required this.city,

  }) : super(key: key);

  final String name;
  final String userName;
  final String phone;
  final String email;
  final String website;
  final String compName;
  final String bs;
  final String street;
  final String suite;
  final String city;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(userName),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: CircleAvatar(radius: 48,),
              ),
              UserInfoItem(name: name, title: 'Name',),
              UserInfoItem(name: email, title: 'E-mail',),
              UserInfoItem(name: phone, title: 'Phone',),
              UserInfoItem(name: website, title: 'Website',),
              UserInfoItem(name: compName, title: 'Company',),
              UserInfoItem(name: bs, title: '     ',),
              UserInfoItem(name: street, title: 'Address',),
              UserInfoItem(name: suite, title: '     ',),
              UserInfoItem(name: city, title: '     ',),

              Row(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text('Posts',style: MyTextStyles.header2,)),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios_rounded,size: 20,)
                ],
              ),

              ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(title: Text('post title',style: MyTextStyles.header3,),
                      subtitle: Text('title body iewnewrnerinfeje lkaj jnweanwjnwjn wjndwjnedn jnenwfndennw nwen',
                        overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      ),);
                  },
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text('See all posts', style: MyTextStyles.header2.copyWith(color: Colors.blue),)),

//TODO: implement better ui
              Row(
                children: [
                Container(
                  margin: EdgeInsets.all(8),
                  width: 64,
                height: 64,
                child: Center(child: Text('title')),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(image: NetworkImage('https://via.placeholder.com/150/d32776')),
                ),),
                Container(
                  margin: EdgeInsets.all(8),
                  width: 64,
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(image: NetworkImage('https://via.placeholder.com/150/f66b97')),
                ),),
                Container(
                  margin: EdgeInsets.all(8),
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12 ),
                  image: DecorationImage(image: NetworkImage('https://via.placeholder.com/150/1ee8a4')),
                ),),
                ],
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Text('See all Albums', style: MyTextStyles.header2.copyWith(color: Colors.blue),)),

            ],





          ),
        ),
      ),
    );
  }
}

class UserInfoItem extends StatelessWidget {
  const UserInfoItem({
    Key? key,
    required this.name,
    required this.title,
  }) : super(key: key);

  final String name;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
            Text('$title ',style: MyTextStyles.header2,),
            Spacer(),
            Text('$name',style: MyTextStyles.body,),
              Spacer(),
            ],),
        ),
        Divider(),
      ],
    );
  }
}
