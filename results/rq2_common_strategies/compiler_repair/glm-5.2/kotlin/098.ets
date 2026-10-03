// Index.ets

interface TeaGuide {
  id: number;
  name: string;
  origin: string;
  temp: string;
  time: string;
  colorCode: ResourceColor;
}

const sampleTeas: TeaGuide[] = [
  { id: 1, name: "Sencha Green", origin: "Japan", temp: "70°C / 158°F", time: "1-2 min", colorCode: "#8BC34A" },
  { id: 2, name: "Earl Grey", origin: "Blend", temp: "95°C / 203°F", time: "3-5 min", colorCode: "#795548" },
  { id: 3, name: "Silver Needle", origin: "China", temp: "80°C / 176°F", time: "3-4 min", colorCode: "#E0E0E0" },
  { id: 4, name: "Darjeeling", origin: "India", temp: "90°C / 194°F", time: "3 min", colorCode: "#D7CCC8" },
  { id: 5, name: "Chamomile", origin: "Egypt", temp: "100°C / 212°F", time: "5-7 min", colorCode: "#FFEB3B" },
  { id: 6, name: "Matcha", origin: "Japan", temp: "80°C / 176°F", time: "Whisk", colorCode: "#4CAF50" },
  { id: 7, name: "Oolong", origin: "Taiwan", temp: "85°C / 185°F", time: "3-5 min", colorCode: "#FF9800" }
];

@Entry
@Component
struct ZenBrewApp {
  private primaryBlack: string = "#121212";
  private textGrey: string = "#757575";
  private backgroundWhite: string = "#FFFFFF";
  private cardBackground: string = "#F9F9F9";

  @Builder
  TopBar() {
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
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Image($r("sys.media.ohos_ic_public_settings"))
        .width(24)
        .height(24)
        .fillColor(this.primaryBlack)
        .margin({ right: 12 })
    }
    .width('100%')
    .height(56)
    .padding({ left: 20, right: 12 })
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

      Row() {
        Text("i")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
      }
      .width(48)
      .height(48)
      .backgroundColor(this.backgroundWhite)
      .borderRadius(24)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(24)
    .backgroundColor("#F0F0F0")
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  InfoBadge(label: string) {
    Text(label)
      .fontSize(11)
      .fontColor(Color.Black)
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor(this.backgroundWhite)
      .borderRadius(6)
      .border({ width: 1, color: "#E0E0E0" })
  }

  @Builder
  TeaItemCard(tea: TeaGuide) {
    Row() {
      // Visual Dot identifier
      Stack() {
        Text(tea.name.charAt(0))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(tea.colorCode)
      }
      .width(50)
      .height(50)
      .backgroundColor(this.backgroundWhite)
      .borderRadius(25)
      .border({ width: 2, color: tea.colorCode as string })

      Column() {
        Text(tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.primaryBlack)
        Text(tea.origin)
          .fontSize(12)
          .fontColor(this.textGrey)
          .margin({ top: 2 })

        Row() {
          this.InfoBadge(tea.temp)
          this.InfoBadge(tea.time)
        }
        .margin({ top: 6 })
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      // Play Button
      Stack() {
        Image($r("sys.media.ohos_ic_public_play"))
          .width(20)
          .height(20)
          .fillColor(this.primaryBlack)
      }
      .width(40)
      .height(40)
      .backgroundColor(this.backgroundWhite)
      .borderRadius(20)
      .border({ width: 1, color: "#E0E0E0" })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(this.cardBackground)
    .borderRadius(16)
    .border({ width: 1, color: "#EEEEEE" })
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopBar()

        Scroll() {
          Column() {
            // Promo Card
            this.PromoCard()

            // Collections Header
            Text("Collections")
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.primaryBlack)
              .margin({ top: 16, bottom: 8 })
              .width('100%')

            // Tea List
            ForEach(sampleTeas, (tea: TeaGuide) => {
              this.TeaItemCard(tea)
              Blank().height(16)
            })

            // Extra spacer for FAB
            Blank().height(80)
          }
          .width('100%')
          .padding({ left: 20, right: 20, top: 10, bottom: 10 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.Top)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.backgroundWhite)

      // Floating Action Button
      Row() {
        Text("+")
          .fontSize(22)
          .fontColor(Color.White)
          .margin({ right: 8 })

        Text("Custom Brew")
          .fontSize(16)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Medium)
      }
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .backgroundColor(this.primaryBlack)
      .borderRadius(16)
      .margin({ right: 20, bottom: 24 })
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}