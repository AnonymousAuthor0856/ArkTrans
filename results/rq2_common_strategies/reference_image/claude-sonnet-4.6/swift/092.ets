// ZenBonsaiApp.ets
// SwiftUI → ArkTS (ArkUI 声明式) 转换实现
// 结构对应：ZenBonsaiAppView / HeaderSection / StatusRow / StatusItem /
//          ActivityLogSection / CareLogItem / SimpleBottomNav / NavIcon / BonsaiVisual

// MARK: - Color Palette
const ZenGreen: string = '#6A8E6A';
const ZenGreenLight: string = '#E8F5E9';
const ZenBrown: string = '#8D6E63';
const ZenTextPrimary: string = '#2C3E50';
const ZenTextSecondary: string = '#7F8C8D';
const ZenWhite: string = '#FFFFFF';
const ZenAccent: string = '#D4E157';

const StatusItemBg: string = '#F7F9F9';
const StatusItemBorder: string = '#ECEFF1';
const CareLogBg: string = '#FAFAFA';
const CareLogBorder: string = '#F0F0F0';
const CareLogSubtitle: string = '#9E9E9E';
const NavIconInactive: string = '#CFD8DC';
const BottomBarDivider: string = '#F5F5F5';
const LightGrayCircle: string = '#E0E0E0';
const TrunkColor: string = '#5D4037';
const HealthRed: string = '#E57373';
const WaterBlue: string = '#64B5F6';

const GreenAlpha80: string = 'rgba(106,142,106,0.80)';
const GreenAlpha90: string = 'rgba(106,142,106,0.90)';
const BrownAlpha80: string = 'rgba(141,110,99,0.80)';

// MARK: - Typography Mapping
const LabelMediumSize: number = 12;
const DisplaySmallSize: number = 36;
const TitleMediumSize: number = 16;
const LabelSmallSize: number = 11;
const BodyMediumSize: number = 14;

const WeightLight: number = 300;
const WeightMedium: number = 500;
const WeightSemiBold: number = 600;
const WeightBold: number = 700;

// MARK: - Main Entry
@Entry
@Component
struct ZenBonsaiApp {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  private scroller: Scroller = new Scroller();

  // ===== 垂直留白（对应 SwiftUI 的 Spacer().frame(height:)） =====
  @Builder
  vSpace(height: number) {
    Row().height(height)
  }

  // ===== HeaderSection =====
  @Builder
  headerSection() {
    Column() {
      Text('JUNIPER · #04')
        .fontSize(LabelMediumSize)
        .fontWeight(WeightMedium)
        .fontColor(ZenTextSecondary)
        .letterSpacing(2)
      this.vSpace(8)
      Text('Zen Garden')
        .fontSize(DisplaySmallSize)
        .fontWeight(WeightLight)
        .fontColor(ZenTextPrimary)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }

  // ===== BonsaiVisual =====
  @Builder
  bonsaiVisual() {
    Canvas(this.ctx)
      .width(220)
      .height(220)
      .onReady(() => {
        this.drawBonsai();
      })
  }

  // ===== StatusRow =====
  @Builder
  statusRow() {
    Row() {
      StatusItem({ iconText: '♥', label: 'Health', value: '98%', tint: HealthRed, filled: false })
      StatusItem({ iconText: '▦', label: 'Age', value: '4 Yrs', tint: ZenBrown, filled: false })
      StatusItem({ iconText: '✓', label: 'Water', value: '2 Days', tint: WaterBlue, filled: true })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
  }

  // ===== ActivityLogSection =====
  @Builder
  activityLogSection() {
    Column() {
      Row() {
        Text('Care Schedule')
          .fontSize(TitleMediumSize)
          .fontWeight(WeightSemiBold)
          .fontColor(ZenTextPrimary)
        Blank()
        // 对应：Image(systemName: "plus") + padding(4) + Circle 背景 + 28.dp 尺寸
        Stack() {
          Circle({ width: 28, height: 28 }).fill(ZenGreenLight)
          Text('+')
            .fontSize(20)
            .fontWeight(WeightMedium)
            .fontColor(ZenGreen)
        }
        .width(28)
        .height(28)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      this.vSpace(16)

      CareLogItem({ title: 'Watering', subtitle: 'Today, 8:00 AM', isDone: true })
      this.vSpace(12)
      CareLogItem({ title: 'Pruning', subtitle: 'Tomorrow', isDone: false })
      this.vSpace(12)
      CareLogItem({ title: 'Fertilizer', subtitle: 'In 5 days', isDone: false })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding({ bottom: 24 })
  }

  build() {
    Column() {
      Scroll(this.scroller) {
        Column() {
          this.headerSection()

          this.vSpace(32)
          this.bonsaiVisual()

          this.vSpace(32)
          this.statusRow()

          this.vSpace(32)
          this.activityLogSection()
        }
        .width('100%')
        .padding({ top: 24, left: 24, right: 24 })
        .alignItems(HorizontalAlign.Center)
        .backgroundColor(ZenWhite)
      }
      .width('100%')
      .layoutWeight(1)
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .backgroundColor(ZenWhite)

      SimpleBottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ZenWhite)
  }

  // ===== 自定义绘制：花盆 / 树干 / 叶簇 =====
  private fillEllipseBox(x: number, y: number, d: number, color: string): void {
    const ctx = this.ctx;
    ctx.beginPath();
    ctx.ellipse(x + d / 2, y + d / 2, d / 2, d / 2, 0, 0, Math.PI * 2);
    ctx.fillStyle = color;
    ctx.fill();
  }

  private drawBonsai(): void {
    const ctx: CanvasRenderingContext2D = this.ctx;
    const w: number = ctx.width;
    const h: number = ctx.height;

    // 画布底色
    ctx.fillStyle = ZenWhite;
    ctx.fillRect(0, 0, w, h);

    // 1. 花盆
    const potWidth: number = w * 0.5;
    const potHeight: number = h * 0.15;
    const potTop: number = h * 0.85;

    ctx.fillStyle = ZenBrown;
    ctx.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight);

    // 花盆边缘（半透明棕色）
    ctx.fillStyle = BrownAlpha80;
    ctx.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15);

    // 2. 树干（二次贝塞尔曲线）
    ctx.beginPath();
    ctx.moveTo(w * 0.5, potTop);
    ctx.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5);
    ctx.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3);
    ctx.strokeStyle = TrunkColor;
    ctx.lineWidth = 25;
    ctx.lineCap = 'round';
    ctx.stroke();

    // 次级树枝
    ctx.beginPath();
    ctx.moveTo(w * 0.38, h * 0.55);
    ctx.lineTo(w * 0.25, h * 0.45);
    ctx.strokeStyle = TrunkColor;
    ctx.lineWidth = 15;
    ctx.lineCap = 'round';
    ctx.stroke();

    // 3. 叶簇
    // 叶簇 1（右上）
    this.fillEllipseBox(w * 0.6 - 45, h * 0.25 - 45, 90, ZenGreen);
    this.fillEllipseBox(w * 0.68 - 35, h * 0.28 - 35, 70, GreenAlpha80);
    this.fillEllipseBox(w * 0.55 - 30, h * 0.22 - 30, 60, GreenAlpha90);

    // 叶簇 2（中左）
    this.fillEllipseBox(w * 0.35 - 35, h * 0.5 - 35, 70, ZenGreen);
    this.fillEllipseBox(w * 0.30 - 25, h * 0.45 - 25, 50, GreenAlpha80);

    // 叶簇 3（最左侧）
    this.fillEllipseBox(w * 0.22 - 25, h * 0.42 - 25, 50, ZenGreen);
  }
}

