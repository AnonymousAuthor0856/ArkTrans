import { window } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'
import { common } from '@kit.AbilityKit'
import { drawing } from '@kit.ArkGraphics'

// --- Color Palette (Custom Muted Earth Tones) ---
const ZenGreen = '#6A8E6A'
const ZenGreenLight = '#E8F5E9'
const ZenBrown = '#8D6E63'
const ZenTextPrimary = '#2C3E50'
const ZenTextSecondary = '#7F8C8D'
const ZenWhite = '#FFFFFF'
const ZenAccent = '#D4E157'

@Entry
@Component
struct ZenBonsaiApp {
  @State isHomeSelected: boolean = true
  @State isInfoSelected: boolean = false
  @State isSettingsSelected: boolean = false

  aboutToAppear() {
    // Hide System Bars for Immersive Mode
    let context = getContext(this) as common.UIAbilityContext;
    window.getDefaultWindow(context).then((windowClass: window.Window) => {
      try {
        windowClass.setWindowSystemBarEnable([window.SystemBarType.STATUS_BAR], {
          statusBarColor: '#00000000',
          statusBarContentColor: '#00000000'
        });
        windowClass.setWindowLayoutFullScreen(true);
      } catch (e) {
        console.error('Failed to set immersive mode');
      }
    }).catch((err: BusinessError) => {
      console.error(`Failed to get window. Code: ${err.code}, message: ${err.message}`);
    });
  }

