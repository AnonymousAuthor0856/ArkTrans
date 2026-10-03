// Color Palette Helper
function hexToColor(hex: string): ResourceColor {
  const cleanedHex = hex.replace('#', '');
  const r = parseInt(cleanedHex.substring(0, 2), 16);
  const g = parseInt(cleanedHex.substring(2, 4), 16);
  const b = parseInt(cleanedHex.substring(4, 6), 16);
  return `#${r.toString(16).padStart(2, '0')}${g.toString(16).padStart(2, '0')}${b.toString(16).padStart(2, '0')}FF`;
}

// Define Colors
const QF_BACKGROUND = hexToColor("FFFCF9");
const QF_CARD_BG = hexToColor("FFF5F0");
const QF_TEXT_DARK = hexToColor("291E17");
const QF_TEXT_SUB = hexToColor("6E6661");
const QF_TEXT_GOLD = hexToColor("FCD462");
const QF_HEADER_CIRCLE = hexToColor("FCE4D1");
const QF_PROGRESS_ORANGE = hexToColor("FF9642");
const QF_PROGRESS_TRACK = hexToColor("EBE6F5");
const QF_HINT_BG = hexToColor("FCECCF");
const QF_TRACKER_BG = hexToColor("FFE4CE");

// Custom Card Backgrounds matching SwiftUI's Color(red:green:blue:)
const QF_MAIN_CARD_BG = "#FFF3E8FF"; // Color(red: 1, green: 243/255, blue: 232/255)
const QF_OPTION_BG = "#FFE4CCFF"; // Color(red: 1, green: 228/255, blue: 204/255)
const QF_OPTION_BORDER = "#DFAA80FF"; // Color(red: 223/255, green: 170/255, blue: 128/255)

// MARK: - 1. Entry Point
@Entry
@Component
struct QuizForgeApp {
  build() {
    Stack() {
      // Global Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(QF_BACKGROUND)

      // Main Content
      Column() {
        // Header
        HeaderView()
          .padding({ top: 10, bottom: 10 })

        // ScrollView Content
        Scroll() {
          Column({ space: 30 }) {
            // Quiz Card Section
            Column() {
              // Card Header: Title + Progress
              Row() {
                Text("Citrus crafts")
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(QF_TEXT_DARK)
                
                Blank() // Spacer

                Text("45%")
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(QF_TEXT_GOLD)
              }
              .width('100%')
              .padding({ left: 24, right: 24, top: 24 })

              // Progress Bar
              Row({ space: 4 }) {
                // Filled Portion
                Column()
                  .width(100)
                  .height(5)
                  .backgroundColor(QF_PROGRESS_ORANGE)
                  .borderRadius(2.5)

                // Track Portion
                Stack({ alignContent: Alignment.End }) {
                  Column()
                    .width('100%')
                    .height(5)
                    .backgroundColor(QF_PROGRESS_TRACK)
                    .borderRadius(2.5)
                  
                  // Small orange dot at end for detail
                  Circle({ width: 4, height: 4 })
                    .fill(QF_PROGRESS_ORANGE)
                    .margin({ right: -2 })
                }
                .layoutWeight(1)
                .height(5)
              }
              .width('100%')
              .padding({ left: 24, right: 24, top: 10, bottom: 12 })

              // Question
              Text("Which zest carrier gives the brightest aroma when infused cold?")
                .fontSize(23)
                .fontWeight(FontWeight.Bold)
                .fontColor(QF_TEXT_DARK)
                .lineHeight(27) // Approx lineSpacing(4)
                .padding({ left: 24, right: 24, bottom: 24 })

              // Options
              Column({ space: 12 }) {
                OptionButton({ text: "Dried peel sachet" })
                OptionButton({ text: "Twist garnish" })
                OptionButton({ text: "Zester microplane" })
                OptionButton({ text: "Candied strip" })
              }
              .padding({ left: 24, right: 24, bottom: 24 })

              // Hint Tag
              Text("Hint: Think surface area")
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(QF_TEXT_DARK)
                .padding({ top: 10, bottom: 10, left: 16, right: 16 })
                .backgroundColor(QF_HINT_BG)
                .borderRadius(12)
                .margin({ left: 24, right: 24, bottom: 24 })
            }
            .width('100%')
            .backgroundColor(QF_MAIN_CARD_BG)
            .borderRadius(36)
            .alignItems(HorizontalAlign.Start)

            // Trackers Section
            Column({ space: 16 }) {
              Text("Trackers")
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(QF_TEXT_DARK)
                .margin({ left: 4 })

              Row({ space: 12 }) {
                TrackerCard({ label: "Current\nstreak", value: "5 days" })
                TrackerCard({ label: "Accuracy", value: "84%" })
                TrackerCard({ label: "Rank", value: "Top 12%" })
              }
              .width('100%')
            }
            .alignItems(HorizontalAlign.Start)
          }
          .padding({ left: 16, right: 16, bottom: 40 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .height('100%')
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
      Circle({ width: 48, height: 48 })
        .fill(QF_HEADER_CIRCLE)

      Blank() // Spacer

      Column({ space: 2 }) {
        Text("QuizForge")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text("Aroma sprint")
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(QF_TEXT_SUB)
      }

      Blank() // Spacer

      Circle({ width: 48, height: 48 })
        .fill(QF_HEADER_CIRCLE)
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
  }
}

@Component
struct OptionButton {
  private text: string = "";

  build() {
    Row() {
      Text(this.text)
        .fontSize(10) // Note: SwiftUI code had 10, likely a typo for 16-18, but kept faithful to source
        .fontWeight(FontWeight.Medium)
        .fontColor(QF_TEXT_DARK)
      
      Blank() // Spacer
    }
    .width('100%')
    .padding({ top: 14, bottom: 14, left: 18, right: 18 })
    .backgroundColor(QF_OPTION_BG)
    .borderRadius(16)
    .border({ width: 1, color: QF_OPTION_BORDER })
  }
}

@Component
struct TrackerCard {
  private label: string = "";
  private value: string = "";

  build() {
    Column() {
      Text(this.label)
        .fontSize(13)
        .fontWeight(FontWeight.Regular)
        .fontColor(QF_TEXT_SUB)

      Blank() // Spacer

      Text(this.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(QF_TEXT_DARK)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .minFontSize(14) // Approximation of minimumScaleFactor(0.8)
    }
    .layoutWeight(1)
    .height(100)
    .alignItems(HorizontalAlign.Start)
    .padding({ top: 20, bottom: 20, left: 16, right: 16 })
    .backgroundColor(QF_TRACKER_BG)
    .borderRadius(24)
  }
}