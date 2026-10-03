@Entry
@Component
struct Index {
  @State voteState: number = 1

  build() {
    Stack() {
      Column() {
        // === Header ===
        Row() {
          Image($r('app.media.startIcon')).width(24).height(24)
          Text('r/jetpackcompose').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#DFDFFF')
        }.width('100%').padding({ left: 16, right: 16, top: 16, bottom: 16 }).justifyContent(FlexAlign.Start)

        // === Post Content ===
        Row() {
          // === Vote Column ===
          Column({ space: 8 }) {
            Button() {
              Image($r('app.media.startIcon')).width(24).height(24)
            }
              .type(ButtonType.Normal)
              .backgroundColor(this.voteState == 1 ? '#FF00AA' : '#3F3F5A')
              .borderRadius(4)
              .width(32)
              .height(32)
              .onClick(() => {
                this.voteState = this.voteState == 1 ? 0 : 1
              })

            Text('1,337')
              .fontColor(this.voteState != 0 ? '#FF00AA' : '#DFDFFF')
              .fontWeight(FontWeight.Bold)
              .fontSize(20)

            Button() {
              Image($r('app.media.startIcon')).width(24).height(24)
            }
              .type(ButtonType.Normal)
              .backgroundColor(this.voteState == -1 ? '#FF00AA' : '#3F3F5A')
              .borderRadius(4)
              .width(32)
              .height(32)
              .onClick(() => {
                this.voteState = this.voteState == -1 ? 0 : -1
              })
          }.width(60).alignItems(HorizontalAlign.Center)

          // === Main Content Column ===
          Column({ space: 8 }) {
            // === Author Info Row ===
            Row({ space: 8 }) {
              Stack() {
                Circle().width(28).height(28).fill('#00FF00')
                Circle().width(10).height(10).fill(Color.Black).opacity(0.2)
              }
              Text('user/compose_master')
                .fontColor('#00FF00')
                .fontWeight(FontWeight.Bold)
                .fontSize(14)
              Text('8 hours ago')
                .fontColor('#6B6B8E')
                .fontSize(14)
            }

            // === Title ===
            Text('The power of Jetpack Compose for single-file UIs')
              .fontColor('#DFDFFF')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })

            // === Body ===
            Text('Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it\'s becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?')
              .fontColor('#DFDFFF')
              .opacity(0.8)
              .fontSize(16)
              .lineHeight(24)

            // === Footer Actions ===
            Row({ space: 24 }) {
              Text('42 Comments')
                .fontColor('#6B6B8E')
                .fontWeight(FontWeight.Bold)
                .fontSize(14)
              Text('Share')
                .fontColor('#6B6B8E')
                .fontWeight(FontWeight.Bold)
                .fontSize(14)
            }.padding({ top: 8 })
          }.layoutWeight(1).padding({ left: 16 })
        }.width('100%').padding({ left: 16, right: 16, top: 16, bottom: 16 })

        // === Top Comments Section ===
        Column() {
          Text('TOP COMMENTS')
            .fontColor('#6B6B8E')
            .fontWeight(FontWeight.Bold)
            .fontSize(16)
            .padding({ left: 16, top: 16, bottom: 16 })

          // === Comment Item ===
          Row() {
            Column().width(4).height('100%').backgroundColor('#FF00AA')
            Column({ space: 8 }) {
              Row({ space: 8 }) {
                Stack() {
                  Circle().width(28).height(28).fill('#FF00AA')
                  Circle().width(10).height(10).fill(Color.Black).opacity(0.2)
                }
                Text('dev/android_fan')
                  .fontColor('#FF00AA')
                  .fontWeight(FontWeight.Bold)
                  .fontSize(14)
                Text('7h ago')
                  .fontColor('#6B6B8E')
                  .fontSize(14)
              }
              Text('Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.')
                .fontColor('#DFDFFF')
                .fontSize(16)
                .lineHeight(24)
            }.layoutWeight(1).padding({ left: 16, right: 16 })
          }.width('100%').padding({ left: 16, right: 16, bottom: 16 })
        }.width('100%').backgroundColor('#1A1A2E')

        // === Bottom Input Bar ===
        Row() {
          TextInput({ placeholder: 'Add a comment...' })
            .backgroundColor('#2D2D44')
            .borderRadius(24)
            .padding(16)
            .layoutWeight(1)
            .fontColor('#DFDFFF')
            .placeholderColor('#6B6B8E')
          
          Button('POST')
            .backgroundColor('#00FFFF')
            .fontColor('#000000')
            .fontWeight(FontWeight.Bold)
            .borderRadius(24)
            .width(100)
            .height(48)
        }.width('100%').padding(16).backgroundColor('#1A1A2E')
      }.width('100%').height('100%').backgroundColor('#1A1A2E')
    }.width('100%').height('100%')
  }
}