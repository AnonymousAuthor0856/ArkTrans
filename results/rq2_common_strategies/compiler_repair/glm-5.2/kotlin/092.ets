// Index.ets
import { drawing } from '@kit.ArkGraphics2D';

// --- Color Palette (Custom Muted Earth Tones) ---
const ZenGreen: string = '#6A8E6A';
const ZenGreenLight: string = '#E8F5E9';
const ZenBrown: string = '#8D6E63';
const ZenTextPrimary: string = '#2C3E50';
const ZenTextSecondary: string = '#7F8C8D';
const ZenWhite: string = '#FFFFFF';

@Entry
@Component
struct ZenBonsaiApp {
  build() {
    Column() {
      Column() {
        // Header
        HeaderSection()

        Blank().height(32)

        // Hero Image (Custom Drawing)
        BonsaiVisual({ size: 220 })

        Blank().height(32)

        // Status Cards
        StatusRow()

        Blank().height(32)

        // Recent Activity
        ActivityLogSection()
      }
      .width('100%')
      .height('100%')
      .padding(24)
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
        .fontSize(36)
        .fontColor(ZenTextPrimary)
        .fontWeight(FontWeight.Lighter)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StatusRow {
  build() {
    Row() {
      StatusItem({ icon: $r('sys.symbol.heart'), label: 'Health', value: '98%', tint: '#E57373' })
      StatusItem({ icon: $r('sys.symbol.calendar'), label: 'Age', value: '4 Yrs', tint: ZenBrown })
      StatusItem({ icon: $r('sys.symbol.checkmark_circle'), label: 'Water', value: '2 Days', tint: '#64B5F6' })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}

@Component
struct StatusItem {
  @Prop icon: Resource;
  @Prop label: string;
  @Prop value: string;
  @Prop tint: string;

  build() {
    Column() {
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

      Blank().height(8)

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(ZenTextPrimary)

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
          .fontSize(18)
          .fontWeight(FontWeight.Medium)

        Blank()

        Column() {
          Image($r('sys.symbol.plus'))
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
  @Prop title: string;
  @Prop subtitle: string;
  @Prop isDone: boolean;

  build() {
    Row() {
      // Status Dot
      Column() {
        if (this.isDone) {
          Text('').width(12).height(12).backgroundColor(ZenGreen).borderRadius(6)
        } else {
          Text('').width(12).height(12).backgroundColor('#E0E0E0').borderRadius(6)
        }
      }
      .width(12)
      .height(12)

      Blank().width(16)

      Column() {
        Text(this.title)
          .fontSize(14)
          .fontColor(this.isDone ? ZenTextPrimary : ZenTextSecondary)
        Text(this.subtitle)
          .fontSize(11)
          .fontColor('#9E9E9E')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      if (this.isDone) {
        Image($r('sys.symbol.checkmark'))
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
      NavIcon({ icon: $r('sys.symbol.house'), isSelected: true })
      NavIcon({ icon: $r('sys.symbol.info'), isSelected: false })
      NavIcon({ icon: $r('sys.symbol.gearshape'), isSelected: false })
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
  @Prop icon: Resource;
  @Prop isSelected: boolean;

  build() {
    Column() {
      Image(this.icon)
        .width(28)
        .height(28)
        .fillColor(this.isSelected ? ZenGreen : '#CFD8DC')

      if (this.isSelected) {
        Blank().height(4)
        Text('').width(4).height(4).backgroundColor(ZenGreen).borderRadius(2)
      }
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct BonsaiVisual {
  @Prop size: number = 220;

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Canvas(this)
        .width(this.size)
        .height(this.size)
        .onReady((context: RenderingContextSettings) => {
          let ctx = context as CanvasRenderingContext2D;
          let w = this.size;
          let h = this.size;

          // 1. Draw Pot
          let potWidth = w * 0.5;
          let potHeight = h * 0.15;
          let potTop = h * 0.85;

          ctx.fillStyle = ZenBrown;
          ctx.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight);

          // Pot Rim
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
          ctx.beginPath();
          ctx.arc(w * 0.6, h * 0.25, 45, 0, 2 * Math.PI);
          ctx.fillStyle = ZenGreen;
          ctx.fill();

          ctx.beginPath();
          ctx.globalAlpha = 0.8;
          ctx.arc(w * 0.68, h * 0.28, 35, 0, 2 * Math.PI);
          ctx.fill();

          ctx.beginPath();
          ctx.globalAlpha = 0.9;
          ctx.arc(w * 0.55, h * 0.22, 30, 0, 2 * Math.PI);
          ctx.fill();
          ctx.globalAlpha = 1.0;

          // Cluster 2 (Middle Left)
          ctx.beginPath();
          ctx.arc(w * 0.35, h * 0.5, 35, 0, 2 * Math.PI);
          ctx.fillStyle = ZenGreen;
          ctx.fill();

          ctx.beginPath();
          ctx.globalAlpha = 0.8;
          ctx.arc(w * 0.30, h * 0.45, 25, 0, 2 * Math.PI);
          ctx.fill();
          ctx.globalAlpha = 1.0;

          // Cluster 3 (Far Left Branch)
          ctx.beginPath();
          ctx.arc(w * 0.22, h * 0.42, 25, 0, 2 * Math.PI);
          ctx.fillStyle = ZenGreen;
          ctx.fill();
        })
    }
    .width(this.size)
    .height(this.size)
  }
}