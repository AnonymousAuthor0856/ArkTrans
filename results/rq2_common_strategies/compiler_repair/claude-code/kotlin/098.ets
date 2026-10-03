@Entry
@Component
struct ZenBrewApp {
  @State sampleTeas: TeaGuide[] = [
    { id: 1, name: "Sencha Green", origin: "Japan", temp: "70°C / 158°F", time: "1-2 min", colorCode: "#8BC34A" },
    { id: 2, name: "Earl Grey", origin: "Blend", temp: "95°C / 203°F", time: "3-5 min", colorCode: "#795548" },
    { id: 3, name: "Silver Needle", origin: "China", temp: "80°C / 176°F", time: "3-4 min", colorCode: "#E0E0E0" },
    { id: 4, name: "Darjeeling", origin: "India", temp: "90°C / 194°F", time: "3 min", colorCode: "#D7CCC8" },
    { id: 5, name: "Chamomile", origin: "Egypt", temp: "100°C / 212°F", time: "5-7 min", colorCode: "#FFEB3B" },
    { id: 6, name: "Matcha", origin: "Japan", temp: "80°C / 176°F", time: "Whisk", colorCode: "#4CAF50" },
    { id: 7, name: "Oolong", origin: "Taiwan", temp: "85°C / 185°F", time: "3-5 min", colorCode: "#FF9800" }
  ]

  private readonly primaryBlack: string = "#121212"
  private readonly textGrey: string = "#757575"
  private readonly backgroundWhite: string = "#FFFFFF"
  private readonly cardBackground: string = "#F9F9F9"

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
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
              .fontWeight(FontWeight.Normal)
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Text("⚙")
            .fontSize(24)
            .fontColor(this.primaryBlack)
        }
        .width("100%")
        .padding({ left: 20, right: 20, top: 12, bottom: 12 })
        .backgroundColor(this.backgroundWhite)

        // Scrollable content
        List({ space: 16 }) {
          // Promo Card
          ListItem() {
            this.PromoCard()
          }

          // Collections header
          ListItem() {
            Text("Collections")
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.primaryBlack)
              .padding({ top: 8, bottom: 8 })
          }

          // Tea items
          ForEach(this.sampleTeas, (tea: TeaGuide) => {
            ListItem() {
              this.TeaItemCard(tea)
            }
          }, (tea: TeaGuide) => tea.id.toString())

          // Bottom spacer for FAB
          ListItem() {
            Column() {
              Blank()
                .height(80)
            }
          }
        }
        .width("100%")
        .layoutWeight(1)
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })
        .scrollBar(BarState.Off)
      }
      .width("100%")
      .height("100%")
      .backgroundColor(this.backgroundWhite)

      // Custom Brew FAB button
      Row() {
        Button() {
          Row({ space: 8 }) {
            Text("+")
              .fontSize(20)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
            Text("Custom Brew")
              .fontSize(14)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Medium)
          }
          .alignItems(VerticalAlign.Center)
        }
        .type(ButtonType.Normal)
        .height(56)
        .borderRadius(16)
        .backgroundColor(this.primaryBlack)
        .shadow({
          radius: 12,
          color: "rgba(0,0,0,0.15)",
          offsetX: 0,
          offsetY: 4
        })
      }
      .width("100%")
      .justifyContent(FlexAlign.Center)
      .padding({ bottom: 24 })
      .align(Alignment.Bottom)
    }
    .width("100%")
    .height("100%")
    .backgroundColor(this.backgroundWhite)
  }

  @Builder
  PromoCard() {
    Row() {
      Column() {
        Text("Tip of the day")
          .fontSize(12)
          .fontColor(Color.Gray)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 4 })
        Text("Use filtered water for a purer taste profile.")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.primaryBlack)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Blank()
        .width(16)

      // Info icon circle
      Stack({ alignContent: Alignment.Center }) {
        Circle({ width: 48, height: 48 })
          .fill(Color.White)
          .stroke("rgba(0,0,0,0.05)")
          .strokeWidth(1)
        Text("i")
          .fontSize(22)
          .fontColor(Color.Gray)
          .fontStyle(FontStyle.Italic)
          .fontWeight(FontWeight.Bold)
      }
      .width(48)
      .height(48)
    }
    .width("100%")
    .padding(24)
    .backgroundColor("#F0F0F0")
    .borderRadius(20)
  }

  @Builder
  TeaItemCard(tea: TeaGuide) {
    Row() {
      // Color dot with initial
      Stack({ alignContent: Alignment.Center }) {
        Circle({ width: 50, height: 50 })
          .fill(Color.White)
          .stroke(this.hexWithAlpha(tea.colorCode, 0.3))
          .strokeWidth(2)
        Text(tea.name.charAt(0))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(tea.colorCode)
      }
      .width(50)
      .height(50)

      Blank()
        .width(16)

      Column() {
        Text(tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.primaryBlack)
        Text(tea.origin)
          .fontSize(12)
          .fontColor(this.textGrey)
        Blank()
          .height(6)
        Row({ space: 8 }) {
          this.InfoBadge(tea.temp)
          this.InfoBadge(tea.time)
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // Play button
      Stack({ alignContent: Alignment.Center }) {
        Circle({ width: 40, height: 40 })
          .fill(Color.White)
          .stroke("#E0E0E0")
          .strokeWidth(1)
        Text("▶")
          .fontSize(16)
          .fontColor(this.primaryBlack)
          .margin({ left: 2 })
      }
      .width(40)
      .height(40)
    }
    .width("100%")
    .padding(16)
    .backgroundColor(this.cardBackground)
    .borderRadius(16)
    .border({ width: 1, color: "#EEEEEE" })
  }

  @Builder
  InfoBadge(label: string) {
    Text(label)
      .fontSize(11)
      .fontColor(Color.Black)
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor(Color.White)
      .borderRadius(6)
      .border({ width: 1, color: "#E0E0E0" })
  }

  private hexWithAlpha(hex: string, alpha: number): string {
    const r = parseInt(hex.slice(1, 3), 16)
    const g = parseInt(hex.slice(3, 5), 16)
    const b = parseInt(hex.slice(5, 7), 16)
    return `rgba(${r}, ${g}, ${b}, ${alpha})`
  }
}

interface TeaGuide {
  id: number
  name: string
  origin: string
  temp: string
  time: string
  colorCode: string
}
