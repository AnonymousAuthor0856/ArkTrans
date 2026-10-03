@Entry
@Component
struct SocialMediaPost {
  @State postTitle: string = 'Sample Post'
  @State postContent: string = 'This is a sample social media post content.'
  @State likes: number = 0

  build() {
    Column() {
      Text(this.postTitle)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 10 })

      Text(this.postContent)
        .fontSize(16)
        .margin({ top: 5, bottom: 10 })

      Row() {
        Button('Like')
          .onClick(() => {
            this.likes++
          })
        Text(`${this.likes} Likes`)
          .margin({ left: 10 })
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .margin({ top: 10 })
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#1E1E1E')
    .borderRadius(10)
    .margin(20)
  }
}