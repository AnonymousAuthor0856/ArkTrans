// MARK: - 1. Entry Point

// Helper to format a byte as a two-digit hex string (used by colorFromHex).
function toHexByte(value: number): string {
  const s: string = value.toString(16).toUpperCase();
  return s.length < 2 ? '0' + s : s;
}

// MARK: - 5. Helper: Hex Color Initializer
// Translates Color(hex:) behavior. Alpha (from ARGB inputs) is dropped because
// the palette below only uses opaque colors.
function colorFromHex(hex: string): string {
  let cleaned: string = '';
  for (let i = 0; i < hex.length; i++) {
    const ch: string = hex.charAt(i);
    if ((ch >= '0' && ch <= '9') || (ch >= 'a' && ch <= 'f') || (ch >= 'A' && ch <= 'F')) {
      cleaned += ch;
    }
  }
  let intVal: number = 0;
  if (cleaned.length > 0) {
    intVal = parseInt(cleaned, 16);
  }
  let r: number = 0;
  let g: number = 0;
  let b: number = 0;
  switch (cleaned.length) {
    case 3: // RGB (12-bit)
      r = ((intVal >> 8) & 0xF) * 17;
      g = ((intVal >> 4) & 0xF) * 17;
      b = (intVal & 0xF) * 17;
      break;
    case 6: // RGB (24-bit)
      r = (intVal >> 16) & 0xFF;
      g = (intVal >> 8) & 0xFF;
      b = intVal & 0xFF;
      break;
    case 8: // ARGB (32-bit)
      r = (intVal >> 16) & 0xFF;
      g = (intVal >> 8) & 0xFF;
      b = intVal & 0xFF;
      break;
    default:
      r = 0;
      g = 0;
      b = 0;
      break;
  }
  return '#' + toHexByte(r) + toHexByte(g) + toHexByte(b);
}

// MARK: - 2. Color Palette
class AppColor {
  static readonly qfBackground: string = colorFromHex('FFFCF9'); // Global background
  static readonly qfCardBg: string = colorFromHex('FFF5F0'); // Main Card Background

  static readonly qfTextDark: string = colorFromHex('291E17'); // Dark Brown Text
  static readonly qfTextSub: string = colorFromHex('6E6661'); // Gray Text
  static readonly qfTextGold: string = colorFromHex('FCD462'); // 45% text

  static readonly qfHeaderCircle: string = colorFromHex('FCE4D1');

  static readonly qfProgressOrange: string = colorFromHex('FF9642');
  static readonly qfProgressTrack: string = colorFromHex('EBE6F5');

  static readonly qfOptionBg: string = colorFromHex('FDECD9'); // Peach button fill
  static readonly qfOptionBorder: string = colorFromHex('EBCBA6'); // Darker peach border

  static readonly qfHintBg: string = colorFromHex('FCECCF');

  static readonly qfTrackerBg: string = colorFromHex('FFE4CE'); // Tracker Card Bg
}

