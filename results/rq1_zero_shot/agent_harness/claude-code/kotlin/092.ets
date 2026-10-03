@Entry
@Component
struct Index {
  private zenGreen: ResourceColor = '#FF6A8E6A'
  private zenGreenLight: ResourceColor = '#FFE8F5E9'
  private zenBrown: ResourceColor = '#FF8D6E63'
  private zenTextPrimary: ResourceColor = '#FF2C3E50'
  private zenTextSecondary: ResourceColor = '#FF7F8C8D'
  private zenWhite: ResourceColor = '#FFFFFFFF'
  private zenAccent: ResourceColor = '#FFD4E157'

  build() {
    Column() {
      Column() {
        this.HeaderSection()

        // Bonsai Visual
        this.BonsaiVisual()

        // Status Row
        this.StatusRow()

        // Activity Log
        this.ActivityLogSection()
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })
      .alignItems(HorizontalAlign.Center)

      this.SimpleBottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.zenWhite)
  }

  @Builder
  HeaderSection() {
    Column() {
      Text('JUNIPER · #04')
        .fontSize(12)
        .fontColor(this.zenTextSecondary)
        .letterSpacing(2)

      Text('Zen Garden')
        .fontSize(32)
        .fontWeight(FontWeight.Lighter)
        .fontColor(this.zenTextPrimary)
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
    .margin({ top: 16 })
  }

  @Builder
  StatusRow() {
    Row() {
      this.StatusItem($r('sys.media.ohos_ic_public_favorite'), 'Health', '98%', '#FFE57373')
      this.StatusItem($r('sys.media.ohos_ic_public_event'), 'Age', '4 Yrs', this.zenBrown)
      this.StatusItem($r('sys.media.ohos_ic_public_check_circle'), 'Water', '2 Days', '#FF64B5F6')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .margin({ top: 32 })
  }

  @Builder
  StatusItem(icon: Resource, label: string, value: string, tint: ResourceColor) {
    Column() {
      Circle({ width: 50, height: 50 })
        .fill('#FFF7F9F9')
        .stroke('#FFECEFF1')
        .strokeWidth(1)
        .width(50)
        .height(50)
        .overlay(
          Image(icon)
            .width(24)
            .height(24)
            .fillColor(tint)
        )

      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.zenTextPrimary)
        .margin({ top: 8 })

      Text(label)
        .fontSize(11)
        .fontColor(this.zenTextSecondary)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ActivityLogSection() {
    Column() {
      Row() {
        Text('Care Schedule')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.zenTextPrimary)
          .layoutWeight(1)

        Circle({ width: 28, height: 28 })
          .fill(this.zenGreenLight)
          .width(28)
          .height(28)
          .overlay(
            Image($r('sys.media.ohos_ic_public_plus'))
              .width(16)
              .height(16)
              .fillColor(this.zenGreen)
          )
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Column() {
        this.CareLogItem('Watering', 'Today, 8:00 AM', true)
        this.CareLogItem('Pruning', 'Tomorrow', false)
        this.CareLogItem('Fertilizer', 'In 5 days', false)
      }
      .margin({ top: 16 })
    }
    .width('100%')
    .margin({ top: 32 })
  }

  @Builder
  CareLogItem(title: string, subtitle: string, isDone: boolean) {
    Row() {
      Circle({ width: 12, height: 12 })
        .fill(isDone ? this.zenGreen : '#FFE0E0E0')
        .width(12)
        .height(12)

      Column() {
        Text(title)
          .fontSize(14)
          .fontColor(isDone ? this.zenTextPrimary : this.zenTextSecondary)

        Text(subtitle)
          .fontSize(11)
          .fontColor('#FF9E9E9E')
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      if (isDone) {
        Image($r('sys.media.ohos_ic_public_check'))
          .width(20)
          .height(20)
          .fillColor(this.zenGreen)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFAFAFA')
    .borderRadius(12)
    .border({ width: 1, color: '#FFF0F0F0' })
    .margin({ bottom: 12 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SimpleBottomNav() {
    Row() {
      this.NavIcon($r('sys.media.ohos_ic_public_home'), true)
      this.NavIcon($r('sys.media.ohos_ic_public_info'), false)
      this.NavIcon($r('sys.media.ohos_ic_public_settings'), false)
    }
    .width('100%')
    .height(80)
    .backgroundColor(this.zenWhite)
    .border({ width: 1, color: '#FFF5F5F5' })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  NavIcon(icon: Resource, isSelected: boolean) {
    Column() {
      Image(icon)
        .width(28)
        .height(28)
        .fillColor(isSelected ? this.zenGreen : '#FFCFD8DC')

      if (isSelected) {
        Circle({ width: 4, height: 4 })
          .fill(this.zenGreen)
          .width(4)
          .height(4)
          .margin({ top: 4 })
      }
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  BonsaiVisual() {
    Canvas(this.bonsaiPaint)
      .width(220)
      .height(220)
      .margin({ top: 32 })
      .onReady(() => {
        this.drawBonsai()
      })
  }

  private bonsaiPaint: CanvasRenderingContext2D = new CanvasRenderingContext2D()

  private drawBonsai(): void {
    const ctx = this.bonsaiPaint
    const w = 220
    const h = 220

    // 1. Draw Pot
    const potWidth = w * 0.5
    const potHeight = h * 0.15
    const potTop = h * 0.85

    ctx.fillStyle = '#FF8D6E63'
    ctx.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight)

    // Pot Rim
    ctx.fillStyle = 'rgba(141, 110, 99, 0.8)'
    ctx.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15)

    // 2. Draw Trunk
    ctx.strokeStyle = '#FF5D4037'
    ctx.lineWidth = 25
    ctx.lineCap = 'round'
    ctx.beginPath()
    ctx.moveTo(w * 0.5, potTop)
    ctx.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5)
    ctx.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3)
    ctx.stroke()

    // Secondary Branch
    ctx.lineWidth = 15
    ctx.beginPath()
    ctx.moveTo(w * 0.38, h * 0.55)
    ctx.lineTo(w * 0.25, h * 0.45)
    ctx.stroke()

    // 3. Draw Leaves (Clusters of circles)
    // Cluster 1 (Top Right)
    ctx.fillStyle = '#FF6A8E6A'
    ctx.beginPath()
    ctx.arc(w * 0.6, h * 0.25, 45, 0, Math.PI * 2)
    ctx.fill()

    ctx.fillStyle = 'rgba(106, 142, 106, 0.8)'
    ctx.beginPath()
    ctx.arc(w * 0.68, h * 0.28, 35, 0, Math.PI * 2)
    ctx.fill()

    ctx.fillStyle = 'rgba(106, 142, 106, 0.9)'
    ctx.beginPath()
    ctx.arc(w * 0.55, h * 0.22, 30, 0, Math.PI * 2)
    ctx.fill()

    // Cluster 2 (Middle Left)
    ctx.fillStyle = '#FF6A8E6A'
    ctx.beginPath()
    ctx.arc(w * 0.35, h * 0.5, 35, 0, Math.PI * 2)
    ctx.fill()

    ctx.fillStyle = 'rgba(106, 142, 106, 0.8)'
    ctx.beginPath()
    ctx.arc(w * 0.30, h * 0.45, 25, 0, Math.PI * 2)
    ctx.fill()

    // Cluster 3 (Far Left Branch)
    ctx.fillStyle = '#FF6A8E6A'
    ctx.beginPath()
    ctx.arc(w * 0.22, h * 0.42, 25, 0, Math.PI * 2)
    ctx.fill()
  }
}
