@Entry
@Component
struct Index {
  @State progress: number = 0.5

  build() {
    Stack() {
      Stack() {
        Column({ space: 0 }) {
          Row() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .padding({ left: 8 })
            
            Blank()
            
            Text('Charging Progress')
              .fontColor('#111827')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
            
            Blank()
            
            Button() {
              Text('Settings')
            }
            .backgroundColor('#E5E7EB')
            .borderRadius(8)
            .width(40)
            .height(40)
          }
          .width('100%')
          .padding({ top: 8, bottom: 8, left: 16, right: 16 })
          .backgroundColor('#FFFFFF')

          Column() {
            Column() {
              Stack() {
                Rect()
                  .width(50)
                  .height(90)
                  .borderRadius(8)
                  .fill('#3B82F6')
                
                Rect()
                  .width(20)
                  .height(10)
                  .borderRadius(3)
                  .fill('#3B82F6')
                  .position({ x: 15, y: -50 })
                
                LightningBolt()
                  .width(25)
                  .height(40)
              }
              
              Text(`${Math.round(this.progress * 100)}%`)
                .fontColor('#111827')
                .fontSize(36)
                .fontWeight(FontWeight.Bold)
            }
            .padding({ top: 16 })

            Stack({ alignContent: Alignment.Start }) {
              Rect()
                .width('100%')
                .height(12)
                .borderRadius(6)
                .fill('#FFFFFF')
                .border({ width: 1, color: '#D4D4D8' })
              
              Rect()
                .width(`${Math.min(Math.max(this.progress, 0), 1) * 100}%`)
                .height(10)
                .borderRadius(5)
                .fill('#3B82F6')
                .margin({ left: 1, right: 1, top: 1, bottom: 1 })
            }
            .width('100%')

            Rect()
              .width('100%')
              .height(1)
              .fill('#E5E7EB')
              .margin({ top: 16, bottom: 16 })

            Button() {
              Text('Charge')
            }
            .backgroundColor('#3B82F6')
            .borderRadius(8)
            .width('100%')
            .height(48)
            .onClick(() => {
              this.progress += 0.1;
              if (this.progress > 1.0) {
                this.progress = 0.0;
              }
            })
            .margin({ top: 16 })

            Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!')
              .fontColor(this.progress < 1.0 ? '#3B82F6' : '#10B981')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .margin({ top: 16 })

            Blank()
          }
          .width('100%')
          .padding(16)
        }
      }
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct LightningBolt {
  build() {
    Path({
      elements: `M 12 2 L 20 14 L 13 14 L 16 22 L 4 10 L 11 10 Z`
    })
    .fill('#FFFFFF')
  }
}