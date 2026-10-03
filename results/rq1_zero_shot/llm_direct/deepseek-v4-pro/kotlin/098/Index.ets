import { UIAbility } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct ZenBrewApp {
  @State sampleTeas: TeaGuide[] = [
    new TeaGuide(1, "Sencha Green", "Japan", "70°C / 158°F", "1-2 min", "#8BC34A"),
    new TeaGuide(2, "Earl Grey", "Blend", "95°C / 203°F", "3-5 min", "#795548"),
    new TeaGuide(3, "Silver Needle", "China", "80°C / 176°F", "3-4 min", "#E0E0E0"),
    new TeaGuide(4, "Darjeeling", "India", "90°C / 194°F", "3 min", "#D7CCC8"),
    new TeaGuide(5, "Chamomile", "Egypt", "100°C / 212°F", "5-7 min", "#FFEB3B"),
    new TeaGuide(6, "Matcha", "Japan", "80°C / 176°F", "Whisk", "#4CAF50"),
    new TeaGuide(7, "Oolong", "Taiwan", "85°C / 185°F", "3-5 min", "#FF9800")
  ];

  @Builder
  TopBar() {
    Row() {
      Column() {
        Text("ZenBrew")
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor("#121212")
          .letterSpacing(-0.5)
        Text("Mindful Steeping Guide")
          .fontSize(14)
          .fontColor("#757575")
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Button() {
        Text("⚙")
          .fontSize(20)
          .fontColor("#121212")
      }
      .width(40)
      .height(40)
      .backgroundColor(Color.Transparent)
      .padding(0)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor("#FFFFFF")
  }

  @Builder
  PromoCard() {
    Row() {
      Column() {
        Text("Tip of the day")
          .fontSize(12)
          .fontColor("#9E9E9E")
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 4 })
        Text("Use filtered water for a purer taste profile.")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor("#121212")
      }
      .layoutWeight(1)

      Column() {
        Text("ⓘ")
          .fontSize(24)
          .fontColor("#9E9E9E")
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor("#FFFFFF")
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .padding(24)
    .backgroundColor("#F0F0F0")
    .borderRadius(20)
  }

  @Builder
  InfoBadge(label: string) {
    Text(label)
      .fontSize(11)
      .fontColor("#000000")
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor("#FFFFFF")
      .borderRadius(6)
      .border({ width: 1, color: "#E0E0E0" })
  }

  @Builder
  TeaItemCard(tea: TeaGuide) {
    Row() {
      Column() {
        Text(tea.name.substring(0, 1))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(tea.colorCode)
      }
      .width(50)
      .height(50)
      .borderRadius(25)
      .backgroundColor("#FFFFFF")
      .border({ width: 2, color: tea.colorCode + '4D' })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Column() {
        Text(tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor("#121212")
        Text(tea.origin)
          .fontSize(12)
          .fontColor("#757575")
        Row() {
          this.InfoBadge(tea.temp)
          Blank().width(8)
          this.InfoBadge(tea.time)
        }
        .margin({ top: 6 })
      }
      .layoutWeight(1)
      .margin({ left: 16 })
      .alignItems(HorizontalAlign.Start)

      Button() {
        Text("▶")
          .fontSize(16)
          .fontColor("#121212")
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor("#FFFFFF")
      .border({ width: 1, color: "#E0E0E0" })
      .padding(0)
    }
    .width('100%')
    .padding(16)
    .backgroundColor("#F9F9F9")
    .borderRadius(16)
    .border({ width: 1, color: "#EEEEEE" })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopBar()

        List({ space: 16 }) {
          ListItem() {
            this.PromoCard()
          }

          ListItem() {
            Text("Collections")
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor("#121212")
              .margin({ top: 8, bottom: 8 })
          }

          ForEach(this.sampleTeas, (tea: TeaGuide) => {
            ListItem() {
              this.TeaItemCard(tea)
            }
          }, (tea: TeaGuide) => tea.id.toString())

          ListItem() {
            Blank()
              .height(80)
          }
        }
        .width('100%')
        .height('100%')
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })
        .backgroundColor("#FFFFFF")
      }
      .width('100%')
      .height('100%')

      Button() {
        Row() {
          Text("+")
            .fontSize(20)
            .fontColor("#FFFFFF")
          Text("Custom Brew")
            .fontSize(16)
            .fontColor("#FFFFFF")
            .margin({ left: 8 })
        }
      }
      .height(56)
      .padding({ left: 20, right: 20 })
      .backgroundColor("#121212")
      .borderRadius(16)
      .margin({ right: 20, bottom: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor("#FFFFFF")
  }
}

class TeaGuide {
  id: number;
  name: string;
  origin: string;
  temp: string;
  time: string;
  colorCode: string;

  constructor(id: number, name: string, origin: string, temp: string, time: string, colorCode: string) {
    this.id = id;
    this.name = name;
    this.origin = origin;
    this.temp = temp;
    this.time = time;
    this.colorCode = colorCode;
  }
}