@Entry
@Component
struct QuizForgeApp {
  build() {
    // preferredColorScheme(.light) has no direct page-level ArkUI equivalent.
    // The @Entry build root must be a container component, so wrap ContentView.
    Stack({ alignContent: Alignment.Center }) {
      ContentView()
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - 3. Main Content View
@Component
struct ContentView {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Column({ space: 0 }) {
        // Header
        HeaderView()
          .padding({ top: 10, bottom: 10 })

        Scroll() {
          Column({ space: 30 }) {
            // Quiz Card Section
            Column({ space: 0 }) {
              // Card Header: Title + Progress
              Row() {
                Text('Citrus crafts')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold) // .semibold -> Bold (closest ArkUI weight)
                  .fontColor(AppColor.qfTextDark)
                Blank()
                Text('45%')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(AppColor.qfTextGold)
              }
              .width('100%')
              .padding({ left: 24, right: 24, top: 24 })

              // Progress Bar
              Row({ space: 4 }) {
                Row()
                  .width(100)
                  .height(5)
                  .backgroundColor(AppColor.qfProgressOrange)
                  .borderRadius(5)

                Stack({ alignContent: Alignment.End }) {
                  Row()
                    .width('100%')
                    .height(5)
                    .backgroundColor(AppColor.qfProgressTrack)
                    .borderRadius(5)
                  Circle({ width: 4, height: 4 })
                    .fill(AppColor.qfProgressOrange)
                    .offset({ x: 2 })
                }
                .height(5)
                .layoutWeight(1)
              }
              .width('100%')
              .padding({ left: 24, right: 24, top: 10, bottom: 12 })

              // Question
              Text('Which zest carrier gives the brightest aroma when infused cold?')
                .fontSize(23)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppColor.qfTextDark)
                .lineHeight(32) // lineSpacing(4) -> approximate line height
                .padding({ left: 24, right: 24, bottom: 24 })

              // Options
              Column({ space: 12 }) {
                OptionButton({ text: 'Dried peel sachet' })
                OptionButton({ text: 'Twist garnish' })
                OptionButton({ text: 'Zester microplane' })
                OptionButton({ text: 'Candied strip' })
              }
              .width('100%')
              .padding({ left: 24, right: 24, bottom: 24 })

              // Hint Tag
              Text('Hint: Think surface area')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColor.qfTextDark)
                .padding({ top: 10, bottom: 10, left: 16, right: 16 })
                .backgroundColor(AppColor.qfHintBg)
                .borderRadius(12)
                .margin({ left: 24, right: 24, bottom: 24 })
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .backgroundColor('#FFF3E8') // Color(red: 1, green: 243/255, blue: 232/255)
            .borderRadius(36)

            // Trackers Section
            Column({ space: 16 }) {
              Text('Trackers')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppColor.qfTextDark)
                .margin({ left: 4 })

              Row({ space: 12 }) {
                TrackerCard({ label: 'Current\nstreak', value: '5 days' })
                TrackerCard({ label: 'Accuracy', value: '84%' })
                TrackerCard({ label: 'Rank', value: 'Top 12%' })
              }
              .width('100%')
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 40 })
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColor.qfBackground)
    // statusBar(hidden: true) is controlled by the system UI in ArkUI.
  }
}

// MARK: - 4. Components

@Component
struct HeaderView {
  build() {
    Row() {
      Circle({ width: 48, height: 48 })
        .fill(AppColor.qfHeaderCircle)

      Blank()

      Column({ space: 2 }) {
        Text('QuizForge')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text('Aroma sprint')
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColor.qfTextSub)
      }

      Blank()

      Circle({ width: 48, height: 48 })
        .fill(AppColor.qfHeaderCircle)
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
  }
}

@Component
struct OptionButton {
  text: string = '';

  build() {
    Row() {
      Text(this.text)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColor.qfTextDark)
      Blank()
    }
    .width('100%')
    .padding({ top: 14, bottom: 14, left: 18, right: 18 })
    .backgroundColor('#FFE4CC') // Color(red: 1, green: 228/255, blue: 204/255)
    .borderRadius(16)
    .border({ width: 1, color: '#DFAA80', radius: 16 }) // stroke Color(red: 223/255, green: 170/255, blue: 128/255)
  }
}

@Component
struct TrackerCard {
  label: string = '';
  value: string = '';

  build() {
    Column({ space: 8 }) {
      Text(this.label)
        .fontSize(13)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColor.qfTextSub)

      Blank()

      Text(this.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColor.qfTextDark)
        .minFontSize(14) // minimumScaleFactor(0.8)
    }
    .alignItems(HorizontalAlign.Start)
    .padding({ top: 20, bottom: 20, left: 16, right: 16 })
    .layoutWeight(1)
    .constraintSize({ minHeight: 100 })
    .backgroundColor(AppColor.qfTrackerBg)
    .borderRadius(24)
  }
}
