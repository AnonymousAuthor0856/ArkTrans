import { display } from '@kit.ArkUI';

// MARK: - Color Palette
const ZenColors = {
  zenGreen: '#6A8E6A',
  zenGreenLight: '#E8F5E9',
  zenBrown: '#8D6E63',
  zenTextPrimary: '#2C3E50',
  zenTextSecondary: '#7F8C8D',
  zenWhite: '#FFFFFF',
  zenAccent: '#D4E157',
  statusItemBg: '#F7F9F9',
  statusItemBorder: '#ECEFF1',
  careLogBg: '#FAFAFA',
  careLogBorder: '#F0F0F0',
  careLogSubtitle: '#9E9E9E',
  navIconInactive: '#CFD8DC',
  bottomBarDivider: '#F5F5F5',
  lightGrayCircle: '#E0E0E0',
  trunkColor: '#5D4037',
  healthRed: '#E57373',
  waterBlue: '#64B5F6',
};

// MARK: - HeaderSection
@Component
struct HeaderSection {
  build() {
    Column({ space: 0 }) {
      Text('JUNIPER · #04')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(ZenColors.zenTextSecondary)
        .letterSpacing(2)

      Blank().height(8)

      Text('Zen Garden')
        .fontSize(36)
        .fontWeight(FontWeight.Lighter)
        .fontColor(ZenColors.zenTextPrimary)
    }
    .alignItems(HorizontalAlign.Center)
    .width('100%')
  }
}

// MARK: - StatusItem
@Component
struct StatusItem {
  icon: ResourceStr = $r('sys.symbol.heart_fill');
  label: string = '';
  value: string = '';
  tint: string = ZenColors.healthRed;

