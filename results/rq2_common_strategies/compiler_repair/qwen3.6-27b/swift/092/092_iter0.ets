import { window } from '@kit.ArkUI';

// MARK: - Color Palette (Custom Muted Earth Tones)
const Colors = {
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
  waterBlue: '#64B5F6'
};

// MARK: - Typography Mapping
const Typography = {
  labelMedium: { size: 12, weight: FontWeight.Medium },
  displaySmallLight: { size: 36, weight: FontWeight.Light },
  titleMediumBold: { size: 16, weight: FontWeight.Bold },
  titleMediumSemiBold: { size: 16, weight: FontWeight.SemiBold },
  labelSmall: { size: 11, weight: FontWeight.Normal },
  bodyMedium: { size: 14, weight: FontWeight.Normal }
};

@Entry
@Component
struct ZenBonsaiAppView {
  build() {
    Column() {
      Stack({ alignContent: Alignment.Bottom }) {
        // Main Content Area
        Scroll() {
          Column() {
            HeaderSection()
              .padding({ top: 24 })

            Divider().height(32).width(0)

            BonsaiVisual()
              .width(220)
              .height(220)

            Divider().height(32).width(0)

            StatusRow()

            Divider().height(32).width(0)

            ActivityLogSection()
              .padding({ bottom: 24 })
          }
          .padding({ left: 24, right: 24 })
          .backgroundColor(Colors.zenWhite)
          .padding({ bottom: 80 }) // Space for Bottom Nav
        }
        .layoutWeight(1)
        .backgroundColor(Colors.zenWhite)

        // Bottom Navigation Bar
        SimpleBottomNav()
          .backgroundColor(Colors.zenWhite)
      }
      .backgroundColor(Colors.zenWhite)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.zenWhite)
  }
}