// MARK: - StatusItem
@Component
struct StatusItem {
  @Prop iconText: string = '';
  @Prop label: string = '';
  @Prop value: string = '';
  @Prop tint: string = ZenTextPrimary;
  @Prop filled: boolean = false;

  build() {
    Column() {
      Stack() {
        if (this.filled) {
          Circle({ width: 50, height: 50 }).fill(this.tint)
          Text(this.iconText)
            .fontSize(24)
            .fontWeight(WeightBold)
            .fontColor(ZenWhite)
        } else {
          Circle({ width: 50, height: 50 })
            .fill(StatusItemBg)
            .stroke(StatusItemBorder)
            .strokeWidth(1)
          Text(this.iconText)
            .fontSize(24)
            .fontColor(this.tint)
        }
      }
      .width(50)
      .height(50)

      Row().height(8)

      Text(this.value)
        .fontSize(TitleMediumSize)
        .fontWeight(WeightBold)
        .fontColor(ZenTextPrimary)

      Text(this.label)
        .fontSize(LabelSmallSize)
        .fontColor(ZenTextSecondary)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// MARK: - CareLogItem
@Component
struct CareLogItem {
  @Prop title: string = '';
  @Prop subtitle: string = '';
  @Prop isDone: boolean = false;

  build() {
    Row() {
      Circle({ width: 12, height: 12 })
        .fill(this.isDone ? ZenGreen : LightGrayCircle)

      Row().width(16)

      Column() {
        Text(this.title)
          .fontSize(BodyMediumSize)
          .fontColor(this.isDone ? ZenTextPrimary : ZenTextSecondary)
        Text(this.subtitle)
          .fontSize(LabelSmallSize)
          .fontColor(CareLogSubtitle)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      if (this.isDone) {
        Text('✓')
          .fontSize(20)
          .fontWeight(WeightMedium)
          .fontColor(ZenGreen)
      }
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .backgroundColor(CareLogBg)
    .borderRadius(12)
    .border({ width: 1, color: CareLogBorder })
  }
}

// MARK: - SimpleBottomNav
@Component
struct SimpleBottomNav {
  build() {
    Column() {
      Row()
        .width('100%')
        .height(1)
        .backgroundColor(BottomBarDivider)

      Row() {
        NavIcon({ iconText: '⌂', isSelected: true, circleBack: false })
        NavIcon({ iconText: 'i', isSelected: false, circleBack: true })
        NavIcon({ iconText: '⚙', isSelected: false, circleBack: false })
      }
      .width('100%')
      .height(80)
      .backgroundColor(ZenWhite)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
  }
}

// MARK: - NavIcon
@Component
struct NavIcon {
  @Prop iconText: string = '';
  @Prop isSelected: boolean = false;
  @Prop circleBack: boolean = false;

  build() {
    Column() {
      Stack() {
        if (this.circleBack) {
          Circle({ width: 28, height: 28 })
            .fill(this.isSelected ? ZenGreen : NavIconInactive)
          Text(this.iconText)
            .fontSize(20)
            .fontWeight(WeightBold)
            .fontColor(ZenWhite)
        } else {
          Text(this.iconText)
            .fontSize(28)
            .fontColor(this.isSelected ? ZenGreen : NavIconInactive)
            .fontWeight(this.isSelected ? WeightBold : WeightMedium)
        }
      }
      .width(32)
      .height(32)

      if (this.isSelected) {
        Row().height(4)
        Circle({ width: 4, height: 4 }).fill(ZenGreen)
      }
    }
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}