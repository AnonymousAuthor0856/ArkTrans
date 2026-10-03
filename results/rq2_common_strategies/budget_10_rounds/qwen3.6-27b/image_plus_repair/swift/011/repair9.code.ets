// App.ets
import { ForumPostView } from './ForumPostView'

@Entry
@Component
struct ForumPostApp {
  build() {
    Column() {
      ForumPostView()
    }
    .backgroundColor('#101024')
    .width('100%')
    .height('100%')
  }
}