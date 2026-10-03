// ZenBonsaiApp.ets

// MARK: - Color Palette (Custom Muted Earth Tones)
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
class AppTypography {
  static readonly labelMedium: string = '12vp';
  static readonly displaySmallLight: string = '36vp';
  static readonly titleMediumBold: string = '16vp';
  static readonly titleMediumSemiBold: string = '16vp';
  static readonly labelSmall: string = '11vp';
  static readonly bodyMedium: string = '14vp';
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
            .margin({ bottom: 24 })
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 80 }) // 80vp bottom padding for nav bar
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(ZenColors.zenWhite)
      .align(Alignment.Top)

      // Bottom Navigation Bar
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
        .fontSize(AppTypography.labelMedium)
        .fontColor(ZenColors.zenTextSecondary)
        .letterSpacing(2)
        .fontWeight(FontWeight.Medium)
      
      Blank().height(8)

      Text('Zen Garden')
        .fontSize(AppTypography.displaySmallLight)
        .fontColor(ZenColors.zenTextPrimary)
        .fontWeight(FontWeight.Lighter)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// MARK: - StatusRow
@Component
struct StatusRow {
  build() {
    Row() {
      Blank() // Left Spacer
      StatusItem({ icon: $r('sys.symbol.heart_fill'), label: 'Health', value: '98%', tint: ZenColors.healthRed })
      Blank() // Spacer
      StatusItem({ icon: $r('sys.symbol.calendar'), label: 'Age', value: '4 Yrs', tint: ZenColors.zenBrown })
      Blank() // Spacer
      StatusItem({ icon: $r('sys.symbol.checkmark_circle_fill'), label: 'Water', value: '2 Days', tint: ZenColors.waterBlue })
      Blank() // Right Spacer
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

// MARK: - StatusItem
@Component
struct StatusItem {
  @Prop icon: Resource = $r('sys.symbol.heart_fill');
  @Prop label: string = '';
  @Prop value: string = '';
  @Prop tint: string = '#000000';

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

      Blank().height(8)

      Text(this.value)
        .fontSize(AppTypography.titleMediumBold)
        .fontColor(ZenColors.zenTextPrimary)
        .fontWeight(FontWeight.Bold)

      Text(this.label)
        .fontSize(AppTypography.labelSmall)
        .fontColor(ZenColors.zenTextSecondary)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// MARK: - ActivityLogSection
@Component
struct ActivityLogSection {
  build() {
    Column() {
      Row() {
        Text('Care Schedule')
          .fontSize(AppTypography.titleMediumSemiBold)
          .fontColor(ZenColors.zenTextPrimary)
          .fontWeight(FontWeight.Medium)
        
        Blank() // SpaceBetween

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
        .onClick(() => {
          // Handle add log action
        })
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
  @Prop title: string = '';
  @Prop subtitle: string = '';
  @Prop isDone: boolean = false;

  build() {
    Row() {
      Circle({ width: 12, height: 12 })
        .fill(this.isDone ? ZenColors.zenGreen : ZenColors.lightGrayCircle)

      Blank().width(16)

      Column() {
        Text(this.title)
          .fontSize(AppTypography.bodyMedium)
          .fontColor(this.isDone ? ZenColors.zenTextPrimary : ZenColors.zenTextSecondary)
        
        Text(this.subtitle)
          .fontSize(AppTypography.labelSmall)
          .fontColor(ZenColors.careLogSubtitle)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1) // Modifier.weight(1f)

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
    .alignItems(VerticalAlign.Center)
  }
}

// MARK: - SimpleBottomNav
@Component
struct SimpleBottomNav {
  build() {
    Column() {
      // Divider line
      Divider()
        .color(ZenColors.bottomBarDivider)
        .strokeWidth(1)
        .width('100%')

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
    .width('100%')
  }
}

// MARK: - NavIcon
@Component
struct NavIcon {
  @Prop icon: Resource = $r('sys.symbol.house_fill');
  @Prop isSelected: boolean = false;

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
    .alignItems(HorizontalAlign.Center)
    .layoutWeight(1) // Makes each icon take equal width (SpaceAround effect)
  }
}

// MARK: - Custom Art Logic (BonsaiVisual)
@Component
struct BonsaiVisual {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady(() => {
        const ctx = this.context;
        const w = 220; // Matches the fixed frame set in ZenBonsaiAppView
        const h = 220;

        // 1. Draw Pot
        const potWidth = w * 0.5;
        const potHeight = h * 0.15;
        const potTop = h * 0.85;

        ctx.fillStyle = ZenColors.zenBrown;
        ctx.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight);
        
        // Pot Rim
        ctx.fillStyle = ZenColors.zenBrown; // Base color, opacity handled below
        ctx.globalAlpha = 0.8;
        ctx.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15);
        ctx.globalAlpha = 1.0; // Reset alpha

        // 2. Draw Trunk (Bezier Curves)
        ctx.strokeStyle = ZenColors.trunkColor;
        ctx.lineWidth = 25;
        ctx.lineCap = 'round';

        ctx.beginPath();
        ctx.moveTo(w * 0.5, potTop);
        // Quad curve equivalent
        ctx.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5);
        ctx.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3);
        ctx.stroke();

        // Secondary branch
        ctx.lineWidth = 15;
        ctx.beginPath();
        ctx.moveTo(w * 0.38, h * 0.55);
        ctx.lineTo(w * 0.25, h * 0.45);
        ctx.stroke();

        // 3. Draw Leaves (Ellipse Clusters)
        // Cluster 1 (Top Right)
        ctx.fillStyle = ZenColors.zenGreen;
        ctx.beginPath();
        ctx.ellipse(w * 0.6, h * 0.25, 45, 45, 0, 0, Math.PI * 2);
        ctx.fill();

        ctx.globalAlpha = 0.8;
        ctx.beginPath();
        ctx.ellipse(w * 0.68, h * 0.28, 35, 35, 0, 0, Math.PI * 2);
        ctx.fill();

        ctx.globalAlpha = 0.9;
        ctx.beginPath();
        ctx.ellipse(w * 0.55, h * 0.22, 30, 30, 0, 0, Math.PI * 2);
        ctx.fill();
        ctx.globalAlpha = 1.0;

        // Cluster 2 (Middle Left)
        ctx.fillStyle = ZenColors.zenGreen;
        ctx.beginPath();
        ctx.ellipse(w * 0.35, h * 0.5, 35, 35, 0, 0, Math.PI * 2);
        ctx.fill();

        ctx.globalAlpha = 0.8;
        ctx.beginPath();
        ctx.ellipse(w * 0.30, h * 0.45, 25, 25, 0, 0, Math.PI * 2);
        ctx.fill();
        ctx.globalAlpha = 1.0;

        // Cluster 3 (Far Left Branch)
        ctx.fillStyle = ZenColors.zenGreen;
        ctx.beginPath();
        ctx.ellipse(w * 0.22, h * 0.42, 25, 25, 0, 0, Math.PI * 2);
        ctx.fill();
      })
  }
}