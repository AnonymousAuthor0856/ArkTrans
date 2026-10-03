// ZenBrew - Mindful Steeping Guide
// ArkTS conversion of SwiftUI ZenBrewApp

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

  build() {
    Stack() {
      Scroll() {
        Column({ space: 16 }) {
          // Top bar
          Row() {
            Column() {
              Text("ZenBrew")
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor("#121212")
                .letterSpacing(-0.5)
              Text("Mindful Steeping Guide")
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor("#757575")
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Image($r('sys.media.ohos_ic_public_settings'))
              .width(24)
              .height(24)
              .fillColor("#121212")
              .padding(10)
          }
          .width("100%")
          .padding({ left: 20, right: 20, top: 10 })

          // Promo card
          this.PromoCard()
            .padding({ left: 20, right: 20 })

          // Collections title
          Text("Collections")
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor("#121212")
            .width("100%")
            .padding({ left: 20, right: 20, top: 8, bottom: 8 })
            .textAlign(TextAlign.Start)

          // Tea list
          ForEach(this.sampleTeas, (tea: TeaGuide) => {
            this.TeaItemCard({ tea: tea })
              .padding({ left: 20, right: 20 })
          }, (tea: TeaGuide) => tea.id.toString())

          // Bottom spacer for FAB
          Blank()
            .height(80)
        }
        .padding({ top: 10, bottom: 10 })
      }
      .width("100%")
      .height("100%")
      .backgroundColor("#FFFFFF")
      .scrollBar(BarState.Off)

      // FAB - Custom Brew button
      Row({ space: 8 }) {
        Image($r('sys.media.ohos_ic_public_add'))
          .width(20)
          .height(20)
          .fillColor(Color.White)
        Text("Custom Brew")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
      }
      .height(56)
      .padding({ left: 24, right: 24 })
      .backgroundColor("#121212")
      .borderRadius(16)
      .position({ right: 20, bottom: 20 })
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#FFFFFF")
  }

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
          .fontColor("#121212")
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Stack() {
        Circle({ width: 48, height: 48 })
          .fill(Color.White)
        Image($r('sys.media.ohos_ic_public_info'))
          .width(24)
          .height(24)
          .fillColor(Color.Gray)
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
  TeaItemCard($$: { tea: TeaGuide }) {
    Row() {
      // Left circle with letter
      Stack() {
        Circle({ width: 50, height: 50 })
          .fill(Color.White)
          .stroke($$.tea.colorCode + "4D", 2)
        Text($$.tea.name.charAt(0))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor($$.tea.colorCode)
      }
      .width(50)
      .height(50)
      .clip(Circle)

      Blank(16)

      // Middle content
      Column() {
        Text($$.tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor("#121212")
        Text($$.tea.origin)
          .fontSize(12)
          .fontColor("#757575")
          .margin({ top: 2 })
        Blank(6)
        Row({ space: 8 }) {
          this.InfoBadge({ label: $$.tea.temp })
          this.InfoBadge({ label: $$.tea.time })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Right play button
      Stack() {
        Circle({ width: 40, height: 40 })
          .fill(Color.White)
          .stroke("#E0E0E0", 1)
        Image($r('sys.media.ohos_ic_public_play'))
          .width(20)
          .height(20)
          .fillColor("#121212")
      }
      .width(40)
      .height(40)
      .clip(Circle)
    }
    .width("100%")
    .padding(16)
    .backgroundColor("#F9F9F9")
    .borderRadius(16)
    .border({ width: 1, color: "#EEEEEE" })
  }

  @Builder
  InfoBadge($$: { label: string }) {
    Text($$.label)
      .fontSize(11)
      .fontColor(Color.Black)
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor(Color.White)
      .borderRadius(6)
      .border({ width: 1, color: "#E0E0E0" })
  }
}

interface TeaGuide {
  id: number;
  name: string;
  origin: string;
  temp: string;
  time: string;
  colorCode: string;
}
