const NAME: string = '105_ChargingProgress_en';
const UI_TYPE: string = 'SmartHome Dashboard';
const STYLE_THEME: string = 'Retro Flat';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

const PRIMARY: string = '#3B82F6';
const SECONDARY: string = '#22C55E';
const BACKGROUND: string = '#F5F5F4';
const SURFACE: string = '#FFFFFF';
const OUTLINE: string = '#D4D4D8';
const ON_PRIMARY: string = '#FFFFFF';
const ON_BACKGROUND: string = '#111827';
const ON_SURFACE: string = '#1F2937';
const ACCENT: string = '#F59E0B';

const SPACING_SM: number = 6;
const SPACING_MD: number = 10;
const SPACING_LG: number = 14;
const SPACING_XL: number = 20;

@Component
struct ElectricCarIcon {
  build() {
    Stack() {
      Row() {
      }
      .width(22)
      .height(13)
      .backgroundColor(PRIMARY)
      .borderRadius(3)
      .position({ x: 5, y: 6 })

      Row() {
      }
      .width(34)
      .height(17)
      .backgroundColor(PRIMARY)
      .borderRadius(5)
      .position({ x: 0, y: 16 })

      Row() {
      }
      .width(7)
      .height(7)
      .backgroundColor(SURFACE)
      .borderRadius(4)
      .position({ x: 6, y: 26 })

      Row() {
      }
      .width(7)
      .height(7)
      .backgroundColor(SURFACE)
      .borderRadius(4)
      .position({ x: 23, y: 26 })

      Row() {
      }
      .width(7)
      .height(7)
      .backgroundColor(SURFACE)
      .borderRadius(1)
      .position({ x: 9, y: 10 })

      Row() {
      }
      .width(7)
      .height(7)
      .backgroundColor(SURFACE)
      .borderRadius(1)
      .position({ x: 18, y: 10 })

      Text('ϟ')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(PRIMARY)
        .position({ x: 11, y: 30 })
    }
    .width(36)
    .height(42)
  }
}

@Component
struct BatteryChargingIcon {
  build() {
    Column() {
      Row() {
      }
      .width(22)
      .height(12)
      .backgroundColor(PRIMARY)
      .borderRadius({ topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 0 })

      Stack({ alignContent: Alignment.Center }) {
        Row() {
        }
        .width(60)
        .height(60)
        .backgroundColor(PRIMARY)
        .borderRadius(7)

        Text('ϟ')
          .fontSize(52)
          .fontWeight(FontWeight.Bold)
          .fontColor(ON_PRIMARY)
      }
      .width(60)
      .height(60)
    }
    .width(72)
    .height(72)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct ChargingProgressBar {
  @Prop progress: number = 0.45;

  private progressWidth(): string {
    const value: number = Math.max(0, Math.min(1, this.progress));
    return `${value * 100}%`;
  }

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row() {
      }
      .width('100%')
      .height(14)
      .backgroundColor(SURFACE)

      Row() {
      }
      .width(this.progressWidth())
      .height(14)
      .backgroundColor(PRIMARY)
      .borderRadius(7)
    }
    .width('80%')
    .height(14)
    .border({
      width: 1,
      color: OUTLINE
    })
    .borderRadius(7)
    .clip(true)
  }
}

@Component
struct TopAppBar {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text('Charging Progress')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(ON_BACKGROUND)
        .textAlign(TextAlign.Center)

      Row() {
        ElectricCarIcon()
          .margin({ left: 8 })

        Blank()

        Text('\u2699')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(ACCENT)
          .width(48)
          .height(48)
          .textAlign(TextAlign.Center)
          .onClick(() => {
          })
      }
      .width('100%')
      .height('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(64)
    .backgroundColor(SURFACE)
  }
}

@Entry
@Component
struct ChargingProgressPage {
  @State progress: number = 0.45;

  private percentText(): string {
    return `${Math.floor(this.progress * 100)}%`;
  }

  private statusText(): string {
    return this.progress < 1 ? 'Charging...' : 'Fully Charged!';
  }

  private statusColor(): string {
    return this.progress < 1 ? PRIMARY : SECONDARY;
  }

  build() {
    Column() {
      TopAppBar()

      Column({ space: SPACING_XL }) {
        BatteryChargingIcon()

        Text(this.percentText())
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(ON_BACKGROUND)
          .textAlign(TextAlign.Center)

        ChargingProgressBar({ progress: this.progress })

        Button('Simulate Charge', { type: ButtonType.Capsule, stateEffect: true })
          .height(40)
          .width(154)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_PRIMARY)
          .backgroundColor(SECONDARY)
          .onClick(() => {
            const next: number = this.progress + 0.1;
            this.progress = next > 1 ? 0 : Number(next.toFixed(2));
          })

        Text(this.statusText())
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.statusColor())
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        top: SPACING_LG,
        left: SPACING_LG,
        right: SPACING_LG
      })
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}