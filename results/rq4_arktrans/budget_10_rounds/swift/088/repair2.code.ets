import { FontWeight } from '@kit.ArkUI'

interface Pattern {
  name: string
  inhale: number
  exhale: number
}

@Entry
@Component
struct Index {
  @State isPlaying: boolean = false
  @State scaleValue: number = 1.0
  @State rotationValue: number = 0
  @State selectedIndex: number = 0

  private patterns: Array<Pattern> = [
    { name: 'Relax', inhale: 4, exhale: 6 },
    { name: 'Balance', inhale: 4, exhale: 4 },
    { name: 'Focus', inhale: 2, exhale: 4 }
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        Blank().height(48)

        Row() {
          Text('ZenBreather')
            .fontColor('#333333')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
          Blank()
          Image($r('app.media.startIcon')) // Using available resource as placeholder for gear icon
            .width(24)
            .height(24)
            .fillColor('#999999')
        }.padding({ left: 24, right: 24 })

        Blank().height(60)

        Stack() {
          Stack() {
            Circle()
              .width(280)
              .height(280)
              .scale({ x: this.scaleValue, y: this.scaleValue })
              .fill('#E0F2F1') // Theme.accentTeal.opacity(0.1) approx

            Circle()
              .width(280)
              .height(280)
              .scale({ x: this.scaleValue, y: this.scaleValue })
              .stroke('#009688') // Theme.accentTeal
              .strokeWidth(2)

            ForEach(Array.from({ length: 8 }).map((_: void, i: number) => i), (i: number) => {
              Stack() {
                Rect()
                  .width(140)
                  .height(2)
                  .fill('#009688')
                  .opacity(0.4)
                  .offset({ x: 70, y: 0 })
                  .rotate({ angle: this.rotationValue + i * 45 })
                
                Circle()
                  .width(6)
                  .height(6)
                  .fill('#009688')
                  .offset({ x: 135, y: 0 })
                  .rotate({ angle: this.rotationValue + i * 45 })
              }
            })
          }

          Column() {
            Text(this.isPlaying ? 'Breathe' : 'Ready')
              .fontColor('#009688')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
            
            Text(`${this.patterns[this.selectedIndex].inhale}s In / ${this.patterns[this.selectedIndex].exhale}s Out`)
              .fontColor('#999999')
              .fontSize(14)
              .margin({ top: 8 })
          }
        }

        Blank()

        Column() {
          Text('Select Rhythm')
            .fontColor('#333333')
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .alignSelf(ItemAlign.Start)
            .margin({ bottom: 16 })

          Row() {
            ForEach(this.patterns, (pattern: Pattern, index: number) => {
              Button() {
                Stack() {
                  Rect()
                    .width(100)
                    .height(90)
                    .borderRadius(20)
                    .fill(index === this.selectedIndex ? '#E0F2F1' : '#F5F5F5')
                    .border({
                      width: 2,
                      color: index === this.selectedIndex ? '#009688' : 'transparent',
                      radius: 20
                    })

                  Column() {
                    if (index === this.selectedIndex) {
                      Image($r('app.media.startIcon')) // Placeholder for checkmark
                        .width(16)
                        .height(16)
                        .fillColor('#009688')
                        .margin({ bottom: 4 })
                    } else {
                      Blank().height(16)
                    }
                    
                    Text(pattern.name)
                      .fontColor(index === this.selectedIndex ? '#009688' : '#333333')
                      .fontSize(14)
                      .fontWeight(FontWeight.Bold)
                      
                    Text(' ')
                      .fontSize(16)
                  }
                }.width(100).height(90)
              }
              .onClick(() => {
                this.selectedIndex = index
              })
              .backgroundColor(Color.Transparent)
              .margin({ right: index < this.patterns.length - 1 ? 12 : 0 })
            })
          }
        }.padding({ left: 24, right: 24 })

        Blank().height(32)

        Button() {
          Row() {
            Text('START BREATHING')
              .fontColor('#FFFFFF')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .letterSpacing(1)
            
            Image($r('app.media.startIcon')) // Placeholder for play icon
              .width(24)
              .height(24)
              .fillColor('#FFFFFF')
              .margin({ left: 8 })
          }
        }
        .width('100%')
        .height(56)
        .backgroundColor('#333333')
        .borderRadius(28)
        .margin({ left: 32, right: 32, bottom: 32 })
        .onClick(() => {
          this.isPlaying = !this.isPlaying
        })
      }.width('100%').height('100%').backgroundColor('#FFFFFF')
    }.width('100%').height('100%')
  }
}