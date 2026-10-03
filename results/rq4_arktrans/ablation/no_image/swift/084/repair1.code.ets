@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Row({ space: 30 }) {
          Column({ space: 4 }) {
            Text('V60 Guide')
              .fontColor(Color.Black)
              .fontSize(34)
              .fontWeight(FontWeight.Bold)
            Text('Ethiopia Yirgacheffe')
              .fontColor('#8E8E93')
              .fontSize(16)
          }
          Blank()
          Button() {}
        }.padding({ top: 30, bottom: 30, left: 24, right: 24 })

        Blank()

        Column({ space: 10 }) {
          Text('00:45')
            .maxLines(1)
            .minFontSize(20) // 90 * 0.8 = 72, but minFontSize takes vp/px usually, using relative logic or fixed. Skeleton says 0.8 scale on 90.
            .fontColor(Color.Black)
            .fontSize(90)
            .fontWeight(FontWeight.Regular)
            .letterSpacing(0) // monospacedDigit approximation in ArkTS often requires specific font or just standard text if not critical, but here we stick to basic props.
          Text('Target: 300g')
            .fontColor('#8E8E93')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
        }

        Blank()

        Row({ space: 0 }) {
          Column({ space: 12 }) {
            Stack() {
              Circle()
                .width(64)
                .height(64)
                .borderWidth(1.5)
                .borderColor('#D1D1D6') // systemGray5 approx
              Image($r('app.media.startIcon'))
                .objectFit(ImageFit.Contain)
                .width(24)
                .height(24)
            }
            Column({ space: 4 }) {
              Text('value')
                .fontColor(Color.Black)
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
              Text('label')
                .fontColor('#8E8E93')
                .fontSize(13)
                .fontWeight(FontWeight.Medium)
            }
          }.width(80)

          Blank()

          Column({ space: 12 }) {
            Stack() {
              Circle()
                .width(64)
                .height(64)
                .borderWidth(1.5)
                .borderColor('#D1D1D6')
              Image($r('app.media.startIcon'))
                .objectFit(ImageFit.Contain)
                .width(24)
                .height(24)
            }
            Column({ space: 4 }) {
              Text('value')
                .fontColor(Color.Black)
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
              Text('label')
                .fontColor('#8E8E93')
                .fontSize(13)
                .fontWeight(FontWeight.Medium)
            }
          }.width(80)

          Blank()

          Column({ space: 12 }) {
            Stack() {
              Circle()
                .width(64)
                .height(64)
                .borderWidth(1.5)
                .borderColor('#D1D1D6')
              Image($r('app.media.startIcon'))
                .objectFit(ImageFit.Contain)
                .width(24)
                .height(24)
            }
            Column({ space: 4 }) {
              Text('value')
                .fontColor(Color.Black)
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
              Text('label')
                .fontColor('#8E8E93')
                .fontSize(13)
                .fontWeight(FontWeight.Medium)
            }
          }.width(80)
        }.padding({ left: 30, right: 30 })

        Blank()

        Column({ space: 15 }) {
          Text('Brewing Steps')
            .padding({ left: 24, right: 24 })
            .fontColor(Color.Black)
            .fontSize(19)
            .fontWeight(FontWeight.Bold)
          
          Row({ space: 16 }) {
            Image($r('app.media.startIcon'))
              .clipShape(Circle())
              .backgroundColor(Color.White)
              .width(28)
              .height(28)
            
            Rect()
              .overlay(
                () => {
                  Row() {
                    Blank()
                  }
                }
              )
              .height(52)
              .fill('#E5E5EA') // systemGray6 approx
              .borderRadius(10)
          }.padding({ left: 24, right: 24 })
        }

        Blank()

        Button()
          .padding({ bottom: 30, left: 24, right: 24 })
      }
    }.width('100%').height('100%')
  }
}