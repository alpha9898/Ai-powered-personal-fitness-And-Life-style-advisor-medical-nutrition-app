import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_ui/core/Cubit/fav_cubit/cubit/fav_meals_cubit.dart';
import 'package:graduation_project_ui/core/Entity/MealEntity.dart';
import 'package:graduation_project_ui/core/Utils/App_images.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class NurationItem extends StatefulWidget {
  final Mealentity mealentity;
  const NurationItem({
    required this.mealentity,
    super.key,
  });

  @override
  State<NurationItem> createState() => _NurationItemState();
}

class _NurationItemState extends State<NurationItem> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  void _checkIfFavorite() async {
    if (context.mounted) {
      try {
        final favCubit = context.read<FavMealsCubit>();

        // First try to check from current cubit state
        if (favCubit.state is FavMealsSuccess) {
          final currentFavorites = (favCubit.state as FavMealsSuccess).favMeals;
          final isInCurrentState = currentFavorites.any((meal) {
            if (meal is Mealentity) {
              return meal.id == widget.mealentity.id;
            }
            return false;
          });

          if (mounted) {
            setState(() {
              isFavorite = isInCurrentState;
            });
          }
          return;
        }

        // Fallback to Firebase check if state is not available
        final isAlreadyFavorite =
            await favCubit.isMealFavorite(widget.mealentity.id);
        if (mounted) {
          setState(() {
            isFavorite = isAlreadyFavorite;
          });
        }
      } catch (e) {
        // Handle error silently
      }
    }
  }

  void _updateFavoriteState(List<dynamic> favoritesList) {
    final isFav = favoritesList.any((meal) {
      if (meal is Mealentity) {
        return meal.id == widget.mealentity.id;
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
    print(
        'Toggle favorite called. Current state: $isFavorite, Meal: ${widget.mealentity.name}');

    // Update UI immediately for better user experience
    setState(() {
      isFavorite = !isFavorite;
    });

    try {
      final favCubit = context.read<FavMealsCubit>();
      if (isFavorite) {
        print('Adding meal to favorites: ${widget.mealentity.name}');
        await favCubit.addFavMeal(widget.mealentity);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${widget.mealentity.name} added to favorites'),
              backgroundColor: KPrimaryColor,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } else {
        print('Removing meal from favorites: ${widget.mealentity.name}');
        await favCubit.removeFromFavorites(widget.mealentity);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${widget.mealentity.name} removed from favorites'),
              backgroundColor: Colors.grey,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      print('Error in toggle favorite: $e');
      // If there's an error, revert the UI state
      if (mounted) {
        setState(() {
          isFavorite = !isFavorite;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update favorites'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavMealsCubit, FavMealsState>(
      listener: (context, state) {
        if (state is FavMealsSuccess) {
          _updateFavoriteState(state.favMeals);
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
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      width: 140,
                      height: 100,
                      image: NetworkImage(
                          widget.mealentity.image!), //AssetImage(image),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image,
                            size: 50, color: Colors.grey);
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 12.0, left: 12, right: 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  widget.mealentity.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 18),
                                ),
                              ),
                              IconButton(
                                onPressed: _toggleFavorite,
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: isFavorite ? Colors.red : Colors.grey,
                                  size: 28,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ],
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
                              '50 Munits',
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
                              '${widget.mealentity.Calories} calories',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 14),
                            )
                          ]),
                          Visibility(
                            visible: true,
                            child: Row(
                              children: [
                                SvgPicture.asset(Assets.assetsSvgExercies),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  widget.mealentity.Type,
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 14),
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
            ),
          )),
    );
  }
}
