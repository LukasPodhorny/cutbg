import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'data/db/app_database.dart';
import 'data/repositories/projects_repository.dart';
import 'features/editor/bloc/editor_bloc.dart';
import 'features/home/view/home_page.dart';
import 'services/api/bg_removal_api.dart';

class CutBGApp extends StatelessWidget {
  const CutBGApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AppDatabase()),
        RepositoryProvider(create: (_) => BgRemovalApi()),
        RepositoryProvider(
          create: (context) => ProjectsRepository(context.read<AppDatabase>()),
        ),
      ],
      child: BlocProvider(
        create: (context) =>
            EditorBloc(api: context.read<BgRemovalApi>()),
        child: MaterialApp(
          title: 'CutBG',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          home: const HomePage(),
        ),
      ),
    );
  }
}
