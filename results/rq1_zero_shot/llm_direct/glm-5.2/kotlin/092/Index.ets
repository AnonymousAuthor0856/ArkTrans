// index.ets
import drawing from '@ohos.graphics.drawing';

// --- Color Palette (Custom Muted Earth Tones) ---
const ZenGreen: string = '#6A8E6A';
const ZenGreenLight: string = '#E8F5E9';
const ZenBrown: string = '#8D6E63';
const ZenTextPrimary: string = '#2C3E50';
const ZenTextSecondary: string = '#7F8C8D';
const ZenWhite: string = '#FFFFFF';
const ZenAccent: string = '#D4E157';

@Entry
@Component
struct ZenBonsaiApp {
  build() {
    Column() {
      // Main Container
      Column() {
        // Header
        HeaderSection()

        // Hero Image (Custom Drawing)
        BonsaiVisual({ width: 220, height: 220 })

        // Status Cards
        StatusRow()

        // Recent Activity
        ActivityLogSection()
      }
      .width('100%')
      .height('100%')
      .padding(24)
      .backgroundColor(ZenWhite)
      .alignItems(HorizontalAlign.Center)

      // Bottom Nav
      SimpleBottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ZenWhite)
  }
}

@Component
struct HeaderSection {
  build() {
    Column() {
      Text('JUNIPER · #04')
        .fontSize(12)
        .fontColor(ZenTextSecondary)
        .letterSpacing(2)
        .margin({ bottom: 8 })

      Text('Zen Garden')
        .fontSize(32)
        .fontWeight(FontWeight.Lighter)
        .fontColor(ZenTextPrimary)
    }
    .alignItems(HorizontalAlign.Center)
    .margin({ top: 20 })
  }
}

@Component
struct StatusRow {
  build() {
    Row() {
      StatusItem({ icon: $r('sys.media.heart'), label: 'Health', value: '98%', tint: '#E57373' })
      StatusItem({ icon: $r('sys.media.calendar'), label: 'Age', value: '4 Yrs', tint: ZenBrown })
      StatusItem({ icon: $r('sys.media.checkmark_circle'), label: 'Water', value: '2 Days', tint: '#64B5F6' })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .margin({ top: 32 })
  }
}

@Component
struct StatusItem {
  private icon: Resource;
  private label: string;
  private value: string;
  private tint: string;

