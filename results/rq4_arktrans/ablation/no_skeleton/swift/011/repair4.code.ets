@Entry
@Component
struct ForumPostApp {
  @State voteState: number = 1
  @State commentText: string = ''

  build() {
    Column() {
      // TopAppBar
      Row() {
        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
        }
          .width(50)
          .height(50)
          .backgroundColor(Color.Transparent)

        Text('r/jetpackcompose')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#DEE3F7')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)

        Blank().width(50)
      }
      .width('100%')
      .height(60)
      .padding({ left: 20, right: 20 })
      .backgroundColor('#1C1C36')

      // ScrollView Content
      Scroll() {
        Column() {
          // PostCard
          Row() {
            // Vote Column
            Column({ space: 10 }) {
              // Up Arrow
              Image($r('app.media.startIcon'))
                .width(28)
                .height(28)
                .fillColor(this.voteState === 1 ? '#FF00AA' : '#44446D')
                .rotate({ angle: -45 })
              
              Text(`${this.voteState === 1 ? '1,337' : '1,336'}`)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.voteState !== 0 ? '#FF00AA' : '#DEE3F7')
              
              // Down Arrow
              Image($r('app.media.startIcon'))
                .width(28)
                .height(28)
                .fillColor('#44446D')
                .rotate({ angle: 135 })
            }
            .width(60)
            .justifyContent(FlexAlign.Start)

            // Content Column
            Column({ space: 10 }) {
              // Author Info
              Row({ space: 10 }) {
                Circle()
                  .width(28)
                  .height(28)
                  .fillColor('#76FF03')
                
                Text('user/compose_master')
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#76FF03')
                
                Text('8 hours ago')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#44446D')
              }

              // Title
              Text('The power of Jetpack Compose for single-file UIs')
                .fontSize(22)
                .fontWeight(FontWeight.Medium)
                .fontColor('#DEE3F7')
                .lineHeight(28)

              // Body
              Text('Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it\'s becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?')
                .fontSize(18)
                .fontWeight(FontWeight.Regular)
                .fontColor('#DEE3F7')
                .opacity(0.8)
                .lineHeight(24)

              // Chips
              Row({ space: 28 }) {
                Text('42 Comments')
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#44446D')
                
                Text('Share')
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#44446D')
              }
              .margin({ top: 10 })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
          }
          .width('100%')
          .padding(20)
          .backgroundColor('#1C1C36')

          // Top Comments Header
          Text('TOP COMMENTS')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#44446D')
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ left: 20, right: 20, top: 10, bottom: 10 })
            .backgroundColor('#10101E')

          // Reply Card 1
          Row() {
            Rect()
              .width(3)
              .height('100%')
              .fill('#FF00AA')
              .borderRadius(1.5)
            
            Column({ space: 6 }) {
              Row({ space: 10 }) {
                Circle()
                  .width(28)
                  .height(28)
                  .fillColor('#FF00AA')
                
                Text('dev/android_fan')
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FF00AA')
                
                Text('7h ago')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#44446D')
              }

              Text('Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.')
                .fontSize(18)
                .fontWeight(FontWeight.Regular)
                .fontColor('#DEE3F7')
                .opacity(0.9)
                .lineHeight(24)

              Row({ space: 16 }) {
                Text('25 votes')
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#44446D')
                
                Text('Reply')
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#44446D')
              }
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
          }
          .width('100%')
          .padding({ left: 20, right: 20, top: 10, bottom: 10 })
          .backgroundColor('#10101E')
          
          // Spacer to allow scrolling past the fixed bottom bar
          Blank().height(100)
        }
      }
      .backgroundColor('#10101E')
      .layoutWeight(1)

      // BottomCommentBar
      Column() {
        Divider()
          .color('#44446D')
          .opacity(0.3)
          .margin({ left: 20, right: 20 })
        
        Row({ space: 16 }) {
          TextInput({ placeholder: 'Add a comment...' })
            .placeholderFont({ size: 18, weight: FontWeight.Regular })
            .placeholderColor('#44446D')
            .font({ size: 18, weight: FontWeight.Regular })
            .textColor('#DEE3F7')
            .backgroundColor('#28284A')
            .borderRadius(20)
            .height(52)
            .padding({ left: 20 })
            .layoutWeight(1)
          
          Button('POST')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .backgroundColor('#00E5FF')
            .borderRadius(20)
            .height(52)
            .width(100)
        }
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
        .backgroundColor('#1C1C36')
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#10101E')
  }
}