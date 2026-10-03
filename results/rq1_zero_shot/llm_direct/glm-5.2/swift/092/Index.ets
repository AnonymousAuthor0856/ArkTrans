// ZenBonsaiApp.ets
import curves from '@ohos.curves';

// MARK: - Color Palette
class ZenColors {
  static readonly zenGreen: string = '#6A8E6A';
  static readonly zenGreenLight: string = '#E8F5E9';
  static readonly zenBrown: string = '#8D6E63';
  static readonly zenTextPrimary: string = '#2C3E50';
  static readonly zenTextSecondary: string = '#7F8C8D';
  static readonly zenWhite: string = '#FFFFFF';
  static readonly zenAccent: string = '#D4E157';

  static readonly statusItemBg: string = '#F7F9F9';
  static readonly statusItemBorder: string = '#ECEFF1';
  static readonly careLogBg: string = '#FAFAFA';
  static readonly careLogBorder: string = '#F0F0F0';
  static readonly careLogSubtitle: string = '#9E9E9E';
  static readonly navIconInactive: string = '#CFD8DC';
  static readonly bottomBarDivider: string = '#F5F5F5';
  static readonly lightGrayCircle: string = '#E0E0E0';
  static readonly trunkColor: string = '#5D4037';
  static readonly healthRed: string = '#E57373';
  static readonly waterBlue: string = '#64B5F6';
}

// MARK: - Typography Mapping
@Extend(Text)
function zenText(font: number, color: string, weight: number = FontWeight.Normal, spacing: number = 0) {
  .fontSize(font)
  .fontColor(color)
  .fontWeight(weight)
  .letterSpacing(spacing)
}

// MARK: - Main App Entry Point
@Entry
@Component
struct ZenBonsaiApp {
  build() {
    Column() {
      ZenBonsaiAppView()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ZenColors.zenWhite)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.ALL])
  }
}

// MARK: - ZenBonsaiAppView (Main Content View)
@Component
struct ZenBonsaiAppView {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Main Scrollable Content
      Scroll() {
        Column() {
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
            .margin({ bottom: 100 }) // Space for bottom nav
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
        .backgroundColor(ZenColors.zenWhite)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(ZenColors.zenWhite)
      .scrollBar(BarState.Off)

      // Bottom Navigation
      SimpleBottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ZenColors.zenWhite)
  }
}

// MARK: - HeaderSection
@Component
struct HeaderSection {
  build() {
    Column() {
      Text('JUNIPER · #04')
        .zenText(12, ZenColors.zenTextSecondary, FontWeight.Medium, 2)
        .margin({ bottom: 8 })

      Text('Zen Garden')
        .zenText(36, ZenColors.zenTextPrimary, FontWeight.Lighter)
    }
  }
}

// MARK: - StatusRow
@Component
struct StatusRow {
  build() {
    Row() {
      Blank()
      StatusItem({ icon: $r('sys.symbol.heart_fill'), label: 'Health', value: '98%', tint: ZenColors.healthRed })
      Blank()
      StatusItem({ icon: $r('sys.symbol.calendar'), label: 'Age', value: '4 Yrs', tint: ZenColors.zenBrown })
      Blank()
      StatusItem({ icon: $r('sys.symbol.checkmark_circle_fill'), label: 'Water', value: '2 Days', tint: ZenColors.waterBlue })
      Blank()
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }
}

// MARK: - StatusItem
@Component
struct StatusItem {
  @Prop icon: Resource;
  @Prop label: string;
  @Prop value: string;
  @Prop tint: string;

