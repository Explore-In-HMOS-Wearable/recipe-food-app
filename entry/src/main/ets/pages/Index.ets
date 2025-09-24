import { router } from '@kit.ArkUI'

@Entry
@Component
struct Index {


  build() {
    Row() {
      Column() {
        Button() {
          Row() {
            Image($r('app.media.recipe'))
              .width(24)
              .height(24)
              .margin({ right: 8 })

            Text('Recipes')
              .fontColor('#ff000000')
              .fontWeight(900)
              .fontSize(25)
              .fontStyle(FontStyle.Italic)
          }
        }
        .type(ButtonType.Normal)
        .borderRadius(5)
        .padding(10)
        .backgroundColor('#ffffffff')
        .onClick(() => {
          router.pushUrl({ url: 'pages/recipes/RecipesPage' })
        })

        Blank().height('5%')

        Button() {
          Row() {
            Image($r('app.media.bookmarks'))
              .width(24)
              .height(24)
              .margin({ right: 8 })

            Text('Bookmarks')
              .fontColor('#ff000000')
              .fontWeight(900)
              .fontSize(25)
              .fontStyle(FontStyle.Italic)
          }
        }

        .type(ButtonType.Normal)
        .borderRadius(5)
        .padding(10)
        .backgroundColor('#ffffffff')
        .onClick(() => {
          router.pushUrl({ url: 'pages/favorites/FavoritePage' })
        })
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
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
