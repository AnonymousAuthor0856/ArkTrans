import { CanvasRenderingContext2D } from '@kit.ArkGraphics';

@Entry
@Component
struct ZenBonsaiAppView {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Main Content Area
      Column() {
        HeaderSection()
          .padding({ top: 24 })

        Blank().height(32)

        BonsaiVisual()
          .width(220).height(220)

        Blank().height(32)

        StatusRow()

        Blank().height(32)

        ActivityLogSection()
          .padding({ bottom: 24 })
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      .backgroundColor('#FFFFFF')
      .padding({ bottom: 80 })

      // Bottom Navigation Bar
      SimpleBottomNav()
        .backgroundColor('#FFFFFF')
    }
    .width('100%').height('100%').backgroundColor('#FFFFFF')
  }
}

@Component
struct HeaderSection {
  build() {
    Column() {
      Text('JUNIPER · #04')
        .fontSize(12).fontWeight(FontWeight.Medium).fontColor('#7F8C8D').letterSpacing(2)
      
      Blank().height(8)
      
      Text('Zen Garden')
        .fontSize(36).fontWeight(FontWeight.Lighter).fontColor('#2C3E50')
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StatusRow {
  build() {
    Row() {
      Blank()
      StatusItem({ icon: 'heart', label: 'Health', value: '98%', tint: '#E57373' })
      Blank()
      StatusItem({ icon: 'calendar', label: 'Age', value: '4 Yrs', tint: '#8D6E63' })
      Blank()
      StatusItem({ icon: 'check', label: 'Water', value: '2 Days', tint: '#64B5F6' })
      Blank()
    }.width('100%')
  }
}

@Component
struct StatusItem {
  private icon: string = ''
  private label: string = ''
  private value: string = ''
  private tint: string = ''

  build() {
    Column() {
      Stack() {
        Circle()
          .fill('#F7F9F9')
          .width(50).height(50)
          .border({ width: 1, color: '#ECEFF1' })
        
        Image($r('app.media.' + this.icon))
          .width(24).height(24)
          .objectFit(ImageFit.Contain)
          .colorFilter(ColorFilter.create(ColorMatrix(), BlendMode.SRC_IN))
          .fillColor(this.tint)
      }

      Blank().height(8)

      Text(this.value)
        .fontSize(16).fontWeight(FontWeight.Bold).fontColor('#2C3E50')
      
      Text(this.label)
        .fontSize(11).fontWeight(FontWeight.Regular).fontColor('#7F8C8D')
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
          .fontSize(16).fontWeight(FontWeight.Medium).fontColor('#2C3E50')
        
        Blank()
        
        Row() {
          Image($r('app.media.add'))
            .width(20).height(20)
            .objectFit(ImageFit.Contain)
            .colorFilter(ColorFilter.create(ColorMatrix(), BlendMode.SRC_IN))
            .fillColor('#6A8E6A')
        }
        .width(28).height(28)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor('#E8F5E9')
        .borderRadius(14)
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
  }
}

@Component
struct CareLogItem {
  private title: string = ''
  private subtitle: string = ''
  private isDone: boolean = false

  build() {
    Row() {
      Circle()
        .fill(this.isDone ? '#6A8E6A' : '#E0E0E0')
        .width(12).height(12)
      
      Blank().width(16)
      
      Column() {
        Text(this.title)
          .fontSize(14).fontWeight(FontWeight.Regular)
          .fontColor(this.isDone ? '#2C3E50' : '#7F8C8D')
        
        Text(this.subtitle)
          .fontSize(11).fontWeight(FontWeight.Regular).fontColor('#9E9E9E')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      if (this.isDone) {
        Image($r('app.media.check'))
          .width(20).height(20)
          .objectFit(ImageFit.Contain)
          .colorFilter(ColorFilter.create(ColorMatrix(), BlendMode.SRC_IN))
          .fillColor('#6A8E6A')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(12)
    .border({ width: 1, color: '#F0F0F0' })
  }
}

@Component
struct SimpleBottomNav {
  build() {
    Column() {
      Divider().color('#F5F5F5')
      
      Row() {
        NavIcon({ icon: 'home', isSelected: true })
        NavIcon({ icon: 'info', isSelected: false })
        NavIcon({ icon: 'settings', isSelected: false })
      }
      .width('100%').height(80)
      .backgroundColor('#FFFFFF')
    }
  }
}

@Component
struct NavIcon {
  private icon: string = ''
  private isSelected: boolean = false

  build() {
    Column() {
      Image($r('app.media.' + this.icon))
        .width(28).height(28)
        .objectFit(ImageFit.Contain)
        .colorFilter(ColorFilter.create(ColorMatrix(), BlendMode.SRC_IN))
        .fillColor(this.isSelected ? '#6A8E6A' : '#CFD8DC')
      
      if (this.isSelected) {
        Blank().height(4)
        Circle()
          .fill('#6A8E6A')
          .width(4).height(4)
      }
    }
    .alignItems(HorizontalAlign.Center)
    .layoutWeight(1)
  }
}

@Component
struct BonsaiVisual {
  build() {
    Canvas(new PaintOptions())
      .drawImage((ctx: CanvasRenderingContext2D) => {
        const w = ctx.canvas.width as number
        const h = ctx.canvas.height as number
        
        // Pot
        ctx.fillStyle = '#8D6E63'
        ctx.fillRect((w - w * 0.5) / 2, h * 0.85, w * 0.5, h * 0.15)
        
        ctx.fillStyle = '#8D6E63' // Opacity handled by alpha usually, simplified here
        ctx.globalAlpha = 0.8
        ctx.fillRect((w - w * 0.5) / 2 - 10, h * 0.85, w * 0.5 + 20, 15)
        ctx.globalAlpha = 1.0

        // Trunk
        ctx.beginPath()
        ctx.moveTo(w * 0.5, h * 0.85)
        ctx.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5)
        ctx.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3)
        ctx.lineWidth = 25
        ctx.lineCap = 'round'
        ctx.strokeStyle = '#5D4037'
        ctx.stroke()

        // Secondary Branch
        ctx.beginPath()
        ctx.moveTo(w * 0.38, h * 0.55)
        ctx.lineTo(w * 0.25, h * 0.45)
        ctx.lineWidth = 15
        ctx.lineCap = 'round'
        ctx.strokeStyle = '#5D4037'
        ctx.stroke()

        // Leaves Cluster 1 (Top Right)
        ctx.fillStyle = '#6A8E6A'
        ctx.beginPath(); ctx.arc(w * 0.6, h * 0.25, 45, 0, Math.PI * 2); ctx.fill()
        
        ctx.globalAlpha = 0.8
        ctx.beginPath(); ctx.arc(w * 0.68, h * 0.28, 35, 0, Math.PI * 2); ctx.fill()
        
        ctx.globalAlpha = 0.9
        ctx.beginPath(); ctx.arc(w * 0.55, h * 0.22, 30, 0, Math.PI * 2); ctx.fill()
        ctx.globalAlpha = 1.0

        // Leaves Cluster 2 (Mid Left)
        ctx.fillStyle = '#6A8E6A'
        ctx.beginPath(); ctx.arc(w * 0.35, h * 0.5, 35, 0, Math.PI * 2); ctx.fill()
        
        ctx.globalAlpha = 0.8
        ctx.beginPath(); ctx.arc(w * 0.30, h * 0.45, 25, 0, Math.PI * 2); ctx.fill()
        ctx.globalAlpha = 1.0

        // Leaves Cluster 3 (Far Left)
        ctx.fillStyle = '#6A8E6A'
        ctx.beginPath(); ctx.arc(w * 0.22, h * 0.42, 25, 0, Math.PI * 2); ctx.fill()
      })
      .width('100%').height('100%')
  }
}