  build() {
    Column() {
      // Main Container
      Column() {
        // Header
        this.HeaderSection()

        Row().height(32)

        // Hero Image (Custom Drawing)
        this.BonsaiVisual()

        Row().height(32)

        // Status Cards
        this.StatusRow()

        Row().height(32)

        // Recent Activity
        this.ActivityLogSection()
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24 })
      .backgroundColor(ZenWhite)

      // Bottom Nav
      this.SimpleBottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ZenWhite)
  }

  @Builder
  HeaderSection() {
    Column() {
      Text("JUNIPER · #04")
        .fontColor(ZenTextSecondary)
        .letterSpacing(2)
        .fontSize(12)

      Row().height(8)

      Text("Zen Garden")
        .fontColor(ZenTextPrimary)
        .fontWeight(FontWeight.Lighter)
        .fontSize(24)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  StatusRow() {
    Row() {
      this.StatusItem($r('sys.symbol.heart'), "Health", "98%", "#E57373")
      this.StatusItem($r('sys.symbol.calendar'), "Age", "4 Yrs", ZenBrown)
      this.StatusItem($r('sys.symbol.checkmark.circle'), "Water", "2 Days", "#64B5F6")
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  @Builder
  StatusItem(icon: Resource, label: string, value: string, tint: string) {
    Column() {
      Row() {
        Image(icon)
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

      Row().height(8)

      Text(value)
        .fontColor(ZenTextPrimary)
        .fontWeight(FontWeight.Bold)
        .fontSize(16)

      Text(label)
        .fontColor(ZenTextSecondary)
        .fontSize(12)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ActivityLogSection() {
    Column() {
      Row() {
        Text("Care Schedule")
          .fontColor(ZenTextPrimary)
          .fontWeight(FontWeight.Medium)
          .fontSize(18)

        Blank()

        Row() {
          Image($r('sys.symbol.plus'))
            .width(20)
            .height(20)
            .fillColor(ZenGreen)
        }
        .width(28)
        .height(28)
        .borderRadius(14)
        .backgroundColor(ZenGreenLight)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .onClick(() => {
          // Add Log Action
        })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Row().height(16)

      this.CareLogItem("Watering", "Today, 8:00 AM", true)
      Row().height(12)
      this.CareLogItem("Pruning", "Tomorrow", false)
      Row().height(12)
      this.CareLogItem("Fertilizer", "In 5 days", false)
    }
    .width('100%')
  }

  @Builder
  CareLogItem(title: string, subtitle: string, isDone: boolean) {
    Row() {
      Row()
        .width(12)
        .height(12)
        .borderRadius(6)
        .backgroundColor(isDone ? ZenGreen : '#E0E0E0')

      Row().width(16)

      Column() {
        Text(title)
          .fontColor(isDone ? ZenTextPrimary : ZenTextSecondary)
          .fontSize(14)

        Text(subtitle)
          .fontColor('#9E9E9E')
          .fontSize(12)
      }
      .layoutWeight(1)

      if (isDone) {
        Image($r('sys.symbol.checkmark'))
          .width(20)
          .height(20)
          .fillColor(ZenGreen)
      }
    }
    .width('100%')
    .padding(16)
    .borderRadius(12)
    .backgroundColor('#FAFAFA')
    .border({ width: 1, color: '#F0F0F0' })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SimpleBottomNav() {
    Row() {
      this.NavIcon($r('sys.symbol.house'), this.isHomeSelected, () => {
        this.isHomeSelected = true
        this.isInfoSelected = false
        this.isSettingsSelected = false
      })
      
      this.NavIcon($r('sys.symbol.info.circle'), this.isInfoSelected, () => {
        this.isHomeSelected = false
        this.isInfoSelected = true
        this.isSettingsSelected = false
      })
      
      this.NavIcon($r('sys.symbol.gearshape'), this.isSettingsSelected, () => {
        this.isHomeSelected = false
        this.isInfoSelected = false
        this.isSettingsSelected = true
      })
    }
    .width('100%')
    .height(80)
    .backgroundColor(ZenWhite)
    .border({ width: 1, color: '#F5F5F5' })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  NavIcon(icon: Resource, isSelected: boolean, onClick: () => void) {
    Column() {
      Image(icon)
        .width(28)
        .height(28)
        .fillColor(isSelected ? ZenGreen : '#CFD8DC')
      
      if (isSelected) {
        Row().height(4)
        Row()
          .width(4)
          .height(4)
          .borderRadius(2)
          .backgroundColor(ZenGreen)
      }
    }
    .alignItems(HorizontalAlign.Center)
    .onClick(onClick)
  }

  @Builder
  BonsaiVisual() {
    Canvas({ draw: this.draw })
      .width(220)
      .height(220)
  }

  draw(canvas: CanvasRenderingContext2D, rect: drawing.DrawingRect): void {
    const w = rect.width
    const h = rect.height

    // 1. Draw Pot
    const potWidth = w * 0.5
    const potHeight = h * 0.15
    const potTop = h * 0.85

    canvas.beginPath()
    canvas.rect((w - potWidth) / 2, potTop, potWidth, potHeight)
    canvas.fillStyle = ZenBrown
    canvas.fill()

    // Pot Rim
    canvas.beginPath()
    canvas.rect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15)
    canvas.fillStyle = ZenBrown
    canvas.globalAlpha = 0.8
    canvas.fill()
    canvas.globalAlpha = 1.0

    // 2. Draw Trunk (Bezier curves)
    canvas.beginPath()
    canvas.moveTo(w * 0.5, potTop) // Base center
    // Curve up and left
    canvas.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5)
    // Curve right
    canvas.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3)
    
    canvas.strokeStyle = '#5D4037'
    canvas.lineWidth = 25
    canvas.lineCap = CanvasLineCap.ROUND
    canvas.stroke()

    // Secondary Branch
    canvas.beginPath()
    canvas.moveTo(w * 0.38, h * 0.55)
    canvas.lineTo(w * 0.25, h * 0.45)
    canvas.strokeStyle = '#5D4037'
    canvas.lineWidth = 15
    canvas.lineCap = CanvasLineCap.ROUND
    canvas.stroke()

    // 3. Draw Leaves (Clusters of circles)
    // Cluster 1 (Top Right)
    canvas.beginPath()
    canvas.arc(w * 0.6, h * 0.25, 45, 0, Math.PI * 2)
    canvas.fillStyle = ZenGreen
    canvas.fill()

    canvas.beginPath()
    canvas.arc(w * 0.68, h * 0.28, 35, 0, Math.PI * 2)
    canvas.fillStyle = ZenGreen
    canvas.globalAlpha = 0.8
    canvas.fill()
    canvas.globalAlpha = 1.0

    canvas.beginPath()
    canvas.arc(w * 0.55, h * 0.22, 30, 0, Math.PI * 2)
    canvas.fillStyle = ZenGreen
    canvas.globalAlpha = 0.9
    canvas.fill()
    canvas.globalAlpha = 1.0

    // Cluster 2 (Middle Left)
    canvas.beginPath()
    canvas.arc(w * 0.35, h * 0.5, 35, 0, Math.PI * 2)
    canvas.fillStyle = ZenGreen
    canvas.fill()

    canvas.beginPath()
    canvas.arc(w * 0.30, h * 0.45, 25, 0, Math.PI * 2)
    canvas.fillStyle = ZenGreen
    canvas.globalAlpha = 0.8
    canvas.fill()
    canvas.globalAlpha = 1.0

    // Cluster 3 (Far Left Branch)
    canvas.beginPath()
    canvas.arc(w * 0.22, h * 0.42, 25, 0, Math.PI * 2)
    canvas.fillStyle = ZenGreen
    canvas.fill()
  }
}