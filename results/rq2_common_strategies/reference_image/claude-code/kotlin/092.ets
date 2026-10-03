@Entry
@Component
struct ZenBonsaiApp {
  build() {
    Column() {
      Column() {
        HeaderSection()

        BonsaiVisual()
          .width(220)
          .height(220)
          .margin({ top: 32 })

        StatusRow()
          .margin({ top: 32 })

        ActivityLogSection()
          .margin({ top: 32 })
      }
      .width('100%')
      .padding(24)
      .layoutWeight(1)

      SimpleBottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFFFF')
  }
}

@Component
struct HeaderSection {
  build() {
    Column() {
      Text('JUNIPER · #04')
        .fontSize(14)
        .fontColor('#FF7F8C8D')
        .letterSpacing(2)

      Text('Zen Garden')
        .fontSize(48)
        .fontWeight(FontWeight.Lighter)
        .fontColor('#FF2C3E50')
        .margin({ top: 8 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StatusRow {
  build() {
    Row() {
      StatusItem({
        icon: $r('sys.media.ohos_ic_public_heart'),
        label: 'Health',
        value: '98%',
        tint: '#FFE57373'
      })
      .layoutWeight(1)

      StatusItem({
        icon: $r('sys.media.ohos_ic_public_calendar'),
        label: 'Age',
        value: '4 Yrs',
        tint: '#FF8D6E63'
      })
      .layoutWeight(1)

      StatusItem({
        icon: $r('sys.media.ohos_ic_public_check_circle'),
        label: 'Water',
        value: '2 Days',
        tint: '#FF64B5F6'
      })
      .layoutWeight(1)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}

@Component
struct StatusItem {
  icon: ResourceStr = ''
  label: string = ''
  value: string = ''
  tint: string = ''

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Circle({ width: 50, height: 50 })
          .fill('#FFF7F9F9')
          .stroke('#FFECEFF1')
          .strokeWidth(1)

        Image(this.icon)
          .width(24)
          .height(24)
          .fillColor(this.tint)
      }
      .width(50)
      .height(50)

      Text(this.value)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF2C3E50')
        .margin({ top: 8 })

      Text(this.label)
        .fontSize(12)
        .fontColor('#FF7F8C8D')
    }
    .width('100%')
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
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#FF2C3E50')
          .layoutWeight(1)

        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .fill('#FFE8F5E9')
            .width(28)
            .height(28)

          Image($r('sys.media.ohos_ic_public_add'))
            .width(18)
            .height(18)
            .fillColor('#FF6A8E6A')
        }
        .width(28)
        .height(28)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Column({ space: 12 }) {
        CareLogItem({ title: 'Watering', subtitle: 'Today, 8:00 AM', isDone: true })
        CareLogItem({ title: 'Pruning', subtitle: 'Tomorrow', isDone: false })
        CareLogItem({ title: 'Fertilizer', subtitle: 'In 5 days', isDone: false })
      }
      .width('100%')
      .margin({ top: 16 })
    }
    .width('100%')
  }
}

@Component
struct CareLogItem {
  title: string = ''
  subtitle: string = ''
  isDone: boolean = false

  build() {
    Row() {
      Circle()
        .fill(this.isDone ? '#FF6A8E6A' : '#FFE0E0E0')
        .width(12)
        .height(12)

      Column() {
        Text(this.title)
          .fontSize(14)
          .fontColor(this.isDone ? '#FF2C3E50' : '#FF7F8C8D')

        Text(this.subtitle)
          .fontSize(12)
          .fontColor('#FF9E9E9E')
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      if (this.isDone) {
        Image($r('sys.media.ohos_ic_public_check'))
          .width(20)
          .height(20)
          .fillColor('#FF6A8E6A')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFAFAFA')
    .borderRadius(12)
    .border({ width: 1, color: '#FFF0F0F0' })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct SimpleBottomNav {
  build() {
    Row() {
      NavIcon({ icon: $r('sys.media.ohos_ic_public_home'), isSelected: true })
        .layoutWeight(1)

      NavIcon({ icon: $r('sys.media.ohos_ic_public_info'), isSelected: false })
        .layoutWeight(1)

      NavIcon({ icon: $r('sys.media.ohos_ic_public_setting'), isSelected: false })
        .layoutWeight(1)
    }
    .width('100%')
    .height(80)
    .backgroundColor('#FFFFFFFF')
    .border({ width: 1, color: '#FFF5F5F5' })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct NavIcon {
  icon: ResourceStr = ''
  isSelected: boolean = false

  build() {
    Column() {
      Image(this.icon)
        .width(28)
        .height(28)
        .fillColor(this.isSelected ? '#FF6A8E6A' : '#FFCFD8DC')

      if (this.isSelected) {
        Circle()
          .fill('#FF6A8E6A')
          .width(4)
          .height(4)
          .margin({ top: 4 })
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct BonsaiVisual {
  build() {
    Stack({ alignContent: Alignment.BottomCenter }) {
      Canvas() {
        const w = 220
        const h = 220
        const ZenGreen = '#FF6A8E6A'
        const ZenBrown = '#FF8D6E63'
        const TrunkBrown = '#FF5D4037'

        // Pot body
        const potWidth = w * 0.5
        const potHeight = h * 0.15
        const potTop = h * 0.85
        const potLeft = (w - potWidth) / 2

        Rect({
          x: potLeft,
          y: potTop,
          width: potWidth,
          height: potHeight
        })
          .fill(ZenBrown)

        // Pot rim
        Rect({
          x: potLeft - 10,
          y: potTop,
          width: potWidth + 20,
          height: 15
        })
          .fill('#FF7A5D53')

        // Trunk path
        Path()
          .commands(`M ${w * 0.5} ${potTop} Q ${w * 0.45} ${h * 0.6} ${w * 0.35} ${h * 0.5} Q ${w * 0.4} ${h * 0.35} ${w * 0.6} ${h * 0.3}`)
          .stroke(TrunkBrown)
          .strokeWidth(25)
          .strokeLineCap(LineCapStyle.Round)

        // Secondary branch
        Line()
          .startPoint([w * 0.38, h * 0.55])
          .endPoint([w * 0.25, h * 0.45])
          .stroke(TrunkBrown)
          .strokeWidth(15)
          .strokeLineCap(LineCapStyle.Round)

        // Cluster 1 (Top Right)
        Circle({ x: w * 0.6, y: h * 0.25, radius: 45 })
          .fill(ZenGreen)
        Circle({ x: w * 0.68, y: h * 0.28, radius: 35 })
          .fill('#AA6A8E6A')
        Circle({ x: w * 0.55, y: h * 0.22, radius: 30 })
          .fill('#E66A8E6A')

        // Cluster 2 (Middle Left)
        Circle({ x: w * 0.35, y: h * 0.5, radius: 35 })
          .fill(ZenGreen)
        Circle({ x: w * 0.30, y: h * 0.45, radius: 25 })
          .fill('#CC6A8E6A')

        // Cluster 3 (Far Left Branch)
        Circle({ x: w * 0.22, y: h * 0.42, radius: 25 })
          .fill(ZenGreen)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}
