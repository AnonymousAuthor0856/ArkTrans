import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - 1. Entry Point
@Entry
@Component
struct QuizForgeApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color('#FFFCF9')) // qfBackground
    .statusBarMode(StatusBarMode.Custom)
    .statusBarColor(Color.Transparent)
  }
}

// MARK: - 2. Color Palette Constants
const QF_COLORS = {
  Background: '#FFFCF9',
  CardBg: '#FFF5F0',
  TextDark: '#291E17',
  TextSub: '#6E6661',
  TextGold: '#FCD462',
  HeaderCircle: '#FCE4D1',
  ProgressOrange: '#FF9642',
  ProgressTrack: '#EBE6F5',
  OptionBg: '#FDECD9',
  OptionBorder: '#EBCBA6',
  HintBg: '#FCECCF',
  TrackerBg: '#FFE4CE'
};

// MARK: - 3. Main Content View
@Component
struct ContentView {
  build() {
    Column() {
      HeaderView()
        .padding({ top: 10, bottom: 10 })

      Scroll() {
        Column() {
          // Quiz Card Section
          Column({ align: HorizontalAlign.Start }) {
            // Card Header: Title + Progress
            Row() {
              Text("Citrus crafts")
                .fontSize(18)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(Color(QF_COLORS.TextDark))
              Blank()
              Text("45%")
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color(QF_COLORS.TextGold))
            }
            .padding({ left: 24, right: 24, top: 24 })

            // Progress Bar
            Row() {
              Capsule()
                .fill(Color(QF_COLORS.ProgressOrange))
                .width(100)
                .height(5)
              
              Capsule()
                .fill(Color(QF_COLORS.ProgressTrack))
                .layoutWeight(1)
                .height(5)
                .overlay(
                  Circle()
                    .fill(Color(QF_COLORS.ProgressOrange))
                    .width(4)
                    .height(4)
                    .position({ x: '100%', y: '50%' })
                    .margin({ right: 2 })
                )
            }
            .padding({ left: 24, right: 24, top: 10, bottom: 12 })

            // Question
            Text("Which zest carrier gives the brightest aroma when infused cold?")
              .fontSize(23)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color(QF_COLORS.TextDark))
              .lineHeight(27) // Approximate lineSpacing(4) on size 23
              .padding({ left: 24, right: 24, bottom: 24 })

            // Options
            Column() {
              OptionButton(text: "Dried peel sachet")
              OptionButton(text: "Twist garnish")
              OptionButton(text: "Zester microplane")
              OptionButton(text: "Candied strip")
            }
            .spacing(12)
            .padding({ left: 24, right: 24, bottom: 24 })

            // Hint Tag
            Text("Hint: Think surface area")
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color(QF_COLORS.TextDark))
              .padding({ top: 10, bottom: 10, left: 16, right: 16 })
              .backgroundColor(Color(QF_COLORS.HintBg))
              .borderRadius(12)
              .alignSelf(ItemAlign.Start)
              .padding({ left: 24, right: 24, bottom: 24 })

          }
          .backgroundColor(Color('#FFFFF3E8')) // Converted RGB(1, 243/255, 232/255) to Hex approx
          .borderRadius(36)

          // Trackers Section
          Column({ align: HorizontalAlign.Start }) {
            Text("Trackers")
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color(QF_COLORS.TextDark))
              .padding({ left: 4 })

            Row() {
              TrackerCard(label: "Current\nstreak", value: "5 days")
              TrackerCard(label: "Accuracy", value: "84%")
              TrackerCard(label: "Rank", value: "Top 12%")
            }
            .spacing(12)
          }
          .alignItems(HorizontalAlign.Start)
          .spacing(16)
        }
        .padding({ left: 16, right: 16, bottom: 40 })
        .spacing(30)
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - 4. Components

@Component
struct HeaderView {
  build() {
    Row() {
      Circle()
        .fill(Color(QF_COLORS.HeaderCircle))
        .width(48)
        .height(48)
      
      Blank()
      
      Column() {
        Text("QuizForge")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        
        Text("Aroma sprint")
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(Color(QF_COLORS.TextSub))
      }
      .spacing(2)
      
      Blank()
      
      Circle()
        .fill(Color(QF_COLORS.HeaderCircle))
        .width(48)
        .height(48)
    }
    .padding({ left: 24, right: 24 })
  }
}

@Component
struct OptionButton {
  controller: string = "";
  
  aboutToAppear() {
    // This is a placeholder for potential state if needed later
  }

  @Builder
  optionContent(text: string) {
    Row() {
      Text(text)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color(QF_COLORS.TextDark))
      Blank()
    }
    .padding({ top: 14, bottom: 14, left: 18, right: 18 })
    .backgroundColor(Color('#FFFFE4CC')) // Converted RGB(1, 228/255, 204/255)
    .borderRadius(16)
    .border({ width: 1, color: Color('#FFEFAA80'), radius: 16 }) // Converted RGB(223/255, 170/255, 128/255)
  }

  build() {
    this.optionContent(this.controller)
  }
}

@Component
struct TrackerCard {
  label: string = "";
  value: string = "";

  build() {
    Column({ align: HorizontalAlign.Start }) {
      Text(this.label)
        .fontSize(13)
        .fontWeight(FontWeight.Regular)
        .fontColor(Color(QF_COLORS.TextSub))
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
      
      Blank()
      
      Text(this.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color(QF_COLORS.TextDark))
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .padding({ top: 20, bottom: 20, left: 16, right: 16 })
    .width('100%')
    .minHeight(100)
    .backgroundColor(Color(QF_COLORS.TrackerBg))
    .borderRadius(24)
  }
}