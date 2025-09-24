import Recipe from '../../model/Recipe';
import RecipeCard from '../../component/RecipeCard';
import { RecipesDetailViewModel } from '../../viewmodel/RecipesDetailViewModel';
import FavoriteTable from '../../service/FavoriteTable';

@Entry
@Component
struct FavoritePage {
  private viewModel: RecipesDetailViewModel = new RecipesDetailViewModel();

  @State private bookmarks: Recipe[] = [];
  @State private isLoading: boolean = true;
  private favoriteTable: FavoriteTable = new FavoriteTable();
  aboutToAppear(): void {

    this.favoriteTable.getCount((count: number) => {
      console.info('Bookmark count:', count);
    });
    this.viewModel.getBookmarkCount((count: number) => {
      console.info('Bookmark count:', count);
    });
    this.viewModel.getBookmarks((result: Recipe[]) => {
      this.bookmarks = result;
      this.isLoading = false;
      console.info('Bookmarks loaded:', result.length);
    });

  }

  build() {
    Column() {
      if (this.isLoading) {
        Text('Loading bookmarks...').fontColor(Color.Gray).fontSize(16)
      } else if (this.bookmarks.length === 0) {
        Text('No bookmarks yet.').fontColor(Color.White).fontSize(16)
      } else {
        Text('Favorites')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .alignSelf(ItemAlign.Center)
          .margin(12)

        Scroll() {
          Column() {
            ForEach(this.bookmarks, (recipe: Recipe) => {
              RecipeCard({ recipe });
            }, (recipe: Recipe) => recipe.id)
          }
        }
        .scrollable(ScrollDirection.Vertical)
        .height('80%')
      }
    }
    .backgroundColor(Color.Black)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }

  pageTransition() {
    PageTransitionEnter({ type: RouteType.Push, duration: 600 }).slide(SlideEffect.Right)
    PageTransitionEnter({ type: RouteType.Pop, duration: 600 }).slide(SlideEffect.Left)
    PageTransitionExit({ type: RouteType.Push, duration: 600 }).slide(SlideEffect.Left)
    PageTransitionExit({ type: RouteType.Pop, duration: 600 }).slide(SlideEffect.Right)
  }
  onPageShow(): void {
    this.isLoading = true;
    this.viewModel.getBookmarkCount((count: number) => {
      console.info('Bookmark count (show):', count);
    });
    this.viewModel.getBookmarks((result: Recipe[]) => {
      this.bookmarks = result;
      this.isLoading = false;
      console.info('Bookmarks loaded (show):', result.length);
    });
  }
}
