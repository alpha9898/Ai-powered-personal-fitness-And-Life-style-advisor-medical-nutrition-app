import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_ui/core/Cubit/fav_cubit/cubit/fav_exrcies_cubit.dart';
import 'package:graduation_project_ui/core/Entity/ExerciseEntity.dart';
import 'package:graduation_project_ui/core/Models/ExerciseModel.dart';
import 'package:graduation_project_ui/core/Services/Data_Base_Service.dart';
import 'package:graduation_project_ui/core/Services/Fire_Base_Store_Service.dart';
import 'package:graduation_project_ui/core/Utils/App_images.dart';
import 'package:graduation_project_ui/core/helper/Get_User_Id.dart';

class Train_food_Item extends StatefulWidget {
  Train_food_Item(
      {super.key, required this.image, required this.exerciseEntity});
  final String image;
  final ExerciseEntity exerciseEntity;
  final DatabaseService databaseService = FireBaseStoreService();

  @override
  State<Train_food_Item> createState() => _Train_food_ItemState();
}

class _Train_food_ItemState extends State<Train_food_Item> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    checkIfFavorite();
  }

  void checkIfFavorite() async {
    try {
      final favDoc = await widget.databaseService
          .fetchFavoriteWorkouts(getCurrentUserId());
      final Map<String, dynamic>? docData = favDoc.data();

      if (docData != null && docData.containsKey('favoriteWorkouts')) {
        final favorites = (docData['favoriteWorkouts'] as List)
            .map((e) => Exercisemodel.fromJson(e).id)
            .toList();
        if (mounted) {
          setState(() {
            isFavorite = favorites.contains(widget.exerciseEntity.id);
          });
        }
      }
    } catch (e) {
      // Handle error silently
    }
  }

  void _updateFavoriteState(List<dynamic> favoritesList) {
    final isFav = favoritesList.any((exercise) {
      if (exercise is ExerciseEntity) {
        return exercise.id == widget.exerciseEntity.id;
      }
      return false;
    });

    if (mounted && isFav != isFavorite) {
      setState(() {
        isFavorite = isFav;
      });
    }
  }

  void _toggleFavorite() async {
    // Update UI immediately for better user experience
    setState(() {
      isFavorite = !isFavorite;
    });

    try {
      // Try to get the cubit from context
      FavExrciesCubit? favCubit;
      try {
        favCubit = context.read<FavExrciesCubit>();
      } catch (e) {
        print('Error accessing FavExrciesCubit: $e');
        // If cubit is not available, we can't update the state but we can still save to Firebase
      }

      if (isFavorite) {
        // Save to Firebase directly
        await widget.databaseService.addWorkoutToFavorites(
            getCurrentUserId(), widget.exerciseEntity.toModel());

        // Update cubit if available
        if (favCubit != null) {
          await favCubit.addFavExercises(widget.exerciseEntity);
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('${widget.exerciseEntity.name} added to favorites')),
          );
        }
      } else {
        // Remove from Firebase directly
        await widget.databaseService.removeWorkoutFromFavorites(
            getCurrentUserId(), widget.exerciseEntity.toModel());

        // Update cubit if available
        if (favCubit != null) {
          await favCubit.removeFromFavorites(widget.exerciseEntity);
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    '${widget.exerciseEntity.name} removed from favorites')),
          );
        }
      }
    } catch (e) {
      // If there's an error, revert the UI state
      if (mounted) {
        setState(() {
          isFavorite = !isFavorite;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update favorites: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavExrciesCubit, FavExrciesState>(
      listener: (context, state) {
        if (state is FavExrciesSuccess) {
          _updateFavoriteState(state.Fav_exercise);
        }
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IntrinsicHeight(
              child: Stack(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          width: 140,
                          height: 100,
                          image: NetworkImage(widget
                              .exerciseEntity.image!), //AssetImage(image),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.broken_image,
                                size: 50, color: Colors.grey);
                          },
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, left: 12, right: 1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                widget.exerciseEntity.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(children: [
                                SvgPicture.asset(Assets.assetsSvgCalories),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  widget.exerciseEntity.duration.toString(),
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 14),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                SvgPicture.asset(Assets.assetsSvgTime),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  widget.exerciseEntity.calories.toString(),
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 14),
                                )
                              ]),
                              Visibility(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(Assets.assetsSvgExercies),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      '${widget.exerciseEntity.repetitions} exercises',
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 1,
                    left: 310,
                    child: IconButton(
                      onPressed: _toggleFavorite,
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_outline,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