  build() {
    Column() {
      Stack() {
        Circle({ width: 50, height: 50 })
          .fill(ZenColors.statusItemBg)
          .stroke(ZenColors.statusItemBorder)
          .strokeWidth(1)

        Image(this.icon)
          .width(24)
          .height(24)
          .fillColor(this.tint)
      }
      .width(50)
      .height(50)

      Text(this.value)
        .zenText(16, ZenColors.zenTextPrimary, FontWeight.Bold)
        .margin({ top: 8 })

      Text(this.label)
        .zenText(11, ZenColors.zenTextSecondary)
    }
  }
}

// MARK: - ActivityLogSection
@Component
struct ActivityLogSection {
  build() {
    Column() {
      Row() {
        Text('Care Schedule')
          .zenText(16, ZenColors.zenTextPrimary, FontWeight.Medium)

        Blank()

        Stack() {
          Image($r('sys.symbol.plus'))
            .width(20)
            .height(20)
            .fillColor(ZenColors.zenGreen)
        }
        .width(28)
        .height(28)
        .backgroundColor(ZenColors.zenGreenLight)
        .borderRadius(14)
        .padding(4)
      }
      .width('100%')

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

// MARK: - CareLogItem
@Component
struct CareLogItem {
  @Prop title: string;
  @Prop subtitle: string;
  @Prop isDone: boolean;

  build() {
    Row() {
      Circle({ width: 12, height: 12 })
        .fill(this.isDone ? ZenColors.zenGreen : ZenColors.lightGrayCircle)

      Blank().width(16)

      Column() {
        Text(this.title)
          .zenText(14, this.isDone ? ZenColors.zenTextPrimary : ZenColors.zenTextSecondary)
        Text(this.subtitle)
          .zenText(11, ZenColors.careLogSubtitle)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      if (this.isDone) {
        Image($r('sys.symbol.checkmark'))
          .width(20)
          .height(20)
          .fillColor(ZenColors.zenGreen)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor(ZenColors.careLogBg)
    .borderRadius(12)
    .border({ width: 1, color: ZenColors.careLogBorder })
  }
}

// MARK: - SimpleBottomNav
@Component
struct SimpleBottomNav {
  build() {
    Column() {
      Divider()
        .color(ZenColors.bottomBarDivider)
        .strokeWidth(1)

      Row() {
        NavIcon({ icon: $r('sys.symbol.house_fill'), isSelected: true })
        NavIcon({ icon: $r('sys.symbol.info_circle_fill'), isSelected: false })
        NavIcon({ icon: $r('sys.symbol.gearshape_fill'), isSelected: false })
      }
      .width('100%')
      .height(80)
      .backgroundColor(ZenColors.zenWhite)
      .justifyContent(FlexAlign.SpaceAround)
    }
  }
}

// MARK: - NavIcon
@Component
struct NavIcon {
  @Prop icon: Resource;
  @Prop isSelected: boolean;

  build() {
    Column() {
      Image(this.icon)
        .width(28)
        .height(28)
        .fillColor(this.isSelected ? ZenColors.zenGreen : ZenColors.navIconInactive)

      if (this.isSelected) {
        Blank().height(4)
        Circle({ width: 4, height: 4 })
          .fill(ZenColors.zenGreen)
      }
    }
    .layoutWeight(1)
  }
}

// MARK: - Custom Art Logic (BonsaiVisual)
@Component
struct BonsaiVisual {
  build() {
    Canvas((context: CanvasRenderingContext2D) => {
      const w = 220;
      const h = 220;

      // 1. Draw Pot
      const potWidth = w * 0.5;
      const potHeight = h * 0.15;
      const potTop = h * 0.85;

      context.fillStyle = ZenColors.zenBrown;
      context.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight);
      
      // Pot Rim
      context.fillStyle = '#8D6E63CC'; // 80% opacity
      context.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15);

      // 2. Draw Trunk
      context.strokeStyle = ZenColors.trunkColor;
      context.lineWidth = 25;
      context.lineCap = 'round';

      context.beginPath();
      context.moveTo(w * 0.5, potTop);
      context.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5);
      context.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3);
      context.stroke();

      // Secondary Branch
      context.lineWidth = 15;
      context.beginPath();
      context.moveTo(w * 0.38, h * 0.55);
      context.lineTo(w * 0.25, h * 0.45);
      context.stroke();

      // 3. Draw Leaves (Clusters)
      // Cluster 1 (Top Right)
      context.fillStyle = ZenColors.zenGreen;
      context.beginPath();
      context.ellipse(w * 0.6, h * 0.25, 45, 45, 0, 0, Math.PI * 2);
      context.fill();

      context.fillStyle = '#6A8E6ACC'; // 80% opacity
      context.beginPath();
      context.ellipse(w * 0.68, h * 0.28, 35, 35, 0, 0, Math.PI * 2);
      context.fill();

      context.fillStyle = '#6A8E6AE6'; // 90% opacity
      context.beginPath();
      context.ellipse(w * 0.55, h * 0.22, 30, 30, 0, 0, Math.PI * 2);
      context.fill();

      // Cluster 2 (Middle Left)
      context.fillStyle = ZenColors.zenGreen;
      context.beginPath();
      context.ellipse(w * 0.35, h * 0.5, 35, 35, 0, 0, Math.PI * 2);
      context.fill();

      context.fillStyle = '#6A8E6ACC'; // 80% opacity
      context.beginPath();
      context.ellipse(w * 0.30, h * 0.45, 25, 25, 0, 0, Math.PI * 2);
      context.fill();

      // Cluster 3 (Far Left)
      context.fillStyle = ZenColors.zenGreen;
      context.beginPath();
      context.ellipse(w * 0.22, h * 0.42, 25, 25, 0, 0, Math.PI * 2);
      context.fill();
    })
    .width('100%')
    .height('100%')
  }
}