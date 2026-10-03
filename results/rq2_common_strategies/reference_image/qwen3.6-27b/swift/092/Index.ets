// entry/src/main/ets/view/ZenBonsaiApp.ets

@Entry
@Component
struct ZenBonsaiApp {
  @State private currentTab: number = 0;

  build() {
    Column() {
      // Main Scrollable Content
      Scroll() {
        Column() {
          HeaderSection()
            .padding({ top: 48, bottom: 32 })

          BonsaiVisual()
            .width(220)
            .height(220)
            .margin({ bottom: 32 })

          StatusRow()
            .margin({ bottom: 32 })

          ActivityLogSection()
            .margin({ bottom: 100 }) // Extra padding for bottom nav
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .layoutWeight(1)
      .backgroundColor('#FFFFFF')

      // Bottom Navigation Bar
      SimpleBottomNav({
        onSelect: (index: number) => {
          this.currentTab = index;
        }
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .statusBarConfig({ mode: StatusBarMode.Custom, color: '#000000', backgroundColor: '#FFFFFF' })
  }
}

// MARK: - Header Section
@Component
struct HeaderSection {
  build() {
    Column() {
      Text('JUNIPER · #04')
        .fontColor('#7F8C8D')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .letterSpacing(2)
      
      Text('Zen Garden')
        .fontColor('#2C3E50')
        .fontSize(36)
        .fontWeight(FontWeight.Light)
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// MARK: - Status Row
@Component
struct StatusRow {
  build() {
    Row() {
      StatusItem(iconSrc: $r('app.media.ic_heart'), label: 'Health', value: '98%', tint: '#E57373')
      StatusItem(iconSrc: $r('app.media.ic_calendar'), label: 'Age', value: '4 Yrs', tint: '#8D6E63')
      StatusItem(iconSrc: $r('app.media.ic_check_circle'), label: 'Water', value: '2 Days', tint: '#64B5F6')
    }
    .justifyContent(FlexAlign.SpaceEvenly)
    .width('100%')
    .padding({ left: 24, right: 24 })
  }
}

// MARK: - Status Item Component
@Component
struct StatusItem {
  iconSrc: Resource;
  label: string;
  value: string;
  tint: string;

  build() {
    Column() {
      Stack() {
        Circle()
          .fill('#F7F9F9')
          .width(50)
          .height(50)
          .border({ width: 1, color: '#ECEFF1' })

        Image(this.iconSrc)
          .width(24)
          .height(24)
          .fillColor(this.tint)
      }

      Text(this.value)
        .fontColor('#2C3E50')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 8 })

      Text(this.label)
        .fontColor('#7F8C8D')
        .fontSize(11)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// MARK: - Activity Log Section
@Component
struct ActivityLogSection {
  build() {
    Column() {
      // Header
      Row() {
        Text('Care Schedule')
          .fontColor('#2C3E50')
          .fontSize(16)
          .fontWeight(FontWeight.SemiBold)
        
        Blank()

        Row() {
          Text('+')
            .fontColor('#6A8E6A')
            .fontSize(24)
            .fontWeight(FontWeight.Normal)
        }
        .width(28)
        .height(28)
        .backgroundColor('#E8F5E9')
        .borderRadius(14)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .margin({ bottom: 16 })

      // List Items
      CareLogItem(title: 'Watering', subtitle: 'Today, 8:00 AM', isDone: true)
      CareLogItem(title: 'Pruning', subtitle: 'Tomorrow', isDone: false)
      CareLogItem(title: 'Fertilizer', subtitle: 'In 5 days', isDone: false)
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
  }
}

// MARK: - Care Log Item Component
@Component
struct CareLogItem {
  title: string;
  subtitle: string;
  isDone: boolean;

  build() {
    Row() {
      // Status Dot
      Circle()
        .fill(this.isDone ? '#6A8E6A' : '#E0E0E0')
        .width(12)
        .height(12)

      Column() {
        Text(this.title)
          .fontColor(this.isDone ? '#2C3E50' : '#7F8C8D')
          .fontSize(14)
        
        Text(this.subtitle)
          .fontColor('#9E9E9E')
          .fontSize(11)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })
      .layoutWeight(1)

      if (this.isDone) {
        Text('✓') // Using text character as placeholder for vector asset
          .fontColor('#6A8E6A')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(12)
    .border({ width: 1, color: '#F0F0F0' })
    .margin({ bottom: 12 })
  }
}

// MARK: - Bottom Navigation
@Component
struct SimpleBottomNav {
  private onSelect: (index: number) => void = () => {};

  build() {
    Column() {
      Divider().color('#F5F5F5').strokeWidth(1)
      
      Row() {
        NavIcon(iconSrc: $r('app.media.ic_home'), isSelected: true)
        NavIcon(iconSrc: $r('app.media.ic_info'), isSelected: false)
        NavIcon(iconSrc: $r('app.media.ic_settings'), isSelected: false)
      }
      .width('100%')
      .height(80)
      .justifyContent(FlexAlign.SpaceAround)
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct NavIcon {
  iconSrc: Resource;
  isSelected: boolean;

  build() {
    Column() {
      Image(this.iconSrc)
        .width(28)
        .height(28)
        .fillColor(this.isSelected ? '#6A8E6A' : '#CFD8DC')
      
      if (this.isSelected) {
        Circle()
          .fill('#6A8E6A')
          .width(4)
          .height(4)
          .margin({ top: 4 })
      }
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// MARK: - Custom Art Logic (Bonsai Visual)
@Component
struct BonsaiVisual {
  build() {
    CanvasRenderingContext2D()
      .draw((context: CanvasRenderingContext2D, size: Size) => {
        const w = size.width;
        const h = size.height;

        // 1. Draw Pot
        context.fillStyle = '#8D6E63';
        // Main pot body
        context.fillRect(w * 0.25, h * 0.85, w * 0.5, h * 0.15);
        // Pot rim
        context.fillStyle = '#795548'; // Slightly darker brown
        context.fillRect(w * 0.2, h * 0.85, w * 0.6, h * 0.03);

        // 2. Draw Trunk (Bezier Curve)
        context.beginPath();
        context.moveTo(w * 0.5, h * 0.85); // Start at center of pot
        // Curve up and slightly left
        context.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5);
        // Curve right towards top foliage
        context.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3);
        
        context.lineWidth = 25;
        context.lineCap = 'round';
        context.strokeStyle = '#5D4037';
        context.stroke();

        // Secondary Branch (Left)
        context.beginPath();
        context.moveTo(w * 0.38, h * 0.55);
        context.lineTo(w * 0.25, h * 0.45);
        context.lineWidth = 15;
        context.stroke();

        // 3. Draw Leaves (Circle Clusters)
        context.fillStyle = '#6A8E6A';

        // Cluster 1 (Top Right)
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

        // Cluster 2 (Middle Left)
        context.globalAlpha = 1.0;
        context.beginPath();
        context.arc(w * 0.35, h * 0.5, 35, 0, Math.PI * 2);
        context.fill();

        context.globalAlpha = 0.8;
        context.beginPath();
        context.arc(w * 0.30, h * 0.45, 25, 0, Math.PI * 2);
        context.fill();

        // Cluster 3 (Far Left Tip)
        context.globalAlpha = 1.0;
        context.beginPath();
        context.arc(w * 0.22, h * 0.42, 25, 0, Math.PI * 2);
        context.fill();
        
        // Reset Alpha
        context.globalAlpha = 1.0;
      })
      .width('100%')
      .height('100%')
  }
}