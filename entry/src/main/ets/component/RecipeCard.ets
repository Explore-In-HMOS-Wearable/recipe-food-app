import Recipe from '../model/Recipe';
import { router } from '@kit.ArkUI';

@Component
export default struct RecipeCard {
  @Prop recipe: Recipe;
  @State favOpacity: number = 0;

  build() {
    Column() {
      Blank().height('17%')

      Image($rawfile(this.recipe.imageSource))
        .aspectRatio(1)
        .height('60%')
        .clipShape(new Circle({ height: '100%', width: '100%' }))
        .gesture(
          TapGesture({ count: 2 }).onAction(() => {
            this.favOpacity = 1

          })
        )

      Blank().height('1%')

      Text(this.recipe.name)
        .fontSize(15)
        .fontWeight(900)
        .fontColor(Color.White)
    }
    .width('100%')
    .height(100)
    .onClick(() => {
      router.pushUrl({
        url: 'pages/DetailPage',
        params: { recipe: JSON.stringify(this.recipe) }
      });
    });
  }
}
