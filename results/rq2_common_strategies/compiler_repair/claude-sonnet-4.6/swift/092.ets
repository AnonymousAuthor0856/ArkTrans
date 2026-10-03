// Color constants
const ZEN_GREEN = '#6A8E6A';
const ZEN_GREEN_LIGHT = '#E8F5E9';
const ZEN_BROWN = '#8D6E63';
const ZEN_TEXT_PRIMARY = '#2C3E50';
const ZEN_TEXT_SECONDARY = '#7F8C8D';
const ZEN_WHITE = '#FFFFFF';
const STATUS_ITEM_BG = '#F7F9F9';
const STATUS_ITEM_BORDER = '#ECEFF1';
const CARE_LOG_BG = '#FAFAFA';
const CARE_LOG_BORDER = '#F0F0F0';
const CARE_LOG_SUBTITLE = '#9E9E9E';
const NAV_ICON_INACTIVE = '#CFD8DC';
const BOTTOM_BAR_DIVIDER = '#F5F5F5';
const LIGHT_GRAY_CIRCLE = '#E0E0E0';
const TRUNK_COLOR = '#5D4037';
const HEALTH_RED = '#E57373';
const WATER_BLUE = '#64B5F6';

@Entry
@Component
struct ZenBonsaiAppView {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column({ space: 0 }) {
          HeaderSection()
            .margin({ top: 24 })

          Blank().height(32)

          BonsaiVisual()
            .width(220)
            .height(220)

          Blank().height(32)

          StatusRow()

          Blank().height(32)

          ActivityLogSection()
            .margin({ bottom: 24 })
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 80 })
        .backgroundColor(ZEN_WHITE)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(ZEN_WHITE)

      SimpleBottomNav()
        .backgroundColor(ZEN_WHITE)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ZEN_WHITE)
  }
}

