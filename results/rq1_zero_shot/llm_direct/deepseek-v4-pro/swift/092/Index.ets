@Entry
@Component
struct ZenBonsaiApp {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column({ space: 0 }) {
          HeaderSection()
            .margin({ top: 24 })

          Blank()
            .height(32)

          BonsaiVisual()
            .width(220)
            .height(220)

          Blank()
            .height(32)

          StatusRow()

          Blank()
            .height(32)

          ActivityLogSection()
            .margin({ bottom: 24 })
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
        .backgroundColor('#FFFFFF')
        .padding({ bottom: 80 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      SimpleBottomNav()
        .width('100%')
        .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct HeaderSection {
  build() {
    Column({ space: 0 }) {
      Text('JUNIPER · #04')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#7F8C8D')
        .letterSpacing(2)

      Blank()
        .height(8)

      Text('Zen Garden')
        .fontSize(36)
        .fontWeight(FontWeight.Light)
        .fontColor('#2C3E50')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StatusRow {
  build() {
    Row({ space: 0 }) {
      Blank()
      StatusItem({ icon: '❤️', label: 'Health', value: '98%', tint: '#E57373' })
      Blank()
      StatusItem({ icon: '📅', label: 'Age', value: '4 Yrs', tint: '#8D6E63' })
      Blank()
      StatusItem({ icon: '✅', label: 'Water', value: '2 Days', tint: '#64B5F6' })
      Blank()
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct StatusItem {
  @Prop icon: string = ''
  @Prop label: string = ''
  @Prop value: string = ''
  @Prop tint: string = '#000000'

  build() {
    Column({ space: 0 }) {
      Stack() {
        Circle()
          .width(50)
          .height(50)
          .fill('#F7F9F9')
          .stroke('#ECEFF1', 1)

        Text(this.icon)
          .fontSize(24)
          .fontColor(this.tint)
      }
      .width(50)
      .height(50)

      Blank()
        .height(8)

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2C3E50')

      Text(this.label)
        .fontSize(11)
        .fontWeight(FontWeight.Regular)
        .fontColor('#7F8C8D')
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ActivityLogSection {
  build() {
    Column({ space: 0 }) {
      Row({ space: 0 }) {
        Text('Care Schedule')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2C3E50')

        Blank()

        Text('+')
          .fontSize(20)
          .fontColor('#6A8E6A')
          .width(28)
          .height(28)
          .textAlign(TextAlign.Center)
          .backgroundColor('#E8F5E9')
          .borderRadius(14)
          .onClick(() => {
            // Handle add log action
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank()
        .height(16)

      CareLogItem({ title: 'Watering', subtitle: 'Today, 8:00 AM', isDone: true })

      Blank()
        .height(12)

      CareLogItem({ title: 'Pruning', subtitle: 'Tomorrow', isDone: false })

      Blank()
        .height(12)

      CareLogItem({ title: 'Fertilizer', subtitle: 'In 5 days', isDone: false })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct CareLogItem {
  @Prop title: string = ''
  @Prop subtitle: string = ''
  @Prop isDone: boolean = false

  build() {
    Row({ space: 0 }) {
      Circle()
        .width(12)
        .height(12)
        .fill(this.isDone ? '#6A8E6A' : '#E0E0E0')

      Blank()
        .width(16)

      Column({ space: 0 }) {
        Text(this.title)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(this.isDone ? '#2C3E50' : '#7F8C8D')

        Text(this.subtitle)
          .fontSize(11)
          .fontWeight(FontWeight.Regular)
          .fontColor('#9E9E9E')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      if (this.isDone) {
        Text('✓')
          .fontSize(20)
          .fontColor('#6A8E6A')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(12)
    .border({ width: 1, color: '#F0F0F0', radius: 12 })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct SimpleBottomNav {
  build() {
    Column({ space: 0 }) {
      Divider()
        .strokeWidth(1)
        .color('#F5F5F5')

      Row({ space: 0 }) {
        NavIcon({ icon: '🏠', isSelected: true })
        NavIcon({ icon: 'ℹ️', isSelected: false })
        NavIcon({ icon: '⚙️', isSelected: false })
      }
      .width('100%')
      .height(80)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
  }
}

@Component
struct NavIcon {
  @Prop icon: string = ''
  @Prop isSelected: boolean = false

  build() {
    Column({ space: 0 }) {
      Text(this.icon)
        .fontSize(28)
        .fontColor(this.isSelected ? '#6A8E6A' : '#CFD8DC')

      if (this.isSelected) {
        Blank()
          .height(4)

        Circle()
          .width(4)
          .height(4)
          .fill('#6A8E6A')
      }
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct BonsaiVisual {
  build() {
    Canvas(this.renderBonsai)
      .width('100%')
      .height('100%')
  }

  private renderBonsai = (context: CanvasRenderingContext2D, width: number, height: number) => {
    const w = width;
    const h = height;

    // 1. Draw pot
    const potWidth = w * 0.5;
    const potHeight = h * 0.15;
    const potTop = h * 0.85;

    context.fillStyle = '#8D6E63';
    context.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight);

    context.fillStyle = 'rgba(141, 110, 99, 0.8)';
    context.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15);

    // 2. Draw trunk (bezier curve)
    context.strokeStyle = '#5D4037';
    context.lineWidth = 25;
    context.lineCap = 'round';
    context.beginPath();
    context.moveTo(w * 0.5, potTop);
    context.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5);
    context.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3);
    context.stroke();

    // Secondary branch
    context.lineWidth = 15;
    context.beginPath();
    context.moveTo(w * 0.38, h * 0.55);
    context.lineTo(w * 0.25, h * 0.45);
    context.stroke();

    // 3. Draw leaves (circular clusters)
    // Leaf cluster 1 (top right)
    context.fillStyle = '#6A8E6A';
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

    // Leaf cluster 2 (middle left)
    context.fillStyle = '#6A8E6A';
    context.beginPath();
    context.ellipse(w * 0.35, h * 0.5, 35, 35, 0, 0, Math.PI * 2);
    context.fill();

    context.fillStyle = 'rgba(106, 142, 106, 0.8)';
    context.beginPath();
    context.ellipse(w * 0.30, h * 0.45, 25, 25, 0, 0, Math.PI * 2);
    context.fill();

    // Leaf cluster 3 (leftmost branch)
    context.fillStyle = '#6A8E6A';
    context.beginPath();
    context.ellipse(w * 0.22, h * 0.42, 25, 25, 0, 0, Math.PI * 2);
    context.fill();
  }
}