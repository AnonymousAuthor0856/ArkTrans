// 061*GroupBuy*en
// UI_TYPE: ECommerce
// STYLE_THEME: Retro Flat
// LANG: en
// BASELINE_SIZE: 720x1280

interface Pin {
  x: number;
  y: number;
  label: string;
}

class AppTokens {
  static primary: string = '#FF8C00';
  static secondary: string = '#FFC107';
  static tertiary: string = '#FFE082';
  static background: string = '#FFF8E1';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#FFECB3';
  static outline: string = '#D7CCC8';
  static success: string = '#4CAF50';
  static warning: string = '#FFB300';
  static error: string = '#E53935';
  static onPrimary: string = '#3E2723';
  static onSecondary: string = '#3E2723';
  static onBackground: string = '#3E2723';
  static onSurface: string = '#3E2723';
}

@Entry
@Component
struct RootScreen {
  @State pins: Pin[] = [
    { x: 150, y: 250, label: 'Group A' },
    { x: 350, y: 420, label: 'Group B' },
    { x: 520, y: 310, label: 'Group C' }
  ];

  addPin() {
    const newPin: Pin = {
      x: Math.floor(Math.random() * (550 - 100 + 1)) + 100,
      y: Math.floor(Math.random() * (450 - 150 + 1)) + 150,
      label: 'New'
    };
    this.pins.push(newPin);
  }

  clearPins() {
    this.pins = [];
  }

  build() {
    Column() {
      Text('Retro Group Buy')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.onBackground)
        .width('100%')
        .margin({ bottom: 16 })

      Column() {
        Text('Live Deals Map')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.onSurface)
          .margin({ bottom: 10 })

        Stack() {
          ForEach(this.pins, (pin: Pin) => {
            Circle({ width: 28, height: 28 })
              .fill(AppTokens.primary)
              .position({ x: pin.x, y: pin.y })
          }, (pin: Pin) => `${pin.label}_${pin.x}_${pin.y}`)
        }
        .width('100%')
        .height(220)
        .backgroundColor(AppTokens.surfaceVariant)
        .borderRadius(10)
        .padding(8)
      }
      .width('100%')
      .padding(16)
      .backgroundColor(AppTokens.surface)
      .borderRadius(16)
      .shadow({ radius: 8, offsetX: 0, offsetY: 4, color: '#66000000' })
      .margin({ bottom: 6 })

      Row() {
        Button('Add Group', { type: ButtonType.Capsule })
          .backgroundColor(AppTokens.secondary)
          .fontColor(AppTokens.onSecondary)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .height(48)
          .layoutWeight(1)
          .onClick(() => this.addPin())

        Blank().width(10)

        Button('Clear', { type: ButtonType.Capsule })
          .backgroundColor(AppTokens.primary)
          .fontColor(AppTokens.onPrimary)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .height(48)
          .layoutWeight(1)
          .onClick(() => this.clearPins())
      }
      .width('100%')
      .margin({ bottom: 16 })

      Column() {
        Text('Active Groups')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.primary)
          .margin({ bottom: 6 })

        ForEach(this.pins, (pin: Pin) => {
          Row() {
            Text(pin.label)
              .fontSize(14)
              .fontColor(AppTokens.onSurface)
            Blank()
            Circle({ width: 14, height: 14 })
              .fill(AppTokens.primary)
          }
          .width('100%')
          .height(24)
          .alignItems(VerticalAlign.Center)
        }, (pin: Pin) => `${pin.label}_${pin.x}_${pin.y}`)
      }
      .width('100%')
      .padding(16)
      .backgroundColor(AppTokens.surface)
      .borderRadius(16)
      .shadow({ radius: 4, offsetX: 0, offsetY: 2, color: '#1A000000' })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor(AppTokens.background)
    .alignItems(HorizontalAlign.Start)
  }
}