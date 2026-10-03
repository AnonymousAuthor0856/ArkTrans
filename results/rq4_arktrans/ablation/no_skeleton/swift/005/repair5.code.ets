@Entry
@Component
struct QuizApp {
  @State selected: number = -1
  @State reviewed: boolean = false
  private options: string[] = ['Earth', 'Mars', 'Venus', 'Jupiter']

  build() {
    Column() {
      // Top App Bar
      Row() {
        // Icon placeholder (using Image as per rules, though SwiftUI used RoundedRectangle)
        Image($r('app.media.startIcon'))
          .width(20)
          .height(20)
          .borderRadius(6)
          .objectFit(ImageFit.Cover)
        
        Text('Quiz')
          .fontSize(24)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#0B1220')
      }
      .justifyContent(FlexAlign.Center)
      .padding({ top: 24, bottom: 16, left: 8, right: 8 })
      .width('100%')

      // Scrollable Content
      Scroll() {
        Column() {
          // Card Container
          Column() {
            // Question Header Box
            Stack() {
              Rect()
                .fill('#F1F5F9')
                .borderRadius(8)
              
              Text('Question 1/4')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
            }
            .width('100%')
            .height(120)

            // Question Text
            Text('Which planet is known as the Red Planet?')
              .fontSize(18)
              .fontWeight(FontWeight.SemiBold)
              .fontColor('#0B1220')
              .margin({ top: 8 })
              .width('100%')

            // Options List
            Column() {
              ForEach(this.options, (item: string, index: number) => {
                this.OptionButton(item, index)
              })
            }
            .margin({ top: 8 })
          }
          .padding(8)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .border({ width: 1, color: '#E2E8F0' })
          .shadow({ radius: 3, color: '#14000000', offsetY: 1 })
          .margin({ left: 8, right: 8 })

          // Selected + Skip Section
          Row() {
            Column() {
              Text('Selected')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
              
              Text(this.selected === -1 ? 'None' : this.options[this.selected])
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
            }
            
            Blank()
            
            Button('Skip')
            .onClick(() => {
              // Skip action
            })
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
            .backgroundColor('#FFFFFF')
            .border({ width: 1, color: '#E2E8F0' })
            .borderRadius(6)
            .padding({ left: 14, right: 14, top: 10, bottom: 10 })
          }
          .width('100%')
          .margin({ top: 8, left: 8, right: 8 })
        }
        .padding({ top: 6, bottom: 120 })
      }
      .layoutWeight(1)

      // Bottom Bar
      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FAFAFF')
  }

  @Builder
  OptionButton(text: string, index: number) {
    Button(text)
      .onClick(() => {
        this.selected = index
      })
      .fontSize(index === this.selected ? 14 : 12)
      .fontWeight(FontWeight.Medium)
      .fontColor(index === this.selected ? '#FFFFFF' : '#0B1220')
      .backgroundColor(index === this.selected ? '#7C3AED' : '#FFFFFF')
      .border({ width: 1, color: '#E2E8F0' })
      .borderRadius(8)
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .margin({ bottom: 6 })
      .alignSelf(ItemAlign.Start)
  }

  @Builder
  BottomBar() {
    Row() {
      // Progress Section
      Column() {
        Text('Progress')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
        
        Row() {
          // Background track
          Rect()
            .fill('#F1F5F9')
            .borderRadius(3)
          
          // Foreground progress
          Rect()
            .fill('#7C3AED')
            .borderRadius(3)
            .width('25%') // Mocking 0.25 progress
        }
        .width(140)
        .height(6)
        .clipShape(RoundedRectangle())
      }

      Blank()

      // Review Chip
      Button('Review')
        .onClick(() => {
          this.reviewed = !this.reviewed
        })
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.reviewed ? '#0F172A' : '#0B1220')
        .backgroundColor(this.reviewed ? '#22C55E' : '#FFFFFF')
        .border({ width: 1, color: '#E2E8F0' })
        .borderRadius(6)
        .padding({ left: 14, right: 14, top: 10, bottom: 10 })
      
      // Next Button
      Button('Next')
        .onClick(() => {
          // Next action
        })
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#7C3AED')
        .borderRadius(12)
        .width(140)
        .height(44)
        .margin({ left: 8 })
    }
    .width('100%')
    .padding({ left: 8, right: 8, top: 6, bottom: 6 })
    .backgroundColor('#FAFAFF')
  }
}