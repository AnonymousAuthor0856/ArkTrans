// ZenBrewApp.ets
interface TeaGuide {
  id: number;
  name: string;
  origin: string;
  temp: string;
  time: string;
  colorCode: ResourceColor;
}

// Helper function to convert hex to ArkUI Color
function hexToColor(hex: number): ResourceColor {
  return `#${hex.toString(16).padStart(8, '0')}`;
}

// Mock Tea Data
const sampleTeas: TeaGuide[] = [
  { id: 1, name: "Sencha Green", origin: "Japan", temp: "70°C / 158°F", time: "1-2 min", colorCode: hexToColor(0xFF8BC34A) },
  { id: 2, name: "Earl Grey", origin: "Blend", temp: "95°C / 203°F", time: "3-5 min", colorCode: hexToColor(0xFF795548) },
  { id: 3, name: "Silver Needle", origin: "China", temp: "80°C / 176°F", time: "3-4 min", colorCode: hexToColor(0xFFE0E0E0) },
  { id: 4, name: "Darjeeling", origin: "India", temp: "90°C / 194°F", time: "3 min", colorCode: hexToColor(0xFFD7CCC8) },
  { id: 5, name: "Chamomile", origin: "Egypt", temp: "100°C / 212°F", time: "5-7 min", colorCode: hexToColor(0xFFFFEB3B) },
  { id: 6, name: "Matcha", origin: "Japan", temp: "80°C / 176°F", time: "Whisk", colorCode: hexToColor(0xFF4CAF50) },
  { id: 7, name: "Oolong", origin: "Taiwan", temp: "85°C / 185°F", time: "3-5 min", colorCode: hexToColor(0xFFFF9800) }
];

@Entry
@Component
struct ZenBrewApp {
  private primaryBlack: ResourceColor = hexToColor(0xFF121212);
  private textGrey: ResourceColor = hexToColor(0xFF757575);
  private backgroundWhite: ResourceColor = Color.White;
  private cardBackground: ResourceColor = hexToColor(0xFFF9F9F9);
  private promoCardBackground: ResourceColor = hexToColor(0xFFF0F0F0);
  private lightGreyBorder: ResourceColor = hexToColor(0xFFEEEEEE);
  private veryLightGreyBorder: ResourceColor = hexToColor(0xFFE0E0E0);

  @Builder
  PromoCard() {
    Row() {
      Column() {
        Text("Tip of the day")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .margin({ bottom: 4 })
        Text("Use filtered water for a purer taste profile.")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.primaryBlack)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank().width(16)

      Stack() {
        Circle({ width: 48, height: 48 }).fill(Color.White)
        Image($r('sys.symbol.info'))
          .width(24).height(24)
          .fillColor(Color.Gray)
      }
    }
    .padding(24)
    .backgroundColor(this.promoCardBackground)
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  InfoBadge(label: string) {
    Text(label)
      .fontSize(11)
      .fontColor(Color.Black)
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor(Color.White)
      .borderRadius(6)
      .border({ width: 1, color: this.veryLightGreyBorder })
  }

  @Builder
  TeaItemCard(tea: TeaGuide) {
    Row() {
      // Left Circular Indicator
      Stack() {
        Circle({ width: 50, height: 50 })
          .fill(Color.White)
          .border({ width: 2, color: tea.colorCode })
        Text(tea.name.charAt(0))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(tea.colorCode)
      }

      Blank().width(16)

      // Center Text Content
      Column() {
        Text(tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.primaryBlack)
        Text(tea.origin)
          .fontSize(12)
          .fontColor(this.textGrey)
          .margin({ top: 2 })

        Blank().height(6)

        Row() {
          this.InfoBadge(tea.temp)
          Blank().width(8)
          this.InfoBadge(tea.time)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Right Play Button
      Button() {
        Image($r('sys.symbol.play'))
          .width(20).height(20)
          .fillColor(this.primaryBlack)
      }
      .type(ButtonType.Circle)
      .width(40).height(40)
      .backgroundColor(Color.White)
      .border({ width: 1, color: this.veryLightGreyBorder })
    }
    .padding(16)
    .backgroundColor(this.cardBackground)
    .borderRadius(16)
    .border({ width: 1, color: this.lightGreyBorder })
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // Main Scrollable Content
      Scroll() {
        Column({ space: 16 }) {
          // Top App Bar
          Row() {
            Column() {
              Text("ZenBrew")
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.primaryBlack)
                .letterSpacing(-0.5)
              Text("Mindful Steeping Guide")
                .fontSize(14)
                .fontColor(this.textGrey)
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)

            Blank() // Spacer

            Button() {
              Image($r('sys.symbol.gear'))
                .width(24).height(24)
                .fillColor(this.primaryBlack)
            }
            .type(ButtonType.Normal)
            .width(44).height(44)
            .backgroundColor(Color.Transparent)
          }
          .padding({ left: 20, right: 20, top: 10 })
          .alignItems(VerticalAlign.Top)

          // Promo Card
          Column() {
            this.PromoCard()
          }
          .padding({ left: 20, right: 20 })

          // Collections Title
          Text("Collections")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.primaryBlack)
            .width('100%')
            .padding({ top: 8, bottom: 8, left: 20, right: 20 })

          // Tea List
          ForEach(sampleTeas, (tea: TeaGuide) => {
            Column() {
              this.TeaItemCard(tea)
            }
            .padding({ left: 20, right: 20 })
          }, (tea: TeaGuide) => tea.id.toString())

          // Bottom Spacer for FAB
          Blank().height(80)
        }
        .padding({ top: 10, bottom: 10 })
      }
      .scrollBar(BarState.Off)
      .backgroundColor(this.backgroundWhite)
      .width('100%').height('100%')

      // Floating Action Button (FAB)
      Button() {
        Row({ space: 8 }) {
          Image($r('sys.symbol.plus'))
            .width(20).height(20)
            .fillColor(Color.White)
          Text("Custom Brew")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
        }
        .height(56)
        .padding({ left: 24, right: 24 })
      }
      .type(ButtonType.Normal)
      .backgroundColor(this.primaryBlack)
      .borderRadius(16)
      .margin({ right: 20, bottom: 20 })
    }
    .width('100%').height('100%')
    .backgroundColor(this.backgroundWhite)
  }
}