  build() {
    Column() {
      // Icon Container
      Column() {
        Image(this.icon)
          .width(24)
          .height(24)
          .fillColor(this.tint)
      }
      .width(50)
      .height(50)
      .backgroundColor('#F7F9F9')
      .borderRadius(25)
      .border({ width: 1, color: '#ECEFF1' })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(ZenTextPrimary)
        .margin({ top: 8 })

      Text(this.label)
        .fontSize(11)
        .fontColor(ZenTextSecondary)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ActivityLogSection {
  build() {
    Column() {
      Row() {
        Text('Care Schedule')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(ZenTextPrimary)

        // Add Log Button
        Row() {
          Image($r('sys.media.add'))
            .width(20)
            .height(20)
            .fillColor(ZenGreen)
        }
        .width(28)
        .height(28)
        .backgroundColor(ZenGreenLight)
        .borderRadius(14)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // List Items
      Column() {
        CareLogItem({ title: 'Watering', subtitle: 'Today, 8:00 AM', isDone: true })
        CareLogItem({ title: 'Pruning', subtitle: 'Tomorrow', isDone: false })
        CareLogItem({ title: 'Fertilizer', subtitle: 'In 5 days', isDone: false })
      }
      .margin({ top: 16 })
      .space(12)
    }
    .width('100%')
    .margin({ top: 32 })
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct CareLogItem {
  private title: string;
  private subtitle: string;
  private isDone: boolean;

  build() {
    Row() {
      // Status Dot
      Column() {
        if (this.isDone) {
          Column()
            .width(12)
            .height(12)
            .backgroundColor(ZenGreen)
            .borderRadius(6)
        } else {
          Column()
            .width(12)
            .height(12)
            .backgroundColor('#E0E0E0')
            .borderRadius(6)
        }
      }
      .width(12)
      .height(12)

      // Text Content
      Column() {
        Text(this.title)
          .fontSize(14)
          .fontColor(this.isDone ? ZenTextPrimary : ZenTextSecondary)
        Text(this.subtitle)
          .fontSize(11)
          .fontColor('#9E9E9E')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })

      // Check Icon
      if (this.isDone) {
        Image($r('sys.media.checkmark'))
          .width(20)
          .height(20)
          .fillColor(ZenGreen)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(12)
    .border({ width: 1, color: '#F0F0F0' })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct SimpleBottomNav {
  build() {
    Row() {
      NavIcon({ icon: $r('sys.media.home'), isSelected: true })
      NavIcon({ icon: $r('sys.media.info'), isSelected: false })
      NavIcon({ icon: $r('sys.media.settings'), isSelected: false })
    }
    .width('100%')
    .height(80)
    .backgroundColor(ZenWhite)
    .border({ width: 1, color: '#F5F5F5' })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct NavIcon {
  private icon: Resource;
  private isSelected: boolean;

  build() {
    Column() {
      Image(this.icon)
        .width(28)
        .height(28)
        .fillColor(this.isSelected ? ZenGreen : '#CFD8DC')

      if (this.isSelected) {
        Column()
          .width(4)
          .height(4)
          .backgroundColor(ZenGreen)
          .borderRadius(2)
          .margin({ top: 4 })
      }
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// --- Custom Art Logic ---
@Component
struct BonsaiVisual {
  private width: number = 220;
  private height: number = 220;

  build() {
    Canvas(this.context)
      .width(this.width)
      .height(this.height)
      .onReady(() => {
        this.drawBonsai();
      })
  }

  private context: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasRenderingContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.context);

  private drawBonsai() {
    const ctx = this.canvasRenderingContext;
    const w = this.width;
    const h = this.height;

    // 1. Draw Pot
    const potWidth = w * 0.5;
    const potHeight = h * 0.15;
    const potTop = h * 0.85;

    ctx.fillStyle = ZenBrown;
    ctx.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight);

    // Pot Rim
    ctx.fillStyle = ZenBrown;
    ctx.globalAlpha = 0.8;
    ctx.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15);
    ctx.globalAlpha = 1.0;

    // 2. Draw Trunk (Bezier curves)
    ctx.beginPath();
    ctx.moveTo(w * 0.5, potTop);
    ctx.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5);
    ctx.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3);
    ctx.strokeStyle = '#5D4037';
    ctx.lineWidth = 25;
    ctx.lineCap = 'round';
    ctx.stroke();

    // Secondary Branch
    ctx.beginPath();
    ctx.moveTo(w * 0.38, h * 0.55);
    ctx.lineTo(w * 0.25, h * 0.45);
    ctx.lineWidth = 15;
    ctx.stroke();

    // 3. Draw Leaves (Clusters of circles)
    // Cluster 1 (Top Right)
    ctx.fillStyle = ZenGreen;
    ctx.beginPath();
    ctx.arc(w * 0.6, h * 0.25, 45, 0, 2 * Math.PI);
    ctx.fill();

    ctx.globalAlpha = 0.8;
    ctx.beginPath();
    ctx.arc(w * 0.68, h * 0.28, 35, 0, 2 * Math.PI);
    ctx.fill();

    ctx.globalAlpha = 0.9;
    ctx.beginPath();
    ctx.arc(w * 0.55, h * 0.22, 30, 0, 2 * Math.PI);
    ctx.fill();
    ctx.globalAlpha = 1.0;

    // Cluster 2 (Middle Left)
    ctx.fillStyle = ZenGreen;
    ctx.beginPath();
    ctx.arc(w * 0.35, h * 0.5, 35, 0, 2 * Math.PI);
    ctx.fill();

    ctx.globalAlpha = 0.8;
    ctx.beginPath();
    ctx.arc(w * 0.30, h * 0.45, 25, 0, 2 * Math.PI);
    ctx.fill();
    ctx.globalAlpha = 1.0;

    // Cluster 3 (Far Left Branch)
    ctx.fillStyle = ZenGreen;
    ctx.beginPath();
    ctx.arc(w * 0.22, h * 0.42, 25, 0, 2 * Math.PI);
    ctx.fill();
  }
}