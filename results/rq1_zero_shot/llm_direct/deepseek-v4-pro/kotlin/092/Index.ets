import { ComponentContent, UIContext } from '@kit.ArkUI';

@Entry
@Component
struct ZenBonsaiApp {
  @State selectedNav: number = 0;

  // Color Palette
  private zenGreen: string = '#6A8E6A';
  private zenGreenLight: string = '#E8F5E9';
  private zenBrown: string = '#8D6E63';
  private zenTextPrimary: string = '#2C3E50';
  private zenTextSecondary: string = '#7F8C8D';
  private zenWhite: string = '#FFFFFF';
  private zenAccent: string = '#D4E157';

  build() {
    Column() {
      // Main Content
      Scroll() {
        Column({ space: 24 }) {
          this.HeaderSection()
          this.BonsaiVisual()
          this.StatusRow()
          this.ActivityLogSection()
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 24, bottom: 24 })
        .alignItems(HorizontalAlign.Center)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Navigation
      this.SimpleBottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.zenWhite)
  }

  @Builder
  HeaderSection() {
    Column({ space: 8 }) {
      Text('JUNIPER · #04')
        .fontSize(12)
        .fontColor(this.zenTextSecondary)
        .letterSpacing(2)
        .fontWeight(FontWeight.Medium)

      Text('Zen Garden')
        .fontSize(36)
        .fontColor(this.zenTextPrimary)
        .fontWeight(FontWeight.Light)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  StatusRow() {
    Row() {
      this.StatusItem('♥', 'Health', '98%', '#E57373')
      this.StatusItem('📅', 'Age', '4 Yrs', this.zenBrown)
      this.StatusItem('✓', 'Water', '2 Days', '#64B5F6')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  @Builder
  StatusItem(icon: string, label: string, value: string, tint: string) {
    Column({ space: 8 }) {
      Stack() {
        Text(icon)
          .fontSize(24)
          .fontColor(tint)
      }
      .width(50)
      .height(50)
      .backgroundColor('#F7F9F9')
      .borderRadius(25)
      .border({ width: 1, color: '#ECEFF1' })
      .alignContent(Alignment.Center)

      Text(value)
        .fontSize(16)
        .fontColor(this.zenTextPrimary)
        .fontWeight(FontWeight.Bold)

      Text(label)
        .fontSize(11)
        .fontColor(this.zenTextSecondary)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ActivityLogSection() {
    Column({ space: 16 }) {
      Row() {
        Text('Care Schedule')
          .fontSize(16)
          .fontColor(this.zenTextPrimary)
          .fontWeight(FontWeight.Medium)

        Blank()

        Stack() {
          Text('+')
            .fontSize(20)
            .fontColor(this.zenGreen)
        }
        .width(28)
        .height(28)
        .backgroundColor(this.zenGreenLight)
        .borderRadius(14)
        .alignContent(Alignment.Center)
        .onClick(() => {
          console.info('Add log clicked');
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      this.CareLogItem('Watering', 'Today, 8:00 AM', true)
      this.CareLogItem('Pruning', 'Tomorrow', false)
      this.CareLogItem('Fertilizer', 'In 5 days', false)
    }
    .width('100%')
  }

  @Builder
  CareLogItem(title: string, subtitle: string, isDone: boolean) {
    Row({ space: 16 }) {
      Circle()
        .width(12)
        .height(12)
        .fill(isDone ? this.zenGreen : '#E0E0E0')

      Column({ space: 4 }) {
        Text(title)
          .fontSize(14)
          .fontColor(isDone ? this.zenTextPrimary : this.zenTextSecondary)
          .fontWeight(FontWeight.Medium)

        Text(subtitle)
          .fontSize(11)
          .fontColor('#9E9E9E')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      if (isDone) {
        Text('✓')
          .fontSize(20)
          .fontColor(this.zenGreen)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(12)
    .border({ width: 1, color: '#F0F0F0' })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SimpleBottomNav() {
    Row() {
      this.NavIcon('⌂', 0)
      this.NavIcon('ℹ', 1)
      this.NavIcon('⚙', 2)
    }
    .width('100%')
    .height(80)
    .backgroundColor(this.zenWhite)
    .border({ width: { top: 1 }, color: '#F5F5F5' })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  NavIcon(icon: string, index: number) {
    Column({ space: 4 }) {
      Text(icon)
        .fontSize(28)
        .fontColor(this.selectedNav === index ? this.zenGreen : '#CFD8DC')

      if (this.selectedNav === index) {
        Circle()
          .width(4)
          .height(4)
          .fill(this.zenGreen)
      }
    }
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.selectedNav = index;
    })
  }

  @Builder
  BonsaiVisual() {
    Stack() {
      Canvas(this.renderBonsai)
        .width(220)
        .height(220)
    }
    .width(220)
    .height(220)
    .alignContent(Alignment.Bottom)
  }

  private renderBonsai = (context: CanvasRenderingContext2D, width: number, height: number) => {
    const w = width;
    const h = height;

    // 1. Draw Pot
    const potWidth = w * 0.5;
    const potHeight = h * 0.15;
    const potTop = h * 0.85;

    // Pot body
    context.fillStyle = this.zenBrown;
    context.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight);

    // Pot Rim
    context.globalAlpha = 0.8;
    context.fillStyle = this.zenBrown;
    context.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15);
    context.globalAlpha = 1.0;

    // 2. Draw Trunk (Bezier curves)
    context.strokeStyle = '#5D4037';
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

    // 3. Draw Leaves (Clusters of circles)
    // Cluster 1 (Top Right)
    context.fillStyle = this.zenGreen;
    context.beginPath();
    context.arc(w * 0.6, h * 0.25, 45, 0, Math.PI * 2);
    context.fill();

    context.globalAlpha = 0.8;
    context.beginPath();
    context.arc(w * 0.68, h * 0.28, 35, 0, Math.PI * 2);
    context.fill();

    context.globalAlpha = 0.9;
    context.beginPath();
    context.arc(w * 0.55, h * 0.22, 30, 0, Math.PI * 2);
    context.fill();
    context.globalAlpha = 1.0;

    // Cluster 2 (Middle Left)
    context.fillStyle = this.zenGreen;
    context.beginPath();
    context.arc(w * 0.35, h * 0.5, 35, 0, Math.PI * 2);
    context.fill();

    context.globalAlpha = 0.8;
    context.beginPath();
    context.arc(w * 0.30, h * 0.45, 25, 0, Math.PI * 2);
    context.fill();
    context.globalAlpha = 1.0;

    // Cluster 3 (Far Left Branch)
    context.fillStyle = this.zenGreen;
    context.beginPath();
    context.arc(w * 0.22, h * 0.42, 25, 0, Math.PI * 2);
    context.fill();
  };
}