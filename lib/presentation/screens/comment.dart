import 'package:firfir_tera/bloc/comment/comment_bloc.dart';
import 'package:firfir_tera/bloc/comment/comment_event.dart';
import 'package:firfir_tera/bloc/comment/comment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentScreen extends StatelessWidget {
  final String recipeId;

  CommentScreen({required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        title: Text('Comments'),
      ),
      body: BlocProvider(
        create: (_) => CommentBloc()..add(LoadComments(recipeId: recipeId)),
        child: CommentView(recipeId: recipeId),
      ),
    );
  }
}

class CommentView extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final String recipeId;
  CommentView({required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<CommentBloc, CommentState>(
            builder: (context, state) {
              if (state is CommentLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is CommentLoaded) {
                return ListView.builder(
                  itemCount: state.comments.length,
                  itemBuilder: (context, index) {
                    final comment = state.comments[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/profile_pic/profile_2.jpg'),
                      ),
                      title: Text(comment.text),
                    );
                  },
                );
              } else if (state is CommentError) {
                return Center(child: Text(state.message));
              }
              return Center(child: Text('No comments yet.'));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(hintText: 'Enter your comment'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    context
                        .read<CommentBloc>()
                        .add(AddComment(_controller.text, recipeId));
                    _controller.clear();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