@Component
struct HeaderSection {
  build() {
    Column({ space: 0 }) {
      Text('JUNIPER · #04')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(ZEN_TEXT_SECONDARY)
        .letterSpacing(2)

      Blank().height(8)

      Text('Zen Garden')
        .fontSize(36)
        .fontWeight(FontWeight.Lighter)
        .fontColor(ZEN_TEXT_PRIMARY)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StatusRow {
  build() {
    Row() {
      Blank()
      StatusItem({ icon: '❤', label: 'Health', value: '98%', tintColor: HEALTH_RED })
      Blank()
      StatusItem({ icon: '📅', label: 'Age', value: '4 Yrs', tintColor: ZEN_BROWN })
      Blank()
      StatusItem({ icon: '✓', label: 'Water', value: '2 Days', tintColor: WATER_BLUE })
      Blank()
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct StatusItem {
  icon: string = '';
  label: string = '';
  value: string = '';
  tintColor: string = ZEN_GREEN;

  build() {
    Column({ space: 0 }) {
      Stack() {
        Circle()
          .width(50)
          .height(50)
          .fill(STATUS_ITEM_BG)
          .stroke(STATUS_ITEM_BORDER, 1)

        Text(this.icon)
          .fontSize(22)
          .fontColor(this.tintColor)
      }
      .width(50)
      .height(50)

      Blank().height(8)

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(ZEN_TEXT_PRIMARY)

      Text(this.label)
        .fontSize(11)
        .fontWeight(FontWeight.Regular)
        .fontColor(ZEN_TEXT_SECONDARY)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ActivityLogSection {
  build() {
    Column({ space: 0 }) {
      Row() {
        Text('Care Schedule')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(ZEN_TEXT_PRIMARY)

        Blank()

        Stack() {
          Circle()
            .width(28)
            .height(28)
            .fill(ZEN_GREEN_LIGHT)

          Text('+')
            .fontSize(18)
            .fontColor(ZEN_GREEN)
            .fontWeight(FontWeight.Medium)
        }
        .width(28)
        .height(28)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank().height(16)

      CareLogItem({ title: 'Watering', subtitle: 'Today, 8:00 AM', isDone: true })

      Blank().height(12)

      CareLogItem({ title: 'Pruning', subtitle: 'Tomorrow', isDone: false })

      Blank().height(12)

      CareLogItem({ title: 'Fertilizer', subtitle: 'In 5 days', isDone: false })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct CareLogItem {
  title: string = '';
  subtitle: string = '';
  isDone: boolean = false;

  build() {
    Row({ space: 0 }) {
      Circle()
        .width(12)
        .height(12)
        .fill(this.isDone ? ZEN_GREEN : LIGHT_GRAY_CIRCLE)

      Blank().width(16)

      Column({ space: 0 }) {
        Text(this.title)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(this.isDone ? ZEN_TEXT_PRIMARY : ZEN_TEXT_SECONDARY)

        Text(this.subtitle)
          .fontSize(11)
          .fontWeight(FontWeight.Regular)
          .fontColor(CARE_LOG_SUBTITLE)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      if (this.isDone) {
        Text('✓')
          .fontSize(18)
          .fontColor(ZEN_GREEN)
          .fontWeight(FontWeight.Bold)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor(CARE_LOG_BG)
    .borderRadius(12)
    .border({ width: 1, color: CARE_LOG_BORDER, radius: 12 })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct SimpleBottomNav {
  build() {
    Column({ space: 0 }) {
      Divider()
        .color(BOTTOM_BAR_DIVIDER)
        .strokeWidth(1)

      Row({ space: 0 }) {
        NavIcon({ icon: '🏠', isSelected: true })
        NavIcon({ icon: 'ℹ', isSelected: false })
        NavIcon({ icon: '⚙', isSelected: false })
      }
      .width('100%')
      .height(80)
      .backgroundColor(ZEN_WHITE)
    }
  }
}

@Component
struct NavIcon {
  icon: string = '';
  isSelected: boolean = false;

  build() {
    Column({ space: 0 }) {
      Text(this.icon)
        .fontSize(26)
        .fontColor(this.isSelected ? ZEN_GREEN : NAV_ICON_INACTIVE)

      if (this.isSelected) {
        Blank().height(4)
        Circle()
          .width(4)
          .height(4)
          .fill(ZEN_GREEN)
      }
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct BonsaiVisual {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawBonsai(): void {
    const w: number = 220;
    const h: number = 220;
    const potWidth: number = w * 0.5;
    const potHeight: number = h * 0.15;
    const potTop: number = h * 0.85;

    this.ctx.fillStyle = ZEN_BROWN;
    this.ctx.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight);

    this.ctx.fillStyle = 'rgba(141,110,99,0.8)';
    this.ctx.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15);

    this.ctx.beginPath();
    this.ctx.moveTo(w * 0.5, potTop);
    this.ctx.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5);
    this.ctx.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3);
    this.ctx.strokeStyle = TRUNK_COLOR;
    this.ctx.lineWidth = 25;
    this.ctx.lineCap = 'round';
    this.ctx.stroke();

    this.ctx.beginPath();
    this.ctx.moveTo(w * 0.38, h * 0.55);
    this.ctx.lineTo(w * 0.25, h * 0.45);
    this.ctx.strokeStyle = TRUNK_COLOR;
    this.ctx.lineWidth = 15;
    this.ctx.lineCap = 'round';
    this.ctx.stroke();

    this.ctx.fillStyle = ZEN_GREEN;
    this.ctx.beginPath();
    this.ctx.ellipse(w * 0.6, h * 0.25, 45, 45, 0, 0, Math.PI * 2);
    this.ctx.fill();

    this.ctx.fillStyle = 'rgba(106,142,106,0.8)';
    this.ctx.beginPath();
    this.ctx.ellipse(w * 0.68, h * 0.28, 35, 35, 0, 0, Math.PI * 2);
    this.ctx.fill();

    this.ctx.fillStyle = 'rgba(106,142,106,0.9)';
    this.ctx.beginPath();
    this.ctx.ellipse(w * 0.55, h * 0.22, 30, 30, 0, 0, Math.PI * 2);
    this.ctx.fill();

    this.ctx.fillStyle = ZEN_GREEN;
    this.ctx.beginPath();
    this.ctx.ellipse(w * 0.35, h * 0.5, 35, 35, 0, 0, Math.PI * 2);
    this.ctx.fill();

    this.ctx.fillStyle = 'rgba(106,142,106,0.8)';
    this.ctx.beginPath();
    this.ctx.ellipse(w * 0.30, h * 0.45, 25, 25, 0, 0, Math.PI * 2);
    this.ctx.fill();

    this.ctx.fillStyle = ZEN_GREEN;
    this.ctx.beginPath();
    this.ctx.ellipse(w * 0.22, h * 0.42, 25, 25, 0, 0, Math.PI * 2);
    this.ctx.fill();
  }

  build() {
    Canvas(this.ctx)
      .width(220)
      .height(220)
      .onReady(() => {
        this.drawBonsai();
      })
  }
}