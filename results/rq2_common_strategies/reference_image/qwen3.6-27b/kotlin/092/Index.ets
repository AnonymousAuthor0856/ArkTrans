// entry/src/main/ets/viewpages/ZenBonsaiPage.ets

@Entry
@Component
struct ZenBonsaiPage {
  @State private currentTab: number = 0;

  build() {
    Column() {
      // Main Scrollable Content
      Scroll() {
        Column() {
          // Header Section
          this.HeaderSection()

          // Hero Image (Custom Drawing)
          this.BonsaiVisual()

          // Status Cards
          this.StatusRow()

          // Recent Activity
          this.ActivityLogSection()
          
          // Bottom padding to ensure content isn't hidden behind nav bar
          Blank().height(100) 
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Navigation Bar
      this.SimpleBottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  HeaderSection() {
    Column() {
      Text("JUNIPER · #04")
        .fontColor('#7F8C8D')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .letterSpacing(2)
      
      Text("Zen Garden")
        .fontColor('#2C3E50')
        .fontSize(48)
        .fontWeight(FontWeight.Light)
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
    .margin({ bottom: 32 })
  }

  @Builder
  BonsaiVisual() {
    Column() {
      Canvas() {
        drawRect(ctx: CanvasRenderingContext2D, rect: Rect) {
          const w = rect.width;
          const h = rect.height;

          // --- Draw Pot ---
          ctx.fillStyle = '#8D6E63';
          // Pot Body
          ctx.fillRect((w - w * 0.5) / 2, h * 0.85, w * 0.5, h * 0.15);
          // Pot Rim
          ctx.fillStyle = 'rgba(141, 110, 99, 0.8)';
          ctx.fillRect((w - w * 0.5) / 2 - 10, h * 0.85, w * 0.5 + 20, 15);

          // --- Draw Trunk ---
          ctx.strokeStyle = '#5D4037';
          ctx.lineWidth = 25;
          ctx.lineCap = 'round';
          ctx.beginPath();
          ctx.moveTo(w * 0.5, h * 0.85); // Base center
          // Curve up and left
          ctx.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5);
          // Curve right
          ctx.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3);
          ctx.stroke();

          // Secondary Branch
          ctx.lineWidth = 15;
          ctx.beginPath();
          ctx.moveTo(w * 0.38, h * 0.55);
          ctx.lineTo(w * 0.25, h * 0.45);
          ctx.stroke();

          // --- Draw Leaves (Clusters of circles) ---
          // Cluster 1 (Top Right)
          ctx.fillStyle = '#6A8E6A';
          ctx.beginPath(); ctx.arc(w * 0.6, h * 0.25, 45, 0, Math.PI * 2); ctx.fill();
          ctx.fillStyle = 'rgba(106, 142, 106, 0.8)';
          ctx.beginPath(); ctx.arc(w * 0.68, h * 0.28, 35, 0, Math.PI * 2); ctx.fill();
          ctx.fillStyle = 'rgba(106, 142, 106, 0.9)';
          ctx.beginPath(); ctx.arc(w * 0.55, h * 0.22, 30, 0, Math.PI * 2); ctx.fill();

          // Cluster 2 (Middle Left)
          ctx.fillStyle = '#6A8E6A';
          ctx.beginPath(); ctx.arc(w * 0.35, h * 0.5, 35, 0, Math.PI * 2); ctx.fill();
          ctx.fillStyle = 'rgba(106, 142, 106, 0.8)';
          ctx.beginPath(); ctx.arc(w * 0.30, h * 0.45, 25, 0, Math.PI * 2); ctx.fill();

          // Cluster 3 (Far Left Branch)
          ctx.fillStyle = '#6A8E6A';
          ctx.beginPath(); ctx.arc(w * 0.22, h * 0.42, 25, 0, Math.PI * 2); ctx.fill();
        }
      }
      .width(220)
      .height(220)
    }
    .alignItems(HorizontalAlign.Center)
    .margin({ bottom: 32 })
  }

  @Builder
  StatusRow() {
    Row() {
      this.StatusItem($r('app.media.ic_favorite'), "Health", "98%", '#E57373')
      this.StatusItem($r('app.media.ic_date_range'), "Age", "4 Yrs", '#8D6E63')
      this.StatusItem($r('app.media.ic_check_circle'), "Water", "2 Days", '#64B5F6')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  @Builder
  StatusItem(iconSrc: Resource, label: string, value: string, tint: string) {
    Column() {
      Row() {
        Image(iconSrc)
          .width(24)
          .height(24)
          .fillColor(tint)
      }
      .width(50)
      .height(50)
      .borderRadius(25)
      .backgroundColor('#F7F9F9')
      .border({ width: 1, color: '#ECEFF1' })
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Text(value)
        .fontColor('#2C3E50')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 8 })

      Text(label)
        .fontColor('#7F8C8D')
        .fontSize(12)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ActivityLogSection() {
    Column() {
      Row() {
        Text("Care Schedule")
          .fontColor('#2C3E50')
          .fontSize(20)
          .fontWeight(FontWeight.SemiBold)
        
        Blank()

        Row() {
          Text("+")
            .fontColor('#6A8E6A')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
        }
        .width(36)
        .height(36)
        .borderRadius(18)
        .backgroundColor('#E8F5E9')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .onClick(() => {
          // Add Log Action
        })
      }
      .width('100%')
      .margin({ top: 16, bottom: 16 })

      this.CareLogItem("Watering", "Today, 8:00 AM", true)
      this.CareLogItem("Pruning", "Tomorrow", false)
      this.CareLogItem("Fertilizer", "In 5 days", false)
    }
    .width('100%')
  }

  @Builder
  CareLogItem(title: string, subtitle: string, isDone: boolean) {
    Row() {
      // Checkbox Circle
      Row() {
        if (isDone) {
           // Checkmark icon could be added here, simplified to just a colored circle for now
           // or use an image resource
        }
      }
      .width(12)
      .height(12)
      .borderRadius(6)
      .backgroundColor(isDone ? '#6A8E6A' : '#E0E0E0')

      Column() {
        Text(title)
          .fontColor(isDone ? '#2C3E50' : '#7F8C8D')
          .fontSize(16)
        Text(subtitle)
          .fontColor('#9E9E9E')
          .fontSize(12)
          .margin({ top: 2 })
      }
      .margin({ left: 16 })
      .layoutWeight(1)

      if (isDone) {
        Image($r('app.media.ic_check'))
          .width(20)
          .height(20)
          .fillColor('#6A8E6A')
      }
    }
    .width('100%')
    .padding(16)
    .borderRadius(12)
    .backgroundColor('#FAFAFA')
    .border({ width: 1, color: '#F0F0F0' })
    .margin({ bottom: 12 })
  }

  @Builder
  SimpleBottomNav() {
    Row() {
      this.NavIcon($r('app.media.ic_home'), 0)
      this.NavIcon($r('app.media.ic_info'), 1)
      this.NavIcon($r('app.media.ic_settings'), 2)
    }
    .width('100%')
    .height(80)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#F5F5F5', style: BorderStyle.Solid })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  NavIcon(iconSrc: Resource, index: number) {
    Column() {
      Image(iconSrc)
        .width(28)
        .height(28)
        .fillColor(this.currentTab === index ? '#6A8E6A' : '#CFD8DC')
        .onClick(() => {
          this.currentTab = index;
        })

      if (this.currentTab === index) {
        Row()
          .width(4)
          .height(4)
          .borderRadius(2)
          .backgroundColor('#6A8E6A')
          .margin({ top: 4 })
      }
    }
    .alignItems(HorizontalAlign.Center)
  }
}