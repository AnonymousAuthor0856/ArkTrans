@Entry
@Component
struct Index {
  build() {
    Column() {
      // Movie Poster Image
      Image($r('app.media.startIcon'))
        .width('100%')
        .height(450)
        .objectFit(ImageFit.Cover)

      Column() {
        // Title
        Text('Fight Club')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111')
          .margin({ top: 20, bottom: 8 })
          .alignSelf(ItemAlign.Start)

        // Metadata Row (Date · Language · Duration)
        Row({ space: 8 }) {
          Text('1999-10-15')
            .fontColor('#8E8E93')
            .fontSize(16)
          Text('·')
            .fontColor('#8E8E93')
            .fontSize(16)
          Text('English')
            .fontColor('#8E8E93')
            .fontSize(16)
          Text('·')
            .fontColor('#8E8E93')
            .fontSize(16)
          Text('2h 19m')
            .fontColor('#8E8E93')
            .fontSize(16)
        }
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: 16 })

        // Genres
        Row({ space: 12 }) {
          this.GenreTag('Drama')
          this.GenreTag('Thriller')
          this.GenreTag('Comedy')
        }
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: 16 })

        // Rating
        Row({ space: 8 }) {
          Text('⭐')
          Text('8.4/10')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
        }
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: 16 })

        // Overview Section
        Column() {
          Text('Overview')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor('#111')
            .margin({ bottom: 8 })
          
          Text('A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy.')
            .fontSize(16)
            .lineHeight(24)
            .fontColor('#333')
            .textAlign(TextAlign.Start)
        }.alignSelf(ItemAlign.Start)

      }
      .padding(20)
      .width('100%')
      .backgroundColor('#FFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F2F2F7')
  }

  @Builder
  GenreTag(text: string) {
    Text(text)
      .fontSize(14)
      .fontColor('#333')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .borderRadius(20)
      .border({ width: 1, color: '#C7C7CC' })
      .backgroundColor('#F2F2F7')
  }
}