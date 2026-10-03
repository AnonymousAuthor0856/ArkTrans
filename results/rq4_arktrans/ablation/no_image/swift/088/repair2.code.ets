@Entry
@Component
struct Index {
  @State isPlaying: boolean = false
  @State rotation: number = 0
  @State scaleValue: number = 1
  @State currentPattern: BreathingPattern = { inhale: 4, exhale: 4, name: 'Box' }
  @State patterns: BreathingPattern[] = [
    { inhale: 4, exhale: 4, name: 'Box' },
    { inhale: 4, exhale: 8, name: 'Relax' },
    { inhale: 2, exhale: 2, name: 'Quick' }
  ]
  @State selectedIndex: number = 0

  build() {
    Stack() {
      // Theme Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F5F7') // Simulating Theme.background

      Column({ space: 0 }) {
        Blank().height(48)

        Row() {
          Text('ZenBreather')
            .fontColor('#1C1C1E') // Theme.textDark
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
          
          Blank()
          
          Image($r('app.media.startIcon')) // Using required resource
            .width(24)
            .height(24)
        }.padding({ left: 24, right: 24 })

        Blank().height(60)

        Stack() {
          // Animated Rings
          Stack() {
            Circle()
              .width(200)
              .height(200)
              .scaleEffect(this.scaleValue)
              .fill(Color.Transparent) // Placeholder for opacity fill logic if needed, usually shape fills are implicit or via modifier
            
            // Note: In ArkTS, we often use multiple shapes or a single shape with modifiers. 
            // To replicate the SwiftUI layering exactly:
            Circle()
              .width(200)
              .height(200)
              .scaleEffect(this.scaleValue)
              .fill(new Color('#00BFA5').withOpacity(0.1)) // Theme.accentTeal.opacity(0.1)

            Circle()
              .width(200)
              .height(200)
              .scaleEffect(this.scaleValue)
              .stroke(new Color('#00BFA5'), { width: 2 }) // Theme.accentTeal

            ForEach(Array.from({ length: 8 }, (_, i: number) => i), (i: number) => {
              Stack() {
                Rect()
                  .width(140)
                  .height(2)
                  .fill(new Color('#00BFA5').withOpacity(0.4))
                  .offset({ x: 70, y: 0 })
                  .rotate({ angle: this.rotation + i * 45 })
                  .scaleEffect(this.scaleValue)
                
                Circle()
                  .width(6)
                  .height(6)
                  .fill(new Color('#00BFA5'))
                  .offset({ x: 135, y: 0 })
                  .rotate({ angle: this.rotation + i * 45 })
                  .scaleEffect(this.scaleValue)
              }
            })
          }

          Column() {
            Text(this.isPlaying ? "Breathe" : "Ready")
              .fontColor('#00BFA5') // Theme.accentTeal
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
            
            Text(`${this.currentPattern.inhale}s In / ${this.currentPattern.exhale}s Out`)
              .fontColor('#8E8E93') // .gray
              .fontSize(14)
          }
        }

        Blank()

        Column() {
          Text('Select Rhythm')
            .fontColor('#1C1C1E') // Theme.textDark
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
          
          Row() {
            ForEach(this.patterns.map((p: BreathingPattern, index: number) => ({ ...p, index: index } as BreathingPatternWithIndex)), (item: BreathingPatternWithIndex) => {
              Button() {
                Column({ space: 4 }) {
                  if (item.index === this.selectedIndex) {
                    Image($r('app.media.startIcon')) // Reusing icon as checkmark placeholder since only one resource allowed
                      .width(16)
                      .height(16)
                  } else {
                    Blank().height(16) // Spacer to maintain alignment
                  }

                  Text(item.name)
                    .fontColor(item.index === this.selectedIndex ? '#00BFA5' : '#1C1C1E')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                  
                  Text(' ')
                    .fontSize(16)
                }
              }
              .onClick(() => {
                this.selectedIndex = item.index
                this.currentPattern = item
              })
              .width(100)
              .height(90)
              .margin({ right: 8 })
              .borderRadius(20)
              .backgroundColor(item.index === this.selectedIndex ? new Color('#00BFA5').withOpacity(0.05) : '#E5E5EA') // Theme.lightGray
              .borderWidth(item.index === this.selectedIndex ? 2 : 0)
              .borderColor(item.index === this.selectedIndex ? '#00BFA5' : Color.Transparent)
            })
          }
        }.padding({ left: 24, right: 24 })

        Blank().height(32)

        Button() {
          Text(this.isPlaying ? 'Stop' : 'Start')
            .fontColor('#FFFFFF')
        }
        .width('100%')
        .height(50)
        .backgroundColor('#00BFA5')
        .borderRadius(25)
        .margin({ left: 32, right: 32, bottom: 32 })
        .onClick(() => {
          this.isPlaying = !this.isPlaying
        })
      }
    }
    .width('100%')
    .height('100%')
  }
}

interface BreathingPattern {
  inhale: number
  exhale: number
  name: string
}

interface BreathingPatternWithIndex extends BreathingPattern {
  index: number
}