  build() {
    Column({ space: 0 }) {
      Stack() {
        Circle()
          .width(50)
          .height(50)
          .fill(ZenColors.statusItemBg)
          .stroke(ZenColors.statusItemBorder, { width: 1 })

        Image(this.icon)
          .width(24)
          .height(24)
          .fillColor(this.tint)
          .objectFit(ImageFit.Contain)
      }
      .width(50)
      .height(50)

      Blank().height(8)

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(ZenColors.zenTextPrimary)

      Text(this.label)
        .fontSize(11)
        .fontWeight(FontWeight.Regular)
        .fontColor(ZenColors.zenTextSecondary)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// MARK: - StatusRow
@Component
struct StatusRow {
  build() {
    Row() {
      Blank()
      StatusItem({
        icon: $r('sys.symbol.heart_fill'),
        label: 'Health',
        value: '98%',
        tint: ZenColors.healthRed
      })
      Blank()
      StatusItem({
        icon: $r('sys.symbol.calendar'),
        label: 'Age',
        value: '4 Yrs',
        tint: ZenColors.zenBrown
      })
      Blank()
      StatusItem({
        icon: $r('sys.symbol.checkmark_circle_fill'),
        label: 'Water',
        value: '2 Days',
        tint: ZenColors.waterBlue
      })
      Blank()
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

// MARK: - CareLogItem
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
        .fill(this.isDone ? ZenColors.zenGreen : ZenColors.lightGrayCircle)

      Blank().width(16)

      Column({ space: 0 }) {
        Text(this.title)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(this.isDone ? ZenColors.zenTextPrimary : ZenColors.zenTextSecondary)
          .textAlign(TextAlign.Start)

        Text(this.subtitle)
          .fontSize(11)
          .fontWeight(FontWeight.Regular)
          .fontColor(ZenColors.careLogSubtitle)
          .textAlign(TextAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      if (this.isDone) {
        Image($r('sys.symbol.checkmark'))
          .width(20)
          .height(20)
          .fillColor(ZenColors.zenGreen)
          .objectFit(ImageFit.Contain)
      }
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .backgroundColor(ZenColors.careLogBg)
    .borderRadius(12)
    .border({ width: 1, color: ZenColors.careLogBorder, radius: 12 })
  }
}

// MARK: - ActivityLogSection
@Component
struct ActivityLogSection {
  build() {
    Column({ space: 0 }) {
      Row() {
        Text('Care Schedule')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(ZenColors.zenTextPrimary)

        Blank()

        Stack() {
          Circle()
            .width(28)
            .height(28)
            .fill(ZenColors.zenGreenLight)

          Image($r('sys.symbol.plus'))
            .width(20)
            .height(20)
            .fillColor(ZenColors.zenGreen)
            .objectFit(ImageFit.Contain)
        }
        .width(28)
        .height(28)
        .onClick(() => {
          // Handle add log action
        })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Blank().height(16)

      CareLogItem({ title: 'Watering', subtitle: 'Today, 8:00 AM', isDone: true })

      Blank().height(12)

      CareLogItem({ title: 'Pruning', subtitle: 'Tomorrow', isDone: false })

      Blank().height(12)

      CareLogItem({ title: 'Fertilizer', subtitle: 'In 5 days', isDone: false })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// MARK: - NavIcon
@Component
struct NavIcon {
  icon: ResourceStr = $r('sys.symbol.house_fill');
  isSelected: boolean = false;

  build() {
    Column({ space: 0 }) {
      Image(this.icon)
        .width(28)
        .height(28)
        .fillColor(this.isSelected ? ZenColors.zenGreen : ZenColors.navIconInactive)
        .objectFit(ImageFit.Contain)

      if (this.isSelected) {
        Blank().height(4)
        Circle()
          .width(4)
          .height(4)
          .fill(ZenColors.zenGreen)
      }
    }
    .alignItems(HorizontalAlign.Center)
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
  }
}

// MARK: - SimpleBottomNav
@Component
struct SimpleBottomNav {
  build() {
    Column({ space: 0 }) {
      Divider()
        .color(ZenColors.bottomBarDivider)
        .strokeWidth(1)

      Row({ space: 0 }) {
        NavIcon({ icon: $r('sys.symbol.house_fill'), isSelected: true })
        NavIcon({ icon: $r('sys.symbol.info_circle_fill'), isSelected: false })
        NavIcon({ icon: $r('sys.symbol.gearshape_fill'), isSelected: false })
      }
      .width('100%')
      .height(80)
      .backgroundColor(ZenColors.zenWhite)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor(ZenColors.zenWhite)
  }
}

// MARK: - BonsaiVisual (Custom Canvas Drawing)
@Component
struct BonsaiVisual {
  build() {
    Canvas(new CanvasRenderingContext2D(new RenderingContextSettings(true)))
      .width('100%')
      .height('100%')
      .onReady((context: CanvasRenderingContext2D) => {
        const w = context.width;
        const h = context.height;

        // 1. Draw pot
        const potWidth = w * 0.5;
        const potHeight = h * 0.15;
        const potTop = h * 0.85;

        context.fillStyle = ZenColors.zenBrown;
        context.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight);

        // Pot rim
        context.fillStyle = 'rgba(141, 110, 99, 0.8)';
        context.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15);

        // 2. Draw trunk (bezier curves)
        context.beginPath();
        context.moveTo(w * 0.5, potTop);
        context.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5);
        context.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3);
        context.strokeStyle = ZenColors.trunkColor;
        context.lineWidth = 25;
        context.lineCap = 'round';
        context.stroke();

        // Secondary branch
        context.beginPath();
        context.moveTo(w * 0.38, h * 0.55);
        context.lineTo(w * 0.25, h * 0.45);
        context.strokeStyle = ZenColors.trunkColor;
        context.lineWidth = 15;
        context.lineCap = 'round';
        context.stroke();

        // 3. Draw leaves (circular clusters)
        // Cluster 1 (top right)
        context.fillStyle = ZenColors.zenGreen;
        context.beginPath();
        context.ellipse(w * 0.6, h * 0.25, 45, 45, 0, 0, Math.PI * 2);
        context.fill();

        context.fillStyle = 'rgba(106, 142, 106, 0.8)';
        context.beginPath();
        context.ellipse(w * 0.68, h * 0.28, 35, 35, 0, 0, Math.PI * 2);
        context.fill();

        context.fillStyle = 'rgba(106, 142, 106, 0.9)';
        context.beginPath();
        context.ellipse(w * 0.55, h * 0.22, 30, 30, 0, 0, Math.PI * 2);
        context.fill();

        // Cluster 2 (middle left)
        context.fillStyle = ZenColors.zenGreen;
        context.beginPath();
        context.ellipse(w * 0.35, h * 0.5, 35, 35, 0, 0, Math.PI * 2);
        context.fill();

        context.fillStyle = 'rgba(106, 142, 106, 0.8)';
        context.beginPath();
        context.ellipse(w * 0.30, h * 0.45, 25, 25, 0, 0, Math.PI * 2);
        context.fill();

        // Cluster 3 (far left branch)
        context.fillStyle = ZenColors.zenGreen;
        context.beginPath();
        context.ellipse(w * 0.22, h * 0.42, 25, 25, 0, 0, Math.PI * 2);
        context.fill();
      })
  }
}

// MARK: - Main Content View
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
        .padding({ left: 24, right: 24 })
        .backgroundColor(ZenColors.zenWhite)
        .width('100%')
        .padding({ bottom: 80 })
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(ZenColors.zenWhite)
      .scrollBar(BarState.Off)

      SimpleBottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ZenColors.zenWhite)
  }
}

// MARK: - Entry Point
@Entry
@Component
struct Index {
  build() {
    ZenBonsaiAppView()
      .width('100%')
      .height('100%')
  }
}