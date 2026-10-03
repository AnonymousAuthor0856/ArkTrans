import { router } from '@kit.ArkUI';

// Data Models
interface TeaGuide {
  id: number;
  name: string;
  origin: string;
  temp: string;
  time: string;
  colorCode: string;
}

const sampleTeas: TeaGuide[] = [
  { id: 1, name: "Sencha Green", origin: "Japan", temp: "70°C / 158°F", time: "1-2 min", colorCode: "#8BC34A" },
  { id: 2, name: "Earl Grey", origin: "Blend", temp: "95°C / 203°F", time: "3-5 min", colorCode: "#795548" },
  { id: 3, name: "Silver Needle", origin: "China", temp: "80°C / 176°F", time: "3-4 min", colorCode: "#9E9E9E" },
  { id: 4, name: "Darjeeling", origin: "India", temp: "90°C / 194°F", time: "3 min", colorCode: "#D7CCC8" },
  { id: 5, name: "Chamomile", origin: "Egypt", temp: "100°C / 212°F", time: "5-7 min", colorCode: "#FFEB3B" },
  { id: 6, name: "Matcha", origin: "Japan", temp: "80°C / 176°F", time: "Whisk", colorCode: "#4CAF50" },
  { id: 7, name: "Oolong", origin: "Taiwan", temp: "85°C / 185°F", time: "3-5 min", colorCode: "#FF9800" }
];

@Component
struct InfoBadge {
  label: string = '';

  build() {
    Text(this.label)
      .fontSize(11)
      .fontColor('#000000')
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor('#FFFFFF')
      .borderRadius(6)
      .border({ width: 1, color: '#E0E0E0' })
  }
}

@Component
struct PromoCard {
  build() {
    Row() {
      Column() {
        Text("Tip of the day")
          .fontSize(12)
          .fontColor('#9E9E9E')
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 4 })

        Text("Use filtered water for a purer taste profile.")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#121212')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank().width(16)

      Stack() {
        Text("ℹ")
          .fontSize(20)
          .fontColor('#9E9E9E')
      }
      .width(48)
      .height(48)
      .backgroundColor('#FFFFFF')
      .borderRadius(24)
      .alignContent(Alignment.Center)
    }
    .width('100%')
    .padding(24)
    .backgroundColor('#F0F0F0')
    .borderRadius(20)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TeaItemCard {
  tea: TeaGuide = { id: 0, name: '', origin: '', temp: '', time: '', colorCode: '#000000' };

  build() {
    Row() {
      // Circle avatar
      Stack() {
        Text(this.tea.name.charAt(0))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.tea.colorCode)
      }
      .width(50)
      .height(50)
      .backgroundColor('#FFFFFF')
      .borderRadius(25)
      .border({ width: 2, color: this.tea.colorCode })
      .alignContent(Alignment.Center)

      Blank().width(16)

      Column() {
        Text(this.tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor('#121212')

        Text(this.tea.origin)
          .fontSize(12)
          .fontColor('#757575')
          .margin({ bottom: 6 })

        Row() {
          InfoBadge({ label: this.tea.temp })
          Blank().width(8)
          InfoBadge({ label: this.tea.time })
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Play button
      Stack() {
        Text("▶")
          .fontSize(16)
          .fontColor('#121212')
      }
      .width(40)
      .height(40)
      .backgroundColor('#FFFFFF')
      .borderRadius(20)
      .border({ width: 1, color: '#E0E0E0' })
      .alignContent(Alignment.Center)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
    .alignItems(VerticalAlign.Center)
  }
}

@Entry
@Component
struct ZenBrewApp {
  build() {
    Column() {
      // Top App Bar
      Row() {
        Column() {
          Text("ZenBrew")
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#121212')
            .letterSpacing(-0.5)

          Text("Mindful Steeping Guide")
            .fontSize(14)
            .fontColor('#757575')
            .fontWeight(FontWeight.Normal)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        // Settings icon
        Stack() {
          Text("⚙")
            .fontSize(22)
            .fontColor('#121212')
        }
        .width(44)
        .height(44)
        .alignContent(Alignment.Center)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 16, bottom: 12 })
      .backgroundColor('#FFFFFF')
      .alignItems(VerticalAlign.Center)

      // Scrollable content
      Scroll() {
        Column() {
          // Promo Card
          PromoCard()
            .margin({ bottom: 16 })

          // Collections header
          Text("Collections")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#121212')
            .width('100%')
            .padding({ top: 8, bottom: 8 })
            .margin({ bottom: 8 })

          // Tea list
          ForEach(sampleTeas, (tea: TeaGuide) => {
            TeaItemCard({ tea: tea })
              .margin({ bottom: 16 })
          }, (tea: TeaGuide) => tea.id.toString())

          // Bottom spacer for FAB
          Blank().height(80)
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor('#FFFFFF')

      // FAB area
      Row() {
        Blank().layoutWeight(1)
        Row() {
          Text("+")
            .fontSize(20)
            .fontColor('#FFFFFF')
            .margin({ right: 6 })
          Text("Custom Brew")
            .fontSize(15)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Medium)
        }
        .height(56)
        .padding({ left: 20, right: 20 })
        .backgroundColor('#121212')
        .borderRadius(16)
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .margin({ right: 20, bottom: 20 })
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}