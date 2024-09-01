import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'user_card_model.dart';

class UserCard extends StackedView<UserCardModel> {
  const UserCard({super.key});

  @override
  Widget builder(
    BuildContext context,
    UserCardModel viewModel,
    Widget? child,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Card.filled(
        child: ListTile(
          leading: viewModel.avatarUrl != null
              ? CircleAvatar(
                  foregroundImage: NetworkImage(
                    viewModel.avatarUrl!,
                  ),
                )
              : null,
          title: Text(
            viewModel.userName ?? 'User not logged in',
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
            ),
          ),
          subtitle: Text(viewModel.userEmail ?? 'No email'),
        ),
      ),
    );
  }

  @override
  UserCardModel viewModelBuilder(
    BuildContext context,
  ) =>
      UserCardModel();
}
