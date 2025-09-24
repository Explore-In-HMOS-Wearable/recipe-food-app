import Recipe from '../../model/Recipe';
import { recipesList } from '../../viewmodel/RecipesViewModel';
import RecipeCard from '../../component/RecipeCard';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct RecipesPage {
  recipes: Array<Recipe> = recipesList;

  build() {
    Stack() {
      Column() {
        Row() {
          Text('←')
            .fontSize(24)
            .fontColor(Color.White)
            .margin({ right: 8 })
            .onClick(() => {
              router.back()
            })
          Text('Recipes')
            .fontSize(20)
            .fontWeight(900)
            .fontColor(Color.White)
        }
        Divider().strokeWidth(2).color(Color.White)
      }
      .position({ y: '3%' })

      Swiper() {
        ForEach(this.recipes, (item: Recipe) => {
          RecipeCard({ recipe: item })
        }, (item: Recipe) => item.id)
      }
      .height(175)
      .width('100%')

      .indicator(
        new DotIndicator()
          .bottom('3%')
          .selectedColor(Color.White)
      )
    }
    .backgroundColor(Color.Black)
    .height('100%')
    .width('100%')
  }

  pageTransition() {
    PageTransitionEnter({ type: RouteType.Push, duration: 600 }).slide(SlideEffect.Right)
    PageTransitionEnter({ type: RouteType.Pop, duration: 600 }).slide(SlideEffect.Left)
    PageTransitionExit({ type: RouteType.Push, duration: 600 }).slide(SlideEffect.Left)
    PageTransitionExit({ type: RouteType.Pop, duration: 600 }).slide(SlideEffect.Right)
  }
}
