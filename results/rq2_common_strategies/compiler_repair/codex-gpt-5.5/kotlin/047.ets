class GroupPin {
  x: number;
  y: number;
  label: string;

  constructor(x: number, y: number, label: string) {
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

class RetroColors {
  static readonly primary: string = '#FF8C00';
  static readonly secondary: string = '#FFC107';
  static readonly tertiary: string = '#FFE082';
  static readonly background: string = '#FFF8E1';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFECB3';
  static readonly outline: string = '#D7CCC8';
  static readonly text: string = '#3E2723';
}

@Entry
@Component
struct Index {
  @State pins: GroupPin[] = [
    new GroupPin(150, 250, 'Group A'),
    new GroupPin(350, 420, 'Group B'),
    new GroupPin(520, 310, 'Group C')
  ];

  private addPin(): void {
    let index = this.pins.length + 1;
    let x = 100 + ((index * 97) % 450);
    let y = 150 + ((index * 83) % 300);
    this.pins.push(new GroupPin(x, y, 'New'));
  }

  @Builder
  Header() {
    Text('Retro Group Buy')
      .fontSize(28)
      .fontWeight(FontWeight.Bold)
      .fontColor(RetroColors.text)
      .width('100%')
      .textAlign(TextAlign.Start)
  }

  @Builder
  SectionCard(title: string) {
    Column() {
      Text(title)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(RetroColors.text)
        .width('100%')
        .margin({ bottom: 12 })

      if (title === 'Live Deals Map') {
        Stack() {
          Text('')
            .width('100%')
            .height(220)
            .backgroundColor(RetroColors.surfaceVariant)
            .borderRadius(16)

          ForEach(this.pins, (pin: GroupPin) => {
            Column() {
              Circle()
                .width(18)
                .height(18)
                .fill(RetroColors.primary)
                .stroke(RetroColors.text)
                .strokeWidth(2)

              Text(pin.label)
                .fontSize(11)
                .fontColor(RetroColors.text)
                .backgroundColor(RetroColors.tertiary)
                .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                .borderRadius(6)
                .margin({ top: 4 })
            }
            .position({ x: pin.x / 1.8, y: pin.y / 2.2 })
          }, (pin: GroupPin, index: number) => `${pin.label}-${index}`)
        }
        .width('100%')
        .height(220)
        .clip(true)

        Row() {
          Button('Add Group')
            .fontColor(RetroColors.text)
            .backgroundColor(RetroColors.primary)
            .onClick(() => {
              this.addPin();
            })

          Button('Clear')
            .fontColor(RetroColors.text)
            .backgroundColor(RetroColors.secondary)
            .margin({ left: 12 })
            .onClick(() => {
              this.pins = [];
            })
        }
        .width('100%')
        .margin({ top: 14 })
      } else {
        Column() {
          ForEach(this.pins, (pin: GroupPin) => {
            Row() {
              Circle()
                .width(10)
                .height(10)
                .fill(RetroColors.primary)
                .margin({ right: 10 })

              Text(pin.label)
                .fontSize(16)
                .fontColor(RetroColors.text)
                .layoutWeight(1)
            }
            .width('100%')
            .height(36)
          }, (pin: GroupPin, index: number) => `${pin.label}-row-${index}`)
        }
        .width('100%')
      }
    }
    .width('100%')
    .padding(18)
    .backgroundColor(RetroColors.surface)
    .borderRadius(18)
    .border({ width: 1, color: RetroColors.outline })
  }

  build() {
    Column() {
      this.Header()

      Column() {
        this.SectionCard('Live Deals Map')
      }
      .margin({ top: 20 })

      Column() {
        this.SectionCard('Active Groups')
      }
      .margin({ top: 16 })
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor(RetroColors.background)
  }
}