@Component
struct HeaderSection {
  build() {
    Column() {
      Text("JUNIPER · #04")
        .font(Typography.labelMedium)
        .fontColor(Colors.zenTextSecondary)
        .letterSpacing(2)

      Divider().height(8).width(0)

      Text("Zen Garden")
        .font(Typography.displaySmallLight)
        .fontColor(Colors.zenTextPrimary)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StatusRow {
  build() {
    Row() {
      StatusItem({ icon: 'heart.fill', label: 'Health', value: '98%', tint: Colors.healthRed })
      StatusItem({ icon: 'calendar', label: 'Age', value: '4 Yrs', tint: Colors.zenBrown })
      StatusItem({ icon: 'checkmark.circle.fill', label: 'Water', value: '2 Days', tint: Colors.waterBlue })
    }
    .justifyContent(FlexAlign.SpaceEvenly)
    .width('100%')
  }
}

@Component
struct StatusItem {
  @Prop icon: string;
  @Prop label: string;
  @Prop value: string;
  @Prop tint: string;

  build() {
    Column() {
      Stack() {
        Circle()
          .fill(Colors.statusItemBg)
          .width(50)
          .height(50)
          .border({ width: 1, color: Colors.statusItemBorder })

        Image($r(`app.media.${this.icon}`))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .fillColor(this.tint)
      }

      Divider().height(8).width(0)

      Text(this.value)
        .font(Typography.titleMediumBold)
        .fontColor(Colors.zenTextPrimary)

      Text(this.label)
        .font(Typography.labelSmall)
        .fontColor(Colors.zenTextSecondary)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ActivityLogSection {
  build() {
    Column() {
      Row() {
        Text("Care Schedule")
          .font(Typography.titleMediumSemiBold)
          .fontColor(Colors.zenTextPrimary)

        Blank()

        Row() {
          Image($r('app.media.plus'))
            .width(20)
            .height(20)
            .objectFit(ImageFit.Contain)
            .fillColor(Colors.zenGreen)
        }
        .width(28)
        .height(28)
        .backgroundColor(Colors.zenGreenLight)
        .borderRadius(14)
        .onClick(() => {
          // Handle add log action
        })
      }
      .width('100%')

      Divider().height(16).width(0)

      CareLogItem({ title: "Watering", subtitle: "Today, 8:00 AM", isDone: true })
      Divider().height(12).width(0)
      CareLogItem({ title: "Pruning", subtitle: "Tomorrow", isDone: false })
      Divider().height(12).width(0)
      CareLogItem({ title: "Fertilizer", subtitle: "In 5 days", isDone: false })
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
      Circle()
        .fill(this.isDone ? Colors.zenGreen : Colors.lightGrayCircle)
        .width(12)
        .height(12)

      Divider().width(16).height(0)

      Column() {
        Text(this.title)
          .font(Typography.bodyMedium)
          .fontColor(this.isDone ? Colors.zenTextPrimary : Colors.zenTextSecondary)

        Text(this.subtitle)
          .font(Typography.labelSmall)
          .fontColor(Colors.careLogSubtitle)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      if (this.isDone) {
        Image($r('app.media.checkmark'))
          .width(20)
          .height(20)
          .objectFit(ImageFit.Contain)
          .fillColor(Colors.zenGreen)
      }
    }
    .padding(16)
    .backgroundColor(Colors.careLogBg)
    .borderRadius(12)
    .border({ width: 1, color: Colors.careLogBorder })
    .width('100%')
  }
}

@Component
struct SimpleBottomNav {
  build() {
    Column() {
      Divider()
        .color(Colors.bottomBarDivider)
        .height(1)

      Row() {
        NavIcon({ icon: 'house.fill', isSelected: true })
        NavIcon({ icon: 'info.circle.fill', isSelected: false })
        NavIcon({ icon: 'gearshape.fill', isSelected: false })
      }
      .width('100%')
      .height(80)
      .backgroundColor(Colors.zenWhite)
    }
  }
}

@Component
struct NavIcon {
  @Prop icon: string;
  @Prop isSelected: boolean;

  build() {
    Column() {
      Image($r(`app.media.${this.icon}`))
        .width(28)
        .height(28)
        .objectFit(ImageFit.Contain)
        .fillColor(this.isSelected ? Colors.zenGreen : Colors.navIconInactive)

      if (this.isSelected) {
        Divider().height(4).width(0)
        Circle()
          .fill(Colors.zenGreen)
          .width(4)
          .height(4)
      }
    }
    .alignItems(HorizontalAlign.Center)
    .layoutWeight(1)
  }
}

@Component
struct BonsaiVisual {
  draw(canvas: CanvasRenderingContext2D, width: number, height: number) {
    const w = width;
    const h = height;

    // 1. Draw Pot
    const potWidth = w * 0.5;
    const potHeight = h * 0.15;
    const potTop = h * 0.85;

    canvas.fillStyle = Colors.zenBrown;
    canvas.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight);

    // Pot Rim
    canvas.fillStyle = Colors.zenBrown;
    canvas.globalAlpha = 0.8;
    canvas.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15);
    canvas.globalAlpha = 1.0;

    // 2. Draw Trunk (Bezier Curve)
    canvas.beginPath();
    canvas.moveTo(w * 0.5, potTop); // Bottom center
    // Curve up and left
    canvas.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5);
    // Curve right
    canvas.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3);

    canvas.strokeStyle = Colors.trunkColor;
    canvas.lineWidth = 25;
    canvas.lineCap = 'round';
    canvas.stroke();

    // Secondary Branch
    canvas.beginPath();
    canvas.moveTo(w * 0.38, h * 0.55);
    canvas.lineTo(w * 0.25, h * 0.45);
    canvas.lineWidth = 15;
    canvas.stroke();

    // 3. Draw Leaves (Circular Clusters)
    // Cluster 1 (Top Right)
    this.drawLeafCluster(canvas, w * 0.6, h * 0.25, 45, Colors.zenGreen, 1.0);
    this.drawLeafCluster(canvas, w * 0.68, h * 0.28, 35, Colors.zenGreen, 0.8);
    this.drawLeafCluster(canvas, w * 0.55, h * 0.22, 30, Colors.zenGreen, 0.9);

    // Cluster 2 (Mid Left)
    this.drawLeafCluster(canvas, w * 0.35, h * 0.5, 35, Colors.zenGreen, 1.0);
    this.drawLeafCluster(canvas, w * 0.30, h * 0.45, 25, Colors.zenGreen, 0.8);

    // Cluster 3 (Far Left Branch)
    this.drawLeafCluster(canvas, w * 0.22, h * 0.42, 25, Colors.zenGreen, 1.0);
  }

  private drawLeafCluster(ctx: CanvasRenderingContext2D, cx: number, cy: number, radius: number, color: string, opacity: number) {
    ctx.beginPath();
    ctx.arc(cx, cy, radius, 0, Math.PI * 2);
    ctx.fillStyle = color;
    ctx.globalAlpha = opacity;
    ctx.fill();
    ctx.globalAlpha = 1.0;
  }

  build() {
    CustomPainter({ painter: this.draw }).width('100%').height('100%')
  }
}