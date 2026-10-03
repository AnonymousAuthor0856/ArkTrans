@Entry
@Component
struct ZenBrewPage {
  @State sampleTeas: TeaGuide[] = [
    new TeaGuide(1, "Sencha Green", "Japan", "70°C / 158°F", "1-2 min", 0xFF8BC34A),
    new TeaGuide(2, "Earl Grey", "Blend", "95°C / 203°F", "3-5 min", 0xFF795548),
    new TeaGuide(3, "Silver Needle", "China", "80°C / 176°F", "3-4 min", 0xFFE0E0E0),
    new TeaGuide(4, "Darjeeling", "India", "90°C / 194°F", "3 min", 0xFFD7CCC8),
    new TeaGuide(5, "Chamomile", "Egypt", "100°C / 212°F", "5-7 min", 0xFFFFEB3B),
    new TeaGuide(6, "Matcha", "Japan", "80°C / 176°F", "Whisk", 0xFF4CAF50),
    new TeaGuide(7, "Oolong", "Taiwan", "85°C / 185°F", "3-5 min", 0xFFFF9800)
  ]

  private onSettingsClick(): void {
    console.info("Settings tapped");
  }

  private onCustomBrewClick(): void {
    console.info("Custom Brew tapped");
  }

  build() {
    Stack() {
      Scroll() {
        Column({ space: 16 }) {
          Row() {
            Column() {
              Text("ZenBrew")
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(0xFF121212)
                .letterSpacing(-0.5)
              Text("Mindful Steeping Guide")
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor(0xFF757575)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button() {
              Text("⚙")
                .fontSize(24)
                .fontColor(0xFF121212)
            }
            .type(ButtonType.Circle)
            .width(44)
            .height(44)
            .backgroundColor(Color.Transparent)
            .onClick(() => this.onSettingsClick())
          }
          .width('100%')
          .padding({ left: 20, right: 20, top: 10 })

          PromoCard()
            .padding({ left: 20, right: 20 })

          Text("Collections")
            .fontSize(18)
            .fontWeight(600)
            .fontColor(0xFF121212)
            .width('100%')
            .padding({ top: 8, bottom: 8, left: 20, right: 20 })

          ForEach(this.sampleTeas, (tea: TeaGuide) => {
            TeaItemCard({ tea: tea })
              .padding({ left: 20, right: 20 })
          }, (tea: TeaGuide) => tea.id.toString())

          Blank()
            .height(80)
        }
        .width('100%')
        .padding({ top: 10, bottom: 10 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
      .scrollBar(BarState.Off)

      Button() {
        Row({ space: 8 }) {
          Text("+")
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
          Text("Custom Brew")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
        }
      }
      .height(56)
      .padding({ left: 24, right: 24 })
      .backgroundColor(0xFF121212)
      .borderRadius(16)
      .margin({ right: 20, bottom: 20 })
      .onClick(() => this.onCustomBrewClick())
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .alignContent(Alignment.BottomEnd)
  }
}

@Component
struct PromoCard {
  build() {
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
          .fontColor(0xFF121212)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank()
        .width(16)

      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(48)
          .height(48)
          .fill(Color.White)
        Text("i")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
      }
    }
    .width('100%')
    .padding(24)
    .backgroundColor(0xFFF0F0F0)
    .borderRadius(20)
  }
}

@Component
struct TeaItemCard {
  @Prop tea: TeaGuide = new TeaGuide(0, "", "", "", "", 0xFF000000);

  private onPlayClick(): void {
    console.info(`Play for ${this.tea.name} tapped`);
  }

  build() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(50)
          .height(50)
          .fill(Color.White)
        Circle()
          .width(50)
          .height(50)
          .fill(Color.Transparent)
          .stroke(this.getColorWithAlpha(this.tea.colorCode, 0.3))
          .strokeWidth(2)
        Text(this.tea.name.substring(0, 1))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.tea.colorCode)
      }
      .clip(true)
      .borderRadius(25)

      Blank()
        .width(16)

      Column() {
        Text(this.tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(0xFF121212)
        Text(this.tea.origin)
          .fontSize(12)
          .fontColor(0xFF757575)
        Blank()
          .height(6)
        Row() {
          InfoBadge({ label: this.tea.temp })
          Blank()
            .width(8)
          InfoBadge({ label: this.tea.time })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button() {
        Text("▶")
          .fontSize(16)
          .fontColor(0xFF121212)
      }
      .type(ButtonType.Circle)
      .width(40)
      .height(40)
      .backgroundColor(Color.White)
      .border({ width: 1, color: 0xFFE0E0E0 })
      .onClick(() => this.onPlayClick())
    }
    .width('100%')
    .padding(16)
    .backgroundColor(0xFFF9F9F9)
    .borderRadius(16)
    .border({ width: 1, color: 0xFFEEEEEE })
  }

  private getColorWithAlpha(color: ResourceColor, alpha: number): string {
    const c = color as number;
    const r = (c >> 16) & 0xFF;
    const g = (c >> 8) & 0xFF;
    const b = c & 0xFF;
    return `rgba(${r}, ${g}, ${b}, ${alpha})`;
  }
}

@Component
struct InfoBadge {
  label: string = '';

  build() {
    Text(this.label)
      .fontSize(11)
      .fontColor(Color.Black)
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor(Color.White)
      .borderRadius(6)
      .border({ width: 1, color: 0xFFE0E0E0 })
  }
}

class TeaGuide {
  id: number;
  name: string;
  origin: string;
  temp: string;
  time: string;
  colorCode: number;

  constructor(id: number, name: string, origin: string, temp: string, time: string, colorCode: number) {
    this.id = id;
    this.name = name;
    this.origin = origin;
    this.temp = temp;
    this.time = time;
    this.colorCode = colorCode;
  }
}
