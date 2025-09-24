import Recipe from '../model/Recipe';
import { router } from '@kit.ArkUI';
import { RecipePageParams } from '../model/RecipeParams';
import FavoriteTable from '../service/FavoriteTable';

@Entry
@Component
struct DetailPage {
  private favoriteTable: FavoriteTable = new FavoriteTable();
  @State private isLoading: boolean = true;
  @State private recipe: Recipe = {
    id: '',
    name: '',
    imageSource: '',
    description: '',
    isFavorite: false
  };
  @State private buttonText: string = ''

  aboutToAppear(): void {
    const rawParams = router.getParams();
    if (rawParams && typeof rawParams === 'object') {
      const params = rawParams as RecipePageParams;
      try {
        const parsed = JSON.parse(params.recipe) as Recipe;
        this.recipe = parsed;
        this.isLoading = false;
        this.favoriteTable.getAll((recipes: Recipe[]) => {
          const isInFavorites = recipes.some(item => item.id === this.recipe.id);
          this.recipe.isFavorite = isInFavorites;
          this.buttonText = isInFavorites ? 'Remove Bookmark' : 'Add Bookmark';

        });

      } catch (e) {
        console.error('Recipe parse error:', e);
        this.isLoading = false;
      }
    }
  }

  toggleBookmark(): void {
    if (this.recipe.isFavorite) {
      this.favoriteTable.deleteFavorite(this.recipe.id, (success: boolean) => {
        if (success) {
          this.recipe.isFavorite = false;
          this.buttonText = 'Add Bookmark'
          console.info('Bookmark removed.');
        } else {
          console.error('Failed to remove bookmark.');
        }
      });
    } else {
      const recipeToSave: Recipe = {
        id: this.recipe.id,
        name: this.recipe.name,
        imageSource: this.recipe.imageSource,
        description: this.recipe.description,
        isFavorite: true
      };
      this.favoriteTable.insertFavorite(recipeToSave, (success: boolean) => {
        if (success) {
          this.recipe.isFavorite = true;
          this.buttonText = 'Remove Bookmark'
          this.favoriteTable.getCount((count: number) => {
            console.info('Bookmark count:', count);
          });

          console.info('Bookmark added!');
        } else {
          console.error('Failed to add bookmark.');
        }
      });

    }
  }

  build() {
    Scroll() {
      Column() {
        if (this.isLoading) {
          this.buildShimmer();
        } else {
          this.buildContent();
        }
      }
    }
    .scrollable(ScrollDirection.Vertical)
    .backgroundColor(Color.Black)
    .width('100%')
    .height('100%')
  }

  @Builder
  private buildContent() {
    Column() {
      Image($rawfile(this.recipe.imageSource))
        .width('90%')
        .height(150)
        .objectFit(ImageFit.Cover)
        .borderRadius(10)
        .margin({ top: 10, bottom: 10 })
        .alignSelf(ItemAlign.Center)

      Text(this.recipe.name)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .margin({ bottom: 6, left: 12, right: 12 })
        .alignSelf(ItemAlign.Center)

      Text('Description:')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#BBBBBB')
        .margin({ left: 12, right: 12, bottom: 4 })

      Text(this.recipe.description)
        .fontSize(14)
        .fontColor(Color.White)
        .margin({ left: 12, right: 12, bottom: 20 })
        .textAlign(TextAlign.Start)

      Button(this.buttonText)
        .backgroundColor(Color.White)
        .fontColor(Color.White)
        .margin({ bottom: 10 })
        .fontSize(13)
        .onClick(() => this.toggleBookmark());
    }
  }

  @Builder
  private buildShimmer() {
    Column() {
      Blank()
        .width('90%')
        .height(150)
        .backgroundColor('#333333')
        .borderRadius(10)
        .margin({ top: 10, bottom: 10 })
      Blank().width('60%').height(20).backgroundColor('#444444').margin(12)
      Blank().width('80%').height(14).backgroundColor('#444444').margin({ left: 12, right: 12, bottom: 10 })
      Blank()
        .width('40%')
        .height(40)
        .backgroundColor('#555555')
        .borderRadius(6)
        .margin(10)
    }
    .alignItems(HorizontalAlign.Center)
  }

  pageTransition() {
    PageTransitionEnter({ type: RouteType.Push, duration: 400 }).slide(SlideEffect.Right)
    PageTransitionEnter({ type: RouteType.Pop, duration: 400 }).slide(SlideEffect.Left)
    PageTransitionExit({ type: RouteType.Push, duration: 400 }).slide(SlideEffect.Left)
    PageTransitionExit({ type: RouteType.Pop, duration: 400 }).slide(SlideEffect.Right)
  }
}