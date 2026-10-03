import { canvas } from '@kit.ArkGraphics';

@Entry
@Component
struct Index {
  private ctx: canvas.CanvasRenderingContext2D | null = null;

  aboutToAppear() {
    // Initialize context if needed, though Canvas component handles it via callback usually.
    // For this fix, we ensure the property exists.
  }

  build() {
    Stack() {
      Column() {
        Column() {
          Text('Favorite Spots Map')
            .fontColor('#111827')
            .fontSize(28)
            .fontWeight(FontWeight.SemiBold)
        }
        .backgroundColor('#F9FAFB')
        .padding({ top: 10, bottom: 10 })
        .width('100%')

        Stack() {
          LinearGradient({
            angle: 135,
            colors: [
              ['#FFFFFF', 0.6],
              ['#EFF6FF', 0.5],
              ['#FFFFFF', 0.7]
            ]
          })
          .width('100%')
          .height('100%')

          Column() {
            Blank()

            Stack() {
              RadialGradient({
                center: [0.5, 0.5],
                radius: 120,
                colors: [
                  ['#FFFFFF', 0.8],
                  ['#EFF6FF', 0.6]
                ]
              })
              .width('100%')
              .height('100%')
              .borderRadius(24)

              Rect()
                .width('100%')
                .height('100%')
                .borderRadius(24)
                .border({ width: 1, color: '#D1D5DB' })

              Canvas(this.ctx)
                .width('100%')
                .height('100%')
            }
            .width('100%')
            .height(400)
            .padding({ left: 16, right: 16 })

            Column() {
              Text('Spot Coordinates: (0, 0)')
                .fontColor('#111827')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)

              Button() {
                Text('Save Marker')
                  .fontColor('#FFFFFF')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
              }
              .backgroundColor('#60A5FA')
              .borderRadius(16)
              .height(48)
              .width('100%')

              Column() {
                Text('Saved Markers')
                  .fontColor('#111827')
                  .fontSize(18)
                  .fontWeight(FontWeight.SemiBold)
                  .textAlign(TextAlign.Start)

                Column({ space: 8 }) {
                  Row() {
                    Circle()
                      .fill('#60A5FA')
                      .width(8)
                      .height(8)
                    
                    Text('Saved Marker')
                      .fontColor('#111827')
                      .fontSize(14)
                      .fontWeight(FontWeight.Regular)
                    
                    Blank()
                  }
                  .width('100%')

                  Row() {
                    Circle()
                      .fill('#60A5FA')
                      .width(8)
                      .height(8)
                    
                    Text('Saved Marker')
                      .fontColor('#111827')
                      .fontSize(14)
                      .fontWeight(FontWeight.Regular)
                    
                    Blank()
                  }
                  .width('100%')
                }
              }
              .padding({ top: 8 })
              .width('100%')
              .alignItems(HorizontalAlign.Start)
            }
            .spacing(16)
            .padding({ left: 16, right: 16, bottom: 24 })
            .width('100%')
          }
          .width('100%')
          .height('100%')
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F9FAFB')
    }
    .width('100%')
    .height('100%')
